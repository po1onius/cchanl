;;; SPDX-License-Identifier: GPL-3.0-or-later
(define-module (ch0r0ng build rustup)
  #:use-module (guix build utils)
  #:use-module (ice-9 ftw)
  #:use-module (ice-9 popen)
  #:use-module (ice-9 textual-ports)
  #:use-module (srfi srfi-1)
  #:export (install-components patch-toolchain wrap-toolchain check-toolchain))

(define (command-output . args)
  (let* ((port (apply open-pipe* OPEN_READ args))
         (text (get-string-all port))
         (status (close-pipe port)))
    (unless (zero? status) (error "Command failed" args status))
    text))

(define (install-components inputs labels out)
  (setenv "CFG_DISABLE_LDCONFIG" "1")
  (for-each
   (lambda (label)
     (mkdir label)
     (with-directory-excursion label
       (invoke "tar" "xf" (assoc-ref inputs label))
       (let ((installers (find-files "." "^install\\.sh$")))
         (unless (= 1 (length installers))
           (error "Expected exactly one Rust component installer" label installers))
         (invoke "bash" (car installers) (string-append "--prefix=" out)
                 "--disable-ldconfig"))))
   labels))

(define (patch-toolchain out host interpreter libraries)
  ;; Never mutate cross-target libraries, source fixtures, or relocatable .o
  ;; files. Modern Rust also ships PIE executables and host tools in rustlib.
  (let ((roots (filter file-exists?
                      (list (string-append out "/bin")
                            (string-append out "/libexec")
                            (string-append out "/lib/rustlib/" host "/bin")
                            (string-append out "/lib/rustlib/" host "/lib")))))
    (define (patch file)
      (when (and (elf-file? file)
                 (string-contains (command-output "readelf" "-d" file) "(NEEDED)"))
        (when (string-contains (command-output "readelf" "-l" file) "INTERP")
          (invoke "patchelf" "--set-interpreter" interpreter file))
        (invoke "patchelf" "--set-rpath"
                (string-join (delete-duplicates
                              (append (list "$ORIGIN" (dirname file)
                                            (string-append out "/lib")) libraries)) ":")
                file)))
    (for-each patch (append-map (lambda (root) (find-files root ".*")) roots))
    ;; Shared compiler/LLVM libraries live directly under lib, alongside
    ;; rustlib. Avoid recursively walking the target sysroots here.
    (let ((lib (string-append out "/lib")))
      (for-each patch
                (map (lambda (name) (string-append lib "/" name))
                     (scandir lib (lambda (name) (string-contains name ".so"))))))))

(define (wrap-toolchain out cc libc gcc-lib host disable-lld?)
  (for-each
   (lambda (name)
     (let ((file (string-append out "/bin/" name)))
       (when (file-exists? file)
         ;; Since Rust 1.90 the default x86_64 Linux linker is bundled LLD.
         ;; It bypasses Guix's ld wrapper and loses dependency RUNPATHs.
         ;; Use the Guix linker for native compilation; leave explicit cross
         ;; targets alone. User codegen arguments follow and can override this.
         (when (and disable-lld? (not (string=? name "cargo")))
           (let ((real (string-append file "-real")))
             (rename-file file real)
             (call-with-output-file file
               (lambda (port)
                 (format port "#!~a
target='~a'
next=0
for arg in \"$@\"; do
  if [ \"$next\" = 1 ]; then target=$arg; next=0; fi
  case \"$arg\" in --target) next=1;; --target=*) target=${arg#--target=};; esac
done
prefix=()
if [ '~a' = clippy-driver ] && [ \"${1##*/}\" = rustc ]; then
  prefix=(\"$1\")
  shift
fi
if [ \"$target\" = '~a' ]; then
  exec '~a' \"${prefix[@]}\" -C linker-features=-lld \"$@\"
else
  exec '~a' \"${prefix[@]}\" \"$@\"
fi
"
                         (which "bash") host name host real real)))
             (chmod file #o755)))
         (wrap-program file
           `("PATH" ":" prefix (,(string-append out "/bin") ,(string-append cc "/bin")))
           `("LIBRARY_PATH" ":" suffix (,(string-append libc "/lib")
                                           ,(string-append gcc-lib "/lib")))))))
   '("rustc" "rustdoc" "cargo" "clippy-driver")))

(define (check-toolchain out)
  (invoke (string-append out "/bin/rustc") "--version")
  (invoke (string-append out "/bin/cargo") "--version")
  (call-with-output-file "hello.rs"
    (lambda (port) (display "fn main() { let values = [6, 7]; assert_eq!(values.iter().product::<i32>(), 42); }\n" port)))
  (invoke (string-append out "/bin/rustc") "hello.rs" "-o" "hello")
  (invoke "./hello")
  (mkdir-p "cargo-smoke/src")
  (copy-file "hello.rs" "cargo-smoke/src/main.rs")
  (call-with-output-file "cargo-smoke/Cargo.toml"
    (lambda (port)
      (display "[package]\nname = \"guix-rust-smoke\"\nversion = \"0.1.0\"\n" port)))
  (setenv "CARGO_HOME" (string-append (getcwd) "/cargo-home"))
  (invoke (string-append out "/bin/cargo") "run" "--offline"
          "--manifest-path" "cargo-smoke/Cargo.toml")
  (when (file-exists? (string-append out "/bin/cargo-clippy"))
    (invoke (string-append out "/bin/cargo") "clippy" "--offline"
            "--manifest-path" "cargo-smoke/Cargo.toml")))
