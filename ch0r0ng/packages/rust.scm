;;; Official prebuilt Rust toolchain, kept separate from Guix's source packages.
(define-module (ch0r0ng packages rust)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix base16)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix search-paths)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages gcc))

;; From https://static.rust-lang.org/dist/channel-rust-1.98.1.toml.
;; Pin both the release date and each component's SHA256; never fetch a moving
;; channel manifest while evaluating the package.
(define %rust-version "1.98.1")
(define %rust-date "2026-09-03")
(define %component-hashes
  '(("rustc"
     "e974f036b28565f37c0f3bd92ddefa809bee16c04f9dcf07b9ed96e05aaaf7c4"
     "89fb83041993b48816514815606f53a5264729b8b449671a6b291e6f0ae74f40")
    ("rust-std"
     "fa3ff450172a16c026944030230c5069947af93c728d9179971d44e5e0cfb561"
     "9bf796a6ec5b004813ebd0b650775a7c6a4f3aae97ad362ae294798dca4f3b23")
    ("cargo"
     "ea1de9f9e23107d97ee2b41a72c552f34064a593da503789218387aee59f3ba4"
     "c09425a7f300af148c0bdfded0e7d5f1fe7c075b2b9674e8935afa769297b2f6")
    ("rustfmt"
     "b29a1addcbf2aa8f5785075605700e63cbe131b08c8334b50c09cfca8bbc51dc"
     "7d4c136278b61096d46ef23019c29acb7ee5a2a1412cbfee5050316110c6fd8c")
    ("clippy"
     "e167f333be24e1d5eea56ea563c7def0aa0bd613f5ce3445976c93b0288799d1"
     "396e17c0a669399823d0e59073686a4e5f50b2d41f062f1d3afc9210f9d3553d")))

(define (rust-component name)
  (let* ((system (%current-system))
         (arm? (string=? system "aarch64-linux"))
         (target (cond
                  (arm? "aarch64-unknown-linux-gnu")
                  ((string=? system "x86_64-linux")
                   "x86_64-unknown-linux-gnu")
                  (else (error "Unsupported Rust binary system" system)))))
    (origin
      (method url-fetch)
      (uri (string-append "https://static.rust-lang.org/dist/" %rust-date
                          "/" name "-" %rust-version "-" target ".tar.xz"))
      (sha256
       (base16-string->bytevector
        ((if arm? cadr car) (assoc-ref %component-hashes name)))))))

(define %smoke-test
  (local-file (dirname (canonicalize-path
                       (search-path
                        %load-path
                        "ch0r0ng/packages/rust/smoke-test/Cargo.toml")))
              #:recursive? #t))

(define-public rust-bin
  (package
    (name "rust-bin")
    (version %rust-version)
    (source (rust-component "rustc"))
    (build-system gnu-build-system)
    ;; Keep the toolchain together for upstream sysroot/tool discovery.  The
    ;; cargo output is a compatibility view for cargo-build-system's #:rust.
    (outputs '("out" "cargo"))
    (arguments
     (list
      #:strip-binaries? #f               ;Preserve Rust metadata in libraries.
      #:modules '((guix build gnu-build-system)
                  (guix build utils)
                  (ice-9 popen)
                  (ice-9 textual-ports))
      #:phases
      #~(modify-phases %standard-phases
          (delete 'bootstrap)
          (delete 'configure)
          (delete 'build)
          (delete 'check)
          (replace 'install
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let ((out (assoc-ref outputs "out")))
                (define (install-component)
                  (invoke "sh" "install.sh"
                          (string-append "--prefix=" out)
                          "--disable-ldconfig"))
                (install-component)
                (for-each
                 (lambda (name)
                   (mkdir name)
                   (with-directory-excursion name
                     (invoke "tar" "xf"
                             (assoc-ref inputs
                                        (string-append "component-" name))
                             "--strip-components=1")
                     (install-component)))
                 '("rust-std" "cargo" "rustfmt" "clippy"))
                ;; These are mutable installer bookkeeping, not toolchain data.
                (for-each
                 delete-file
                 (find-files (string-append out "/lib/rustlib")
                             "^(install.log|manifest-.*|uninstall.sh)$")))))
          (add-after 'install 'patch-elf
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (libc (dirname
                            (search-input-file inputs "/lib/libc.so.6")))
                     (gcc-lib (dirname
                               (search-input-file inputs "/lib/libgcc_s.so.1")))
                     (zlib (dirname
                            (search-input-file inputs "/lib/libz.so.1")))
                     (interpreter
                      (search-input-file inputs #$(glibc-dynamic-linker))))
                (for-each
                 (lambda (file)
                   (let* ((port (open-pipe* OPEN_READ "readelf" "-l" file))
                          (headers (get-string-all port)))
                     (unless (zero? (close-pipe port))
                       (error "Cannot inspect ELF program headers" file))
                     (when (string-contains headers "INTERP")
                       (invoke "patchelf" "--set-interpreter" interpreter file))
                     ;; Do not treat relocatable objects or static executables
                     ;; as dynamic ELF files merely because they have ELF magic.
                     (when (string-contains headers "DYNAMIC")
                       (invoke "patchelf" "--set-rpath"
                               (string-join
                                (list "$ORIGIN" (string-append out "/lib")
                                      libc gcc-lib zlib) ":")
                               file))))
                 (find-files out
                             (lambda (file stat)
                               (and (eq? 'regular (stat:type stat))
                                    (elf-file? file))))))))
          (add-after 'patch-elf 'wrap-toolchain
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (bin (string-append out "/bin"))
                     (cc (assoc-ref inputs "gcc-toolchain"))
                     (cc-bin (string-append out "/libexec/rust-bin"))
                     (libc (dirname
                            (search-input-file inputs "/lib/libc.so.6")))
                     (sh (search-input-file inputs "/bin/sh")))
                ;; Upstream rustc invokes "cc", but Guix's GCC toolchain only
                ;; supplies "gcc".  Keep this alias private to the toolchain.
                (mkdir-p cc-bin)
                (symlink (string-append cc "/bin/gcc")
                         (string-append cc-bin "/cc"))
                (for-each
                 (lambda (name)
                   (let ((program (string-append bin "/" name)))
                     ;; Keep Guix's ld-wrapper involved in native linking.
                     ;; Upstream x86-64 Rust defaults to its bundled LLD.
                     (when (and #$(string=? (%current-system) "x86_64-linux")
                                (member name '("rustc" "rustdoc"
                                               "clippy-driver")))
                       (rename-file program (string-append program "-real"))
                       (call-with-output-file program
                         (lambda (port)
                           (format port "#!~a~%" sh)
                           ;; Cargo invokes clippy-driver as a RUSTC_WRAPPER:
                           ;; its first argument must remain the rustc path.
                           (when (string=? name "clippy-driver")
                             (display
                              "case \"${1-}\" in rustc|*/rustc)\n"
                              port)
                             (display "rust_bin_compiler=$1; shift\n" port)
                             (format port
                                     (string-append
                                      "exec ~a-real \"$rust_bin_compiler\""
                                      " -C linker-features=-lld"
                                      " \"$@\";;~%esac~%")
                                     program))
                           (format port
                                   (string-append
                                    "exec ~a-real -C linker-features=-lld"
                                    " \"$@\"~%")
                                   program)))
                       (chmod program #o555))
                     (wrap-program program
                       `("PATH" ":" prefix (,bin))
                       `("PATH" ":" suffix
                         (,cc-bin ,(string-append cc "/bin")))
                       `("LIBRARY_PATH" ":" suffix (,libc)))))
                 '("rustc" "rustdoc" "cargo" "cargo-fmt" "rustfmt"
                   "cargo-clippy" "clippy-driver"))
                (let ((cargo-bin (string-append (assoc-ref outputs "cargo")
                                                "/bin")))
                  (mkdir-p cargo-bin)
                  (symlink (string-append bin "/cargo")
                           (string-append cargo-bin "/cargo"))))))
          (add-after 'wrap-toolchain 'check-installed-toolchain
            (lambda* (#:key tests? outputs #:allow-other-keys)
              (when tests?
                (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
                  (setenv "PATH" (string-append bin ":" (getenv "PATH")))
                  (setenv "CARGO_HOME" (string-append (getcwd) "/cargo-home"))
                  (for-each (lambda (name) (invoke name "--version"))
                            '("rustc" "rustdoc" "cargo" "rustfmt"
                              "clippy-driver"))
                  (copy-recursively #$%smoke-test "smoke-test")
                  (with-directory-excursion "smoke-test"
                    (invoke "rustc" "--edition=2024" "src/main.rs"
                            "-o" "hello")
                    (invoke "./hello")
                    (invoke "cargo" "test" "--offline")
                    (invoke "cargo" "run" "--offline")
                    (invoke "cargo" "fmt" "--check")
                    (invoke "cargo" "clippy" "--offline" "--" "-Dwarnings")
                    (invoke "cargo" "doc" "--offline" "--no-deps")))))))))
    (native-inputs
     (append (list (list "patchelf" patchelf) (list "xz" xz))
             (map (lambda (name)
                    (list (string-append "component-" name)
                          (rust-component name)))
                  '("rust-std" "cargo" "rustfmt" "clippy"))))
    (inputs (list (list "bash-minimal" bash-minimal)
                  (list "glibc" glibc)
                  (list "gcc:lib" gcc "lib")
                  (list "gcc-toolchain" gcc-toolchain)
                  (list "zlib" zlib)))
    (native-search-paths %gcc-search-paths)
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://www.rust-lang.org")
    (synopsis "Prebuilt Rust compiler and development tools")
    (description
     "This package installs the official prebuilt Rust compiler, standard
library, Cargo, rustfmt, and Clippy for native GNU/Linux development.  ELF
interpreters and library paths are adapted to Guix.  The toolchain is pinned
to one release and does not use rustup or download components at run time.
Unlike Guix's rust package, this package does not build Rust from source.
The cargo output provides compatibility with cargo-build-system.")
    (license (list license:asl2.0 license:expat))))
