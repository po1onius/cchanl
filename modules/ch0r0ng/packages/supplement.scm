
(define-module (ch0r0ng packages supplement)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages commencement)
  #:use-module (guix packages))


(define-public gcc-symlink
  (package
    (name "gcc-symlink")
    (version "0.1")
    (source #f) ; 无源码，仅生成符号链接
    (build-system trivial-build-system)
    (propagated-inputs `(("gcc-toolchain" ,gcc-toolchain))) ; 依赖 GCC 包
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         ;; 创建目标目录结构
         (mkdir-p (string-append %output "/bin"))
         ;; 创建符号链接：cc -> gcc
         (symlink (string-append (assoc-ref %build-inputs "gcc-toolchain") "/bin/gcc")
                  (string-append %output "/bin/cc")))))
    (synopsis "Symbolic link for GCC as 'cc'")
    (description "This package provides a symbolic link from 'cc' to 'gcc'.")
    (home-page "https://www.gnu.org/software/guix/")
    (license #f)))
