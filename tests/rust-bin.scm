;;; Exercise rust-bin through Guix's unmodified cargo-build-system.
;;; Run from the channel root: guix build -L . -f tests/rust-bin.scm
(define-module (tests rust-bin)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (ch0r0ng packages rust))

(package
  (name "rust-bin-integration-test")
  (version "0.1.0")
  (source (local-file "../ch0r0ng/packages/rust/smoke-test" #:recursive? #t))
  (build-system cargo-build-system)
  (arguments
   (list #:rust rust-bin
         #:install-source? #f))
  (home-page "https://www.rust-lang.org")
  (synopsis "Check the prebuilt Rust toolchain's Cargo integration")
  (description "This local fixture verifies that rust-bin can be selected with
the standard cargo-build-system's rust argument, without a custom build system.")
  (license license:expat))
