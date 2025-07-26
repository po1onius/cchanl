(define-module (ch0r0ng packages network)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system go)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (rosenthal utils download)
  #:use-module (gnu packages base)
  #:use-module (gnu packages dns)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages linux))


(define-public mihomo
  (package
    (name "mihomo")
    (version "1.19.11")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/MetaCubeX/mihomo")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1vsy73iian2kk89c40g8q0ndcabcwxvsi4j6h6x4y6dkyafrppcy"))))
    (build-system go-build-system)
    (arguments
     (list
      #:tests? (not (%current-target-system)) ;TODO: Run test suite.
      #:go go-1.23
      #:install-source? #f
      #:import-path "."
      #:build-flags
      #~(list "-tags" "with_gvisor"
              (string-append
               "-ldflags="
               " -X github.com/metacubex/mihomo/constant.Version="
               #$(package-version this-package)))
      #:modules
      '((ice-9 match)
        ((guix build gnu-build-system) #:prefix gnu:)
        (guix build go-build-system)
        (guix build utils))
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack
            (lambda args
              (unsetenv "GO111MODULE")
              (apply (assoc-ref gnu:%standard-phases 'unpack) args)
              (copy-recursively
               #+(this-package-native-input "vendored-go-dependencies")
               "vendor")))
          (replace 'install-license-files
            (assoc-ref gnu:%standard-phases 'install-license-files))
          (delete 'check)
          (add-after 'install 'check
            (lambda* (#:key tests? #:allow-other-keys)
              (when tests?
                (let ((mihomo (in-vicinity #$output "bin/mihomo")))
                  (invoke mihomo "--help")
                  (invoke mihomo "-v"))))))))
    (native-inputs
     (append
      (list (origin
              (method (go-mod-vendor #:go go-1.23))
              (uri (package-source this-package))
              (file-name "vendored-go-dependencies")
              (sha256
               (base32
                "1kvhcngcabp43g27d7spz47dm2c8ngzh270cfwz2iy9vmng67xlk"))))
      (if (%current-target-system)
          (list this-package)
          '())))
    (home-page "https://wiki.metacubex.one/")
    (synopsis "Rule-based proxy")
    (description
     "Mihomo is an anti-censorship proxy application, originally known as
\"Clash Meta\", designed to facilitate secure and flexible internet access.
It supports various protocols, making it a versatile tool for users seeking to
bypass network restrictions." )
    (license license:gpl3+)))
