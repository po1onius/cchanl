;;; antigravity-cli —— Google Antigravity 的官方 CLI（TUI agent client）。
;;;
;;; 上游发布的是单个预编译 Go ELF 二进制（x86_64 / aarch64 Linux），
;;; 不是源码。nixpkgs 的做法是下载 Google Cloud Storage 上的
;;; cli_linux_{x64,arm64}.tar.gz，把 antigravity 安装成 bin/agy，
;;; 并用 autoPatchelfHook 修 interpreter / RPATH。
;;;
;;; 这里等价地用 copy-build-system：
;;;   * 下载对应架构的 tarball；
;;;   * 把 antigravity 复制成 bin/agy；
;;;   * 只改 interpreter 到 Guix glibc 的 ld.so；
;;;   * 用 wrap-program 设置 LD_LIBRARY_PATH 指向 glibc。
;;;
;;; 注意：patchelf --set-rpath 在这个 Go 二进制上会让它启动即 segfault
;;; （实测 patchelf 0.18），所以 RPATH 交给 wrapper 的 LD_LIBRARY_PATH，
;;; 不用 --set-rpath。
(define-module (ch0r0ng packages antigravity-cli)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages elf)
  #:use-module (nonguix licenses)
  #:export (antigravity-cli))

(define %antigravity-cli-build-id "4821414830800896")

(define-public antigravity-cli
  (package
    (name "antigravity-cli")
    (version "1.5.19")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://storage.googleapis.com/antigravity-public/"
             "antigravity-cli/" version "-" %antigravity-cli-build-id "/"
             (if (string-prefix? "aarch64" (%current-system))
                 "linux-arm/cli_linux_arm64.tar.gz"
                 "linux-x64/cli_linux_x64.tar.gz")))
       (file-name (string-append name "-" version "-" (%current-system)
                                 ".tar.gz"))
       (sha256
        (base32
         (if (string-prefix? "aarch64" (%current-system))
             "1i291dj9mjy1sfwznl7k4p0s1z2pb23f6a9xv2gb8h0dbgs6ycda"
             "145fdplh4x7ayhyz3cfhjaj1mc6pp981ypyzw7a8c27v0ykll6lp")))))
    (build-system copy-build-system)
    (arguments
     (list
      #:strip-binaries? #f
      ;; 二进制本身没有 RPATH；靠下面的 wrapper 设置 LD_LIBRARY_PATH。
      #:validate-runpath? #f
      #:phases
      #~(modify-phases %standard-phases
          (replace 'install
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (bin (string-append out "/bin"))
                     (exe (string-append bin "/agy"))
                     (src (car (find-files "." "^antigravity$")))
                     (glibc (assoc-ref inputs "glibc"))
                     (ld-so (string-append
                             glibc "/"
                             #$(if (string-prefix? "aarch64" (%current-system))
                                   "lib/ld-linux-aarch64.so.1"
                                   "lib/ld-linux-x86-64.so.2"))))
                (mkdir-p bin)
                (copy-file src exe)
                ;; patchelf 和 wrap-program 都要写这个文件，先给可写权限；
                ;; 最后 wrap-program 生成的 wrapper 仍是可执行的。
                (chmod exe #o755)

                ;; 只改 interpreter；不要 --set-rpath，否则这个 Go 二进制
                ;; 会在启动时 segfault。
                (invoke "patchelf" "--set-interpreter" ld-so exe)

                ;; 用 wrapper 提供 glibc 的库路径。
                (wrap-program exe
                  `("LD_LIBRARY_PATH" ":" prefix
                    (,(string-append glibc "/lib")))))))
          (add-after 'install 'check-version
            (lambda* (#:key outputs #:allow-other-keys)
              (invoke (string-append (assoc-ref outputs "out") "/bin/agy")
                      "--version"))))))
    (native-inputs
     (list patchelf))
    (inputs
     (list glibc bash-minimal))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://antigravity.google/")
    (synopsis "Google Antigravity CLI (TUI agent client)")
    (description
     "Antigravity CLI is Google's Go-based terminal user interface agent client.
This package installs the prebuilt @command{agy} executable from Google's
official Linux release archive.  The binary is not built from source.")
    (license (nonfree "https://antigravity.google/"))))
