;;; SPDX-License-Identifier: GPL-3.0-or-later
;;; Inspired by guix-rustup (Declan Tsien, GPL-3.0-or-later).
(define-module (ch0r0ng rustup)
  #:use-module (ch0r0ng rustup manifest)
  #:use-module (ch0r0ng rustup toml)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix download)
  #:use-module (guix base16)
  #:use-module (guix utils)
  #:use-module (guix build-system)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages compression)
  #:use-module (ice-9 textual-ports)
  #:use-module (ice-9 regex)
  #:use-module (srfi srfi-1)
  #:export (rustup rustup-from-manifest make-cargo-build-system
            read-toolchain-file find-toolchain-file))

(define (find-toolchain-file)
  (let loop ((dir (getcwd)))
    (or (find file-exists? (map (lambda (name) (string-append dir "/" name))
                                '("rust-toolchain.toml" "rust-toolchain")))
        (and (not (string=? dir "/")) (loop (dirname dir))))))

(define (read-toolchain-file file)
  (let ((text (string-trim-both (call-with-input-file file get-string-all))))
    (if (string-match "^(stable|beta|nightly|[0-9]+\\.[0-9]+(\\.[0-9]+)?)(-[0-9]{4}-[0-9]{2}-[0-9]{2})?$" text)
        `(("channel" . ,text))
        (let* ((data (parse-toml text)) (spec (assoc-ref data "toolchain")))
          (unless (and spec (string? (assoc-ref spec "channel")))
            (error "Rust toolchain file needs [toolchain].channel (path toolchains are unsupported)" file))
          spec))))

(define* (rustup-from-manifest file #:key (components '()) (targets '())
                              (profile 'default) (system (%current-system)))
  "Create a reproducible toolchain from a local TOML manifest and .sha256."
  (manifest->package (read-manifest file) system profile components targets))

(define* (rustup #:optional (channel-or-file #f)
                 #:key (components '()) (targets '()) (profile #f)
                 (system (%current-system)))
  "Resolve a channel or rust-toolchain file. Explicit options extend file lists;
PROFILE, when supplied, overrides the file. Without a file, use stable/default."
  (let* ((file (if channel-or-file
                   (and (file-exists? channel-or-file) channel-or-file)
                   (find-toolchain-file)))
         (spec (if file (read-toolchain-file file) '()))
         (channel (if file (assoc-ref spec "channel") (or channel-or-file "stable"))))
    (manifest->package
     (fetch-manifest channel) system
     (or profile (assoc-ref spec "profile") 'default)
     (delete-duplicates (append components (or (assoc-ref spec "components") '())))
     (delete-duplicates (append targets (or (assoc-ref spec "targets") '()))))))

(define (manifest->package data system profile components targets)
  (let* ((host (system->rust-target system))
         (sources (manifest-sources data host #:profile profile
                                    #:components components #:targets targets))
         (labels (map (lambda (i) (string-append "component-" (number->string i)))
                      (iota (length sources)))))
    (package
      (name "rust-toolchain")
      (version (manifest-version data))
      (source #f)
      (build-system gnu-build-system)
      (supported-systems (list system))
      (arguments
       (list
        #:strip-binaries? #f
        #:modules '((guix build gnu-build-system) (guix build utils)
                    (ch0r0ng build rustup))
        #:imported-modules `(,@%default-gnu-imported-modules (ch0r0ng build rustup))
        #:phases
        #~(modify-phases %standard-phases
            (delete 'unpack)
            (delete 'configure)
            (delete 'build)
            (delete 'check)
            (replace 'install
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (install-components inputs '#$labels (assoc-ref outputs "out"))))
            (add-after 'install 'patch-rust-toolchain
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (patch-toolchain
                 (assoc-ref outputs "out") #$host
                 (search-input-file inputs #$(glibc-dynamic-linker system))
                 (map (lambda (name) (string-append (assoc-ref inputs name) "/lib"))
                      '("libc" "gcc:lib" "zlib" "zstd:lib" "openssl" "curl")))))
            (add-after 'patch-rust-toolchain 'wrap-rust-toolchain
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (wrap-toolchain (assoc-ref outputs "out")
                                (assoc-ref inputs "gcc-toolchain")
                                (assoc-ref inputs "libc")
                                (assoc-ref inputs "gcc:lib") #$host
                                #$(and (string=? host "x86_64-unknown-linux-gnu")
                                       (version>=? (car (string-split (manifest-version data) #\-))
                                                   "1.90.0")))))
            (add-after 'wrap-rust-toolchain 'check-rust-toolchain
              (lambda* (#:key outputs tests? #:allow-other-keys)
                (when tests? (check-toolchain (assoc-ref outputs "out"))))))))
      (native-inputs (list patchelf))
      (inputs
       (append (list (list "gcc-toolchain" gcc-toolchain)
                     (list "gcc:lib" gcc "lib")
                     (list "libc" glibc) (list "zlib" zlib)
                     (list "zstd:lib" zstd "lib")
                     (list "openssl" openssl) (list "curl" curl))
               (map (lambda (label entry)
                      (list label
                            (origin
                              (method url-fetch)
                              (uri (list-ref entry 2))
                              (sha256 (base16-string->bytevector (list-ref entry 3))))))
                    labels sources)))
      (home-page "https://www.rust-lang.org")
      (synopsis "Official binary Rust toolchain adapted for Guix")
      (description "This package installs the official Rust compiler, Cargo and
selected components and target standard libraries.  Component archives are
verified against the Rust distribution manifest and adapted to Guix's dynamic
linker and C toolchain.  These binaries are not compiled from source.")
      (license (list license:asl2.0 license:expat)))))

(define (make-cargo-build-system . spec)
  "Use a rustup toolchain in Guix's Cargo build system, preserving input labels."
  (let ((toolchain (apply rustup spec))
        (lower (build-system-lower cargo-build-system)))
    (build-system
      (inherit cargo-build-system)
      (lower
       (lambda args
         (let ((result (apply lower args)))
           (when (bag-target result)
             (error "For cross compilation use rustup #:targets in guix shell and cargo --target"))
           (bag
             (inherit result)
             (build-inputs
              (map (lambda (input)
                     (if (member (car input) '("rustc" "cargo"))
                         (list (car input) toolchain)
                         input))
                   (bag-build-inputs result))))))))))
