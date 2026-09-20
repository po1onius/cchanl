;;; ch0r0ng/build/qq.scm —— QQ 二进制包的构建阶段（构建端代码）
;;;
;;; 放在这里而不是 packages/qq.scm 的 gexp 里，一是这些过程比较长，
;;; 二是普通模块可以直接编译检查（gexp 里的代码只有真正构建时才编译）。
;;;
;;; 三个阶段：
;;;   install-qq  把 .deb 解出来的 opt/ + usr/share 摆成 store 里的布局
;;;   patch-elf   给所有 ELF 改 interpreter 和 RPATH（保留 $ORIGIN）
;;;   wrap-qq     生成 bin/qq shell wrapper（库路径 / GSettings / Wayland
;;;               输入法 / 关闭自动更新）
;;;
;;; 注：wrap-qq 没有用 Guix 的 wrap-program，因为那个只支持设置环境变量，
;;; 不支持「Wayland 下追加参数」「按需写 config.json」这种 shell 片段。

(define-module (ch0r0ng build qq)
  #:use-module (guix build utils)
  #:use-module (srfi srfi-1)
  #:export (install-qq
            patch-elf
            wrap-qq))

(define (lib-directories inputs)
  "把 INPUTS 里所有存在的 lib 目录（以及 nss 的 lib/nss）列出来。"
  (delete-duplicates
   (append-map (lambda (input)
                 (let* ((lib (string-append (cdr input) "/lib"))
                        (nss (string-append lib "/nss")))
                   (append (if (file-exists? lib) (list lib) '())
                           (if (file-exists? nss) (list nss) '()))))
               inputs)))

(define* (install-qq #:key inputs outputs #:allow-other-keys)
  "把 .deb 里的 opt/QQ 和 usr/share 装到 OUT，并修好桌面文件/软链。"
  (let* ((out (assoc-ref outputs "out"))
         (qq (string-append out "/opt/QQ")))
    (mkdir-p out)
    (copy-recursively "opt" (string-append out "/opt"))
    (copy-recursively "usr/share" (string-append out "/share"))

    ;; 上游自带的 libssh2 在 Guix 上不能用（链的是它自带的 openssl 1.1），
    ;; 删掉，改用系统那份（在 RPATH / LD_LIBRARY_PATH 里）。
    (delete-file (string-append qq "/resources/app/libssh2.so.1"))

    ;; 桌面文件里全是 FHS 绝对路径，改成 store 里的。
    (substitute* (string-append out "/share/applications/qq.desktop")
      (("Exec=/opt/QQ/qq") (string-append "Exec=" out "/bin/qq"))
      (("Icon=/usr/share") (string-append "Icon=" out "/share")))

    ;; 托盘图标：QQ 运行时按【无版本号】的名字 dlopen 这两个库，Guix 包一般
    ;; 只装 libfoo.so.N，所以这里补软链。
    (for-each
     (lambda (spec)
       (let* ((name (car spec))
              (dir (assoc-ref inputs (cdr spec)))
              (target (string-append qq "/" name ".so"))
              (found (and dir (find-files (string-append dir "/lib")
                                          (string-append "^" name "\\.so")))))
         (if (or (not dir) (null? found))
             (format (current-error-port)
                     "qq: 警告：找不到 ~a（来自 ~a），跳过软链~%"
                     name (cdr spec))
             (symlink (car found) target))))
     '(("libappindicator3" . "libappindicator")
       ("libnotify" . "libnotify")))))

(define (has-interpreter? file)
  "FILE 是否是有 PT_INTERP 的可执行文件（共享库没有）。
patchelf 对没有 .interp 的文件 --print-interpreter 会报错，这里当 #f 处理，
顺便把它的输出丢掉免得刷屏。"
  (let ((sink (open-output-string)))
    (with-output-to-port sink
      (lambda ()
        (with-error-to-port sink
          (lambda ()
            (false-if-exception
             (begin (invoke "patchelf" "--print-interpreter" file) #t))))))))

(define (bundled-lib-directories root)
  "列出 ROOT 下所有含 .so 的目录。
nixpkgs 的 autoPatchelfHook 也会在包内部找依赖库并把对应目录写进 RPATH，
这里做同样的事：QQ 的 sharp-lib/libvips-cpp.so.42、avsdk/libbugly.so 之类
都是包内互相依赖的。"
  (delete-duplicates
   (map dirname
        (find-files root
                    (lambda (file stat)
                      (and (not (symbolic-link? file))
                           (string-contains (basename file) ".so")))))))

(define* (patch-elf #:key inputs outputs #:allow-other-keys)
  "给 OUT 下所有 ELF 设置 Guix 的 interpreter 和含 $ORIGIN 的 RPATH。"
  (let* ((out (assoc-ref outputs "out"))
         (qq (string-append out "/opt/QQ"))
         (ld.so (car (find-files (assoc-ref inputs "libc")
                                 "^ld-linux.*\\.so")))
         ;; $ORIGIN 放最前：同目录的自带库优先于系统库
         (rpath (string-join (delete-duplicates
                              (append (list "$ORIGIN")
                                      (bundled-lib-directories qq)
                                      (list (string-append out "/lib"))
                                      (lib-directories inputs)))
                             ":")))
    (format #t "patchelf rpath: ~a~%" rpath)
    (for-each
     (lambda (file)
       (when (has-interpreter? file)
         (invoke "patchelf" "--set-interpreter" ld.so file))
       (invoke "patchelf" "--set-rpath" rpath file))
     ;; 跳过软链：打包时我们会建 libnotify.so 之类指向 store 的软链，
     ;; 跟着它去 patch 会改到只读的 store 文件（EROFS）。
     (find-files out
                 (lambda (file stat)
                   (and (not (symbolic-link? file)) (elf-file? file)))))))

(define* (wrap-qq #:key inputs outputs bash
                  gsettings gtk glib internal-version
                  #:allow-other-keys)
  "生成 OUT/bin/qq 这个 shell wrapper。"
  (let* ((out (assoc-ref outputs "out"))
         (qq (string-append out "/opt/QQ"))
         (wrapper (string-append out "/bin/qq"))
         (libs (string-join (cons qq (lib-directories inputs)) ":"))
         (data-dirs (string-join (list gsettings gtk glib) ":")))
    (mkdir-p (dirname wrapper))
    (call-with-output-file wrapper
      (lambda (port)
        (format port "#!~a~%" bash)
        (format port "# 本文件由 ch0r0ng/build/qq.scm 生成，请勿手改。~%")
        (format port "export LD_LIBRARY_PATH=\"~a${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}\"~%"
                libs)
        (format port "export XDG_DATA_DIRS=\"~a${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}\"~%"
                data-dirs)
        (format port "export GSETTINGS_SCHEMAS_PATH=\"~a${GSETTINGS_SCHEMAS_PATH:+:$GSETTINGS_SCHEMAS_PATH}\"~%"
                gsettings)
        ;; Electron >= 28 认得这个变量，会自动决定用 Wayland 还是 X11
        (format port "export ELECTRON_OZONE_PLATFORM_HINT=\"auto\"~%")
        (format port "export INTERNAL_VERSION=\"~a\"~%" internal-version)
        (format port "~%")
        ;; Wayland 下的输入法（fcitx5）：nixpkgs 也是这么加的
        (format port "if [ \"${XDG_SESSION_TYPE:-}\" = wayland ]; then~%")
        (format port "    set -- --enable-wayland-ime=true \\~%")
        (format port "        --wayland-text-input-version=3 \"$@\"~%")
        (format port "fi~%")
        (format port "~%")
        ;; 关掉自动更新：QQ 的更新器会试图覆盖只读的 /gnu/store 里的文件，
        ;; 先把 config.json 写好并设成只读。
        (format port "conf=\"$HOME/.config/QQ/versions/config.json\"~%")
        (format port "if [ ! -f \"$conf\" ] || \\~%")
        (format port "   ! grep -q \"$INTERNAL_VERSION\" \"$conf\" 2>/dev/null; then~%")
        (format port "    mkdir -p \"$(dirname \"$conf\")\"~%")
        (format port "    chmod u+w \"$conf\" 2>/dev/null || true~%")
        (format port "    printf '{\\n  \"baseVersion\": \"%s\",\\n  \"curVersion\": \"%s\",\\n  \"buildId\": \"%s\"\\n}\\n' \\~%")
        (format port "        \"$INTERNAL_VERSION\" \"$INTERNAL_VERSION\" \\~%")
        (format port "        \"${INTERNAL_VERSION##*-}\" > \"$conf\"~%")
        (format port "    chmod u-w \"$conf\" 2>/dev/null || true~%")
        (format port "fi~%")
        (format port "~%")
        (format port "exec -a \"$0\" \"~a/qq\" \"$@\"~%" qq)))
    (chmod wrapper #o555)))

;;; qq.scm ends here
