(define-module (ch0r0ng packages networking)
  #:use-module (guix base16)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system trivial)
  #:use-module ((guix licenses) #:prefix license:))


(define-public dae-bin
  (package
    (name "dae-bin")
    (version "1.0.0")
    (source (origin
             (method url-fetch/zipbomb)
             (uri (string-append
                   "https://github.com/daeuniverse/dae/releases/download/"
                   "v" version
                   "/dae-linux-x86_64_v3_avx2.zip"))
             (sha256
              (base32 "13m3p3357mk2hi39ndlaa82niykd5nzyn4hhzhl6s0ywd4ff3sy6"))))
    (build-system copy-build-system)
    (arguments
     (list #:install-plan
           #~'(("dae-linux-x86_64_v3_avx2" "bin/dae")
               ("geoip.dat" "share/dae/")
               ("geosite.dat" "share/dae/"))))
    (supported-systems '("x86_64-linux"))
    (home-page "https://https://github.com/daeuniverse/dae/")
    (synopsis "eBPF-powered transparent proxy solution")
    (description
     "dae, means goose, is a high-performance transparent proxy solution using eBPF.")
    (license license:agpl3)))
