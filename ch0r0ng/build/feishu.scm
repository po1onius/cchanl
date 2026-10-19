;;; ch0r0ng/build/feishu.scm —— 飞书（Feishu / Lark）二进制包的构建阶段
;;;
;;; 跟 build/qq.scm 同一套做法，理由也相同：这些过程比较长，放在普通模块里
;;; 可以直接编译检查，比塞在 gexp 里好调。三个阶段：
;;;
;;;   install-feishu  把 .deb 解出来的 opt/ + usr/share 摆成 store 里的布局，
;;;                   顺手修桌面文件、把 product_logo_N.png 补成 hicolor 图标
;;;   patch-elf       给所有 ELF 改 interpreter、写含 $ORIGIN 的 RPATH
;;;   wrap-feishu     生成 bin/feishu wrapper（库路径 / GSettings schema /
;;;                   xdg-utils / 输入法环境）
;;;
;;; 与 build/qq.scm 的差别：
;;;   * 飞书的上游启动器是 opt/bytedance/feishu/bytedance-feishu —— 一个
;;;     Chromium 风格的 bash 脚本（设置 LARK_WRAPPER、把 $HERE 前置进
;;;     LD_LIBRARY_PATH、exec 真正的 feishu）。我们 wrap 这个脚本而不是直接
;;;     wrap ELF，它自己那套逻辑就照旧生效；脚本里的 #!/bin/bash 由
;;;     binary-build-system 的 patch-shebangs 阶段改写成 store 里的 bash。
;;;   * 上游图标叫 product_logo_N.png，桌面文件里写的是 Icon=bytedance-feishu，
;;;     所以按 hicolor 规范建 bytedance-feishu.png 的软链。
;;;   * 飞书 deb 里的 vulcan/chrome-sandbox 有 setuid 位，但 Guix 没法保留它；
;;;     好在系统的 user.max_user_namespaces 很大，Chromium 的 namespace
;;;     沙箱照样能用，所以不需要 --no-sandbox。

(define-module (ch0r0ng build feishu)
  #:use-module (guix build utils)
  #:use-module (srfi srfi-1)
  #:export (install-feishu
            patch-elf
            wrap-feishu))

(define %install-root "/opt/bytedance/feishu")

(define (install-root out)
  (string-append out %install-root))

(define (lib-directories inputs)
  "把 INPUTS 里所有存在的 lib 目录（以及 nss 的 lib/nss）列出来。"
  (delete-duplicates
   (append-map (lambda (input)
                 (let* ((lib (string-append (cdr input) "/lib"))
                        (nss (string-append lib "/nss")))
                   (append (if (file-exists? lib) (list lib) '())
                           (if (file-exists? nss) (list nss) '()))))
               inputs)))

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
飞书的库大量互相依赖（liblark.so ↔ libframe.so ↔ libmonitor.so …），
nixpkgs 的 autoPatchelfHook 会把这些目录也写进 RPATH，这里做同样的事。"
  (delete-duplicates
   (map dirname
        (find-files root
                    (lambda (file stat)
                      (and (not (symbolic-link? file))
                           (string-contains (basename file) ".so")))))))

(define* (install-feishu #:key inputs outputs #:allow-other-keys)
  "把 .deb 里的 opt/ 和 usr/share 装到 OUT，并修好桌面文件和图标。"
  (let* ((out (assoc-ref outputs "out"))
         (base (install-root out)))
    (mkdir-p out)
    (copy-recursively "opt" (string-append out "/opt"))
    (copy-recursively "usr/share" (string-append out "/share"))

    ;; 桌面文件里是 FHS 绝对路径，改成我们自己的 wrapper
    (substitute* (string-append out "/share/applications/bytedance-feishu.desktop")
      (("/usr/bin/bytedance-feishu-stable")
       (string-append out "/bin/feishu")))

    ;; 图标：上游是 product_logo_N.png，桌面文件用的是 Icon=bytedance-feishu
    (for-each
     (lambda (size)
       (let ((src (string-append base "/product_logo_" size ".png"))
             (dst (string-append out "/share/icons/hicolor/"
                                 size "x" size "/apps/bytedance-feishu.png")))
         (when (file-exists? src)
           (mkdir-p (dirname dst))
           (symlink src dst))))
     '("16" "24" "32" "48" "64" "128" "256"))))

(define* (patch-elf #:key inputs outputs #:allow-other-keys)
  "给 OUT 下所有 ELF 设置 Guix 的 interpreter 和含 $ORIGIN 的 RPATH。"
  (let* ((out (assoc-ref outputs "out"))
         (base (install-root out))
         (ld.so (car (find-files (assoc-ref inputs "libc")
                                 "^ld-linux.*\\.so")))
         ;; $ORIGIN 放最前：飞书自带的 libEGL.so / libffmpeg.so / libatomic.so.1
         ;; 等等必须优先于系统同名库
         (rpath (string-join (delete-duplicates
                              (append (list "$ORIGIN")
                                      (bundled-lib-directories base)
                                      (list (string-append out "/lib"))
                                      (lib-directories inputs)))
                             ":")))
    (format #t "patchelf rpath: ~a~%" rpath)
    (for-each
     (lambda (file)
       (when (has-interpreter? file)
         (invoke "patchelf" "--set-interpreter" ld.so file))
       (invoke "patchelf" "--set-rpath" rpath file))
     ;; 跳过软链：上面建的图标软链指向包内文件，跟着改会改到只读的 store 文件
     (find-files out
                 (lambda (file stat)
                   (and (not (symbolic-link? file)) (elf-file? file)))))))

(define* (wrap-feishu #:key inputs outputs bash gsettings gtk glib xdg-utils
                      #:allow-other-keys)
  "生成 OUT/bin/feishu 这个 shell wrapper。"
  (let* ((out (assoc-ref outputs "out"))
         (base (install-root out))
         (vulcan (string-append base "/vulcan"))
         (wrapper (string-append out "/bin/feishu"))
         ;; 自带的库优先（$HERE 由上游启动脚本自己再加一次，没关系）
         (libs (string-join (cons* base vulcan
                                   (string-append out "/lib")
                                   (lib-directories inputs))
                            ":"))
         (data-dirs (string-join (list (string-append out "/share")
                                       gsettings gtk glib)
                                 ":")))
    (mkdir-p (dirname wrapper))
    (call-with-output-file wrapper
      (lambda (port)
        (format port "#!~a~%" bash)
        (format port "# 本文件由 ch0r0ng/build/feishu.scm 生成，请勿手改。~%")
        (format port "export LD_LIBRARY_PATH=\"~a${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}\"~%"
                libs)
        (format port "export XDG_DATA_DIRS=\"~a${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}\"~%"
                data-dirs)
        (format port "export GSETTINGS_SCHEMAS_PATH=\"~a${GSETTINGS_SCHEMAS_PATH:+:$GSETTINGS_SCHEMAS_PATH}\"~%"
                gsettings)
        ;; 上游启动脚本在没有 xdg-settings 时会用自带的 xdg 工具；这里把
        ;; xdg-utils 放进 PATH，走系统那份（含发行版补丁）。
        (format port "export PATH=\"~a${PATH:+:$PATH}\"~%" xdg-utils)
        (format port "~%")
        ;; 走 X11（niri 下由 xwayland-satellite 提供）。nixpkgs 那边也把原生
        ;; Wayland 关掉了：飞书在原生 Wayland 上会崩（nixpkgs#318035）。
        (format port "exec -a \"$0\" \"~a/bytedance-feishu\" \"$@\"~%" base)))
    (chmod wrapper #o555)))

;;; feishu.scm ends here
