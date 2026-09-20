;;; ch0r0ng/build/wemeet.scm —— 腾讯会议二进制包的构建阶段（构建端代码）
;;;
;;; 和 QQ 那个一样，放在普通模块里便于单独编译检查。
;;;
;;; 三个阶段：
;;;   install-wemeet  摆布局：opt/wemeet -> $out/app/wemeet，修 qt.conf /
;;;                   桌面文件 / 软链 / 图标，并打上 nixpkgs 里那个协程寄存器补丁
;;;   patch-elf       给所有 ELF 改 interpreter 和 RPATH（保留 $ORIGIN，
;;;                   并把包内自带库目录也写进去）
;;;   wrap-wemeet     生成 bin/wemeet 和 bin/wemeet-xwayland 两个 wrapper

(define-module (ch0r0ng build wemeet)
  #:use-module (guix build utils)
  #:use-module (srfi srfi-1)
  #:use-module (rnrs bytevectors)
  #:use-module (rnrs io ports)
  #:export (install-wemeet
            patch-elf
            wrap-wemeet))

(define (lib-directories inputs)
  "把 INPUTS 里所有存在的 lib 目录（以及 nss 的 lib/nss）列出来。"
  (delete-duplicates
   (append-map (lambda (input)
                 (let* ((lib (string-append (cdr input) "/lib"))
                        (nss (string-append lib "/nss")))
                   (append (if (file-exists? lib) (list lib) '())
                           (if (file-exists? nss) (list nss) '()))))
               inputs)))

(define (bundled-lib-directories root)
  "列出 ROOT 下所有含 .so 的目录（包内互相依赖的库：如 lib/libwemeet_base.so、
plugins/platforms/libqxcb.so 等）。"
  (delete-duplicates
   (map dirname
        (find-files root
                    (lambda (file stat)
                      (and (not (symbolic-link? file))
                           (string-contains (basename file) ".so")))))))

(define (patch-bytes! file offset expected replacement)
  "把 FILE 偏移 OFFSET 处的 EXPECTED 字节改成 REPLACEMENT，前提是读出来必须
等于 EXPECTED（上游换了版本就报错，免得改坏文件）。"
  (let ((port (open-file file "r+b")))
    (dynamic-wind
      (lambda () #t)
      (lambda ()
        (seek port offset SEEK_SET)
        (let ((got (get-bytevector-n port (length expected))))
          (unless (equal? (bytevector->u8-list got) expected)
            (error "wemeet: 补丁位置的字节和预期不符，上游版本可能变了" file got))
          (seek port offset SEEK_SET)
          (put-bytevector port (u8-list->bytevector replacement))))
      (lambda () (close-port port)))))

(define* (install-wemeet #:key outputs #:allow-other-keys)
  "把 .deb 里的 opt/wemeet 装到 OUT/app/wemeet，并修好各种路径。"
  (let* ((out (assoc-ref outputs "out"))
         (app (string-append out "/app/wemeet")))
    (mkdir-p (string-append out "/app"))
    (copy-recursively "opt/wemeet" app)
    (copy-recursively "usr/share" (string-append out "/share"))

    ;; 桌面文件里是 /opt/wemeet/... 的绝对路径
    (substitute* (string-append out "/share/applications/wemeetapp.desktop")
      (("/opt/wemeet/wemeetapp.sh") (string-append out "/bin/wemeet"))
      (("/opt/wemeet/wemeet.svg") "wemeet"))

    ;; 自带 Qt 的 qt.conf：Prefix 本来是 ../（相对 FHS 的 /opt/wemeet），
    ;; 改成绝对路径，这样 plugins/translations 才找得到。
    (substitute* (string-append app "/bin/qt.conf")
      (("Prefix = ../") (string-append "Prefix = " app "/lib")))

    ;; Qt 从 lib/ 里找 plugins/resources/translations，xcast 从 bin/ 里找它
    ;; 自己的配置。nixpkgs 也是靠这几个软链。
    (for-each
     (lambda (spec)
       (let* ((link (string-append app (car spec)))
              (target (cdr spec)))
         ;; 软链内容写成相对路径（跟着 lib/ 或 bin/ 走），
         ;; 但判断「源是否存在」要相对 link 所在目录解析。
         (when (file-exists? (string-append (dirname link) "/" target))
           (symlink target link))))
     '(("/lib/plugins" . "../plugins")
       ("/lib/resources" . "../resources")
       ("/lib/translations" . "../translations")
       ("/bin/xcast.conf" . "raw/xcast.conf")))

    ;; 图标
    (when (file-exists? (string-append app "/icons"))
      (copy-recursively (string-append app "/icons")
                        (string-append out "/share/icons")))
    (install-file (string-append app "/wemeet.svg")
                  (string-append out "/share/icons/hicolor/scalable/apps"))

    ;; nixpkgs 里那个补丁：libwemeet_base.so 里 co_jump_to_link 用的是
    ;; 旧寄存器（cmp rdi, 0），换成交互时用的 r12 才不会崩：
    ;;   48 83 ff 00  ->  49 83 fc 00
    (patch-bytes! (string-append app "/lib/libwemeet_base.so")
                  #x94c833
                  '(#x48 #x83 #xff #x00)
                  '(#x49 #x83 #xfc #x00))))

(define (has-interpreter? file)
  "FILE 是否是有 PT_INTERP 的可执行文件。patchelf 对共享库
--print-interpreter 会报错，这里当 #f，顺便把输出丢掉免得刷屏。"
  (let ((sink (open-output-string)))
    (with-output-to-port sink
      (lambda ()
        (with-error-to-port sink
          (lambda ()
            (false-if-exception
             (begin (invoke "patchelf" "--print-interpreter" file) #t))))))))

(define* (patch-elf #:key inputs outputs #:allow-other-keys)
  "给 OUT 下所有 ELF 设置 Guix 的 interpreter 和含 $ORIGIN 的 RPATH。"
  (let* ((out (assoc-ref outputs "out"))
         (app (string-append out "/app/wemeet"))
         (ld.so (car (find-files (assoc-ref inputs "libc")
                                 "^ld-linux.*\\.so")))
         (rpath (string-join (delete-duplicates
                              (append (list "$ORIGIN")
                                      (bundled-lib-directories app)
                                      (list (string-append out "/lib"))
                                      (lib-directories inputs)))
                             ":")))
    (format #t "patchelf rpath: ~a~%" rpath)
    (for-each
     (lambda (file)
       (when (has-interpreter? file)
         (invoke "patchelf" "--set-interpreter" ld.so file))
       (invoke "patchelf" "--set-rpath" rpath file))
     (find-files out
                 (lambda (file stat)
                   (and (not (symbolic-link? file)) (elf-file? file)))))))

(define* (wrap-wemeet #:key inputs outputs bash shims xkb
                      #:allow-other-keys)
  "生成 bin/wemeet（原生 Wayland）和 bin/wemeet-xwayland（强制走 XWayland）。
环境变量照抄 nixpkgs：QT_PLUGIN_PATH / QT_STYLE_OVERRIDE / IBUS_USE_PORTAL /
LP_NUM_THREADS / XKB_CONFIG_ROOT，另外 LD_PRELOAD 四个修补库（见 packages/wemeet.scm
里的 wemeet-shims）。bin/wemeet 还会设 WEMEET_XWAYLAND=1，让 screen_share 模块走
XDG Desktop Portal 抓屏而不是 X11 抓屏。

不 LD_PRELOAD 已废弃的 wemeet-wayland-screenshare hook：wemeet >= 3.26.10 官方自己
支持 Wayland 共享屏幕，而那个 hook 会让它一按「共享屏幕」就崩。"
  (let* ((out (assoc-ref outputs "out"))
         (app (string-append out "/app/wemeet"))
         (libs (string-join (delete-duplicates
                             (append (list (string-append app "/lib")
                                           (string-append app "/translations"))
                                     (lib-directories inputs)))
                            ":"))
         (preload (string-join (list (string-append shims "/libwemeetwrap.so")
                                     (string-append shims "/libwemeet-x11-fix.so")
                                     (string-append shims "/libwemeet-camera-fix.so")
                                     (string-append shims "/libwemeet-portal-format-fix.so"))
                               ":")))
    (define (write-wrapper name extra)
      (let ((file (string-append out "/bin/" name)))
        (mkdir-p (dirname file))
        (call-with-output-file file
          (lambda (port)
            (format port "#!~a~%" bash)
            (format port "# 本文件由 ch0r0ng/build/wemeet.scm 生成，请勿手改。~%")
            (format port "export LD_LIBRARY_PATH=\"~a${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}\"~%"
                    libs)
            (format port "export QT_PLUGIN_PATH=\"~a/plugins${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}\"~%"
                    app)
            (format port "export PATH=\"~a/bin${PATH:+:$PATH}\"~%" app)
            (format port "export XKB_CONFIG_ROOT=\"~a\"~%" xkb)
            (format port "export QT_STYLE_OVERRIDE=\"fusion\"~%")
            (format port "export IBUS_USE_PORTAL=\"1\"~%")
            ;; 限制渲染线程数（nixpkgs 的做法）
            (format port "export LP_NUM_THREADS=\"2\"~%")
            (format port "export LD_PRELOAD=\"~a${LD_PRELOAD:+:$LD_PRELOAD}\"~%"
                    preload)
            (display extra port)
            (format port "exec -a \"$0\" \"~a/bin/wemeetapp\" \"$@\"~%" app)))
        (chmod file #o555)))
    ;; 纯 Wayland 启动：必须设 WEMEET_XWAYLAND=1。
    ;; 反汇编 screen_share 模块的 IsUseXDGDesktopPortal()（util.cc）：
    ;;     return (getenv("WEMEET_XWAYLAND") ?: "") == "1";
    ;; 也就是【只有】该变量等于 "1" 时才走 XDG Desktop Portal 抓屏，否则退回 X11
    ;; 抓屏 —— 在 Wayland 会话里 X11 根窗口是空的，于是共享时不显示捕获预览
    ;; （蓝色方块）、开始共享后整块绿屏。变量名为 xwayland 是因为语义是
    ;; "本进程跑在 XWayland 下，X11 根窗口没意义，请改用 portal"。
    (write-wrapper "wemeet" "export WEMEET_XWAYLAND=\"1\"\n")
    ;; wemeet-xwayland 和厂商 wemeetapp.sh 在 Wayland 下的行为一致：
    ;; 强制走 XWayland，并设置 WEMEET_XWAYLAND=1（nixpkgs 少设了后者）。
    (write-wrapper "wemeet-xwayland"
                   (string-append
                    "export XDG_SESSION_TYPE=\"x11\"\n"
                    "export QT_QPA_PLATFORM=\"xcb\"\n"
                    "unset WAYLAND_DISPLAY\n"
                    "export WEMEET_XWAYLAND=\"1\"\n"))))

;;; wemeet.scm ends here
