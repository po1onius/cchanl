;;; Clash Verge's GUI, privileged IPC service, and independently built core.
(define-module (ch0r0ng packages clash-verge)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages python)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages webkit)
  #:use-module (ch0r0ng packages clash-verge crates)
  #:use-module (ch0r0ng packages clash-verge go-modules)
  #:export (mihomo clash-verge-service-for clash-verge-service
            clash-verge-rev-bin))

(define mihomo
  (package
    (name "mihomo")
    (version "1.19.30")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://codeload.github.com/MetaCubeX/mihomo/tar.gz/refs/tags/v"
                           version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256 (base32 "12yar204ih98x6sg50rp74b01qvv9sab2f818s2x8jvyf03p32pf"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:modules '((guix build gnu-build-system) (guix build utils)
                  (srfi srfi-1))
      #:phases
      #~(modify-phases %standard-phases
          (replace 'configure
            (lambda _
              (let ((proxy (string-append (getcwd) "/guix-go-proxy")))
                (for-each
                 (lambda (entry)
                   (let ((target (string-append proxy "/" (car entry))))
                     (mkdir-p (dirname target))
                     (symlink (cadr entry) target)))
                 (list #$@(map (lambda (entry)
                                 #~(list #$(car entry) #$(cadr entry)))
                               %mihomo-module-files)))
                (setenv "GOPROXY" (string-append "file://" proxy))
                ;; Sources were verified against upstream go.sum when generated.
                ;; Go also checks the module archive hashes against go.sum.
                (setenv "GOSUMDB" "off")
                (setenv "GOTOOLCHAIN" "local")
                (setenv "GOCACHE" (string-append (getcwd) "/.go-cache"))
                (setenv "GOMODCACHE" (string-append (getcwd) "/.go-modules"))
                (setenv "CGO_ENABLED" "0"))))
          (replace 'build
            (lambda* (#:key parallel-build? #:allow-other-keys)
              (invoke "go" "build" "-mod=readonly" "-trimpath" "-buildvcs=false"
                      "-p" (if parallel-build? (number->string (parallel-job-count)) "1")
                      "-tags=with_gvisor"
                      #$(string-append "-ldflags=-s -w -X github.com/metacubex/mihomo/constant.Version="
                                       version)
                      "-o" "mihomo" ".")))
          (replace 'check
            (lambda* (#:key tests? #:allow-other-keys)
              (when tests?
                (invoke "go" "test" "-mod=readonly" "./component/trie")
                (invoke "./mihomo" "-v")
                (call-with-output-file "guix-test.yaml"
                  (lambda (port)
                    (display "mode: direct\ndns:\n  enable: false\ntun:\n  enable: false\n" port)))
                (invoke "./mihomo" "-t" "-d" (getcwd) "-f" "guix-test.yaml"))))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let ((out (assoc-ref outputs "out")))
                (install-file "mihomo" (string-append out "/bin"))
                ;; TUN auto-redirect's iptables fallback and the optional TProxy
                ;; mode invoke these tools.  The daemon has a minimal PATH.
                (wrap-program (string-append out "/bin/mihomo")
                  `("PATH" prefix
                    (#$(file-append iptables "/sbin")
                     #$(file-append iproute "/sbin")
                     #$(file-append procps "/sbin"))))
                (install-file "LICENSE" (string-append out "/share/doc/mihomo"))))))))
    (native-inputs (list go))
    (inputs (list iptables iproute procps))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://github.com/MetaCubeX/mihomo")
    (synopsis "Rule-based proxy and TUN networking core")
    (description "Mihomo is a rule-based proxy supporting multiple protocols
and TUN networking.  This package builds the core, including gVisor support,
from source using a pinned, offline Go module proxy.")
    (license license:gpl3)))

(define %service-prepare
  (local-file (canonicalize-path
               (search-path %load-path "ch0r0ng/packages/clash-verge/prepare-service.py"))))

(define %service-logger
  (origin
    (method url-fetch)
    (uri "https://codeload.github.com/clash-verge-rev/clash-verge-logger/tar.gz/e4768e3852c4868ed86e7210df82c1178467820d")
    (file-name "clash-verge-logger-e4768e3.tar.gz")
    (sha256 (base32 "1plg3g8m1faic1309l8rqp33a6flddgp4jyni2k73x2596qjivni"))))

(define* (clash-verge-service-for #:optional (core mihomo))
  (package
    (name "clash-verge-service")
    (version "2.3.3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://codeload.github.com/clash-verge-rev/clash-verge-service-ipc/tar.gz/refs/tags/v"
                           version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256 (base32 "1389ywwdzxnfd12gq9pcx80jmp178jafi0jhzvd40fdj43z3jjql"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:rust rust-1.95
      #:install-source? #f
      #:cargo-build-flags ''("--release" "--features" "standalone"
                            "--bin" "clash-verge-service")
      #:phases
      #~(modify-phases %standard-phases
          (delete 'prepare-rust-crates)
          (delete 'patch-cargo-checksums)
          (replace 'unpack-rust-crates
            (lambda* (#:key source inputs vendor-dir #:allow-other-keys)
              ((assoc-ref %standard-phases 'unpack-rust-crates)
               #:source source #:vendor-dir vendor-dir
               #:inputs (filter (lambda (input)
                                  (string-prefix? "rust-" (car input)))
                                inputs))))
          (add-before 'configure 'prepare-guix-service
            (lambda* (#:key inputs #:allow-other-keys)
              (mkdir-p "../service-logger")
              (invoke "tar" "xf" #$%service-logger "-C" "../service-logger"
                      "--strip-components=1")
              (invoke "python3" #$%service-prepare "../service-logger")
              (copy-file "Cargo.lock" "Cargo.lock.guix")
              (setenv "GUIX_MIHOMO" #$(file-append core "/bin/mihomo"))))
          (add-after 'configure 'restore-lockfile
            (lambda _
              ;; cargo-build-system normally removes Cargo.lock.  Keep the
              ;; upstream registry resolution; Cargo only updates the logger
              ;; entry from its Git source to the pinned local source tree.
              (copy-file "Cargo.lock.guix" "Cargo.lock")))
          (replace 'check
            (lambda* (#:key tests? #:allow-other-keys)
              (when tests?
                (invoke "cargo" "build" "--offline" "--features" "standalone,test")
                (invoke "cargo" "test" "--offline" "--all-targets"
                        "--features" "standalone,test,client"))))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let ((out (assoc-ref outputs "out")))
                ;; Installer/uninstaller binaries manage systemd, not Shepherd.
                (install-file "target/release/clash-verge-service"
                              (string-append out "/bin"))
                (install-file "LICENSE" (string-append out "/share/doc/clash-verge-service"))))))))
    (native-inputs (list python procps))
    (inputs
     (append (list (list "mihomo" core))
             (map (lambda (source) (list (origin-file-name source) source))
                  %clash-verge-service-crates)))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://github.com/clash-verge-rev/clash-verge-service-ipc")
    (synopsis "Clash Verge IPC service for a Guix-managed Mihomo core")
    (description "This builds the Clash Verge IPC service for use with
Shepherd.  The service runs the selected Mihomo package and uses system-managed
runtime, state, and log directories.  Access must be restricted to trusted users.")
    (license license:gpl3)))

(define clash-verge-service (clash-verge-service-for))

(define clash-verge-rev-bin
  (package
    (name "clash-verge-rev-bin")
    (version "2.5.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v"
                           version "/Clash.Verge_" version "_"
                           (if (string-prefix? "aarch64" (%current-system)) "arm64" "amd64")
                           ".deb"))
       (sha256
        (base32 (if (string-prefix? "aarch64" (%current-system))
                    "0bzpvvwy5yanz7jk75drwyzyb969mzr0wy3nm50drybv5n2mm2jr"
                    "1vb7q6dxzsmfrr4qarxnpqkmvpdy6h5p2pby77fz2vdi2knq6p03")))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:strip-binaries? #f
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack
            (lambda* (#:key source #:allow-other-keys)
              (mkdir "source")
              (chdir "source")
              (invoke "ar" "x" source)
              (invoke "tar" "xf" "data.tar.gz")))
          (delete 'configure)
          (delete 'build)
          (delete 'check)
          (replace 'install
            (lambda* (#:key inputs outputs tests? #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (bin (string-append out "/bin"))
                     (program (string-append bin "/clash-verge")))
                (install-file "usr/bin/clash-verge" bin)
                (copy-recursively "usr/share" (string-append out "/share"))
                (copy-recursively "usr/lib" (string-append out "/lib"))
                (rename-file (string-append out "/share/applications/Clash Verge.desktop")
                             (string-append out "/share/applications/clash-verge.desktop"))
                (symlink #$(file-append mihomo "/bin/mihomo")
                         (string-append bin "/verge-mihomo"))
                ;; The binary GUI still offers the Alpha selector.  Both entries
                ;; use the channel's pinned core; it cannot download a root core.
                (symlink #$(file-append mihomo "/bin/mihomo")
                         (string-append bin "/verge-mihomo-alpha"))
                (invoke "patchelf" "--set-interpreter"
                        (search-input-file inputs #$(glibc-dynamic-linker)) program)
                (invoke "patchelf" "--set-rpath"
                        (string-join
                         (map dirname
                              (map (lambda (name) (search-input-file inputs name))
                                   '("/lib/libc.so.6" "/lib/libgcc_s.so.1"
                                     "/lib/libgtk-3.so.0" "/lib/libgdk_pixbuf-2.0.so.0"
                                     "/lib/libcairo.so.2" "/lib/libglib-2.0.so.0"
                                     "/lib/libdbus-1.so.3" "/lib/libsoup-3.0.so.0"
                                     "/lib/libwebkit2gtk-4.1.so.0"
                                     "/lib/libappindicator3.so.1"))) ":")
                        program)
                (when tests?
                  ;; Resolve ELF dependencies and symbol versions without
                  ;; launching a desktop session or starting a proxy.
                  (invoke (search-input-file inputs #$(glibc-dynamic-linker))
                          "--list" program))
                (wrap-program program
                  `("PATH" prefix
                    (,(dirname (search-input-file inputs "/bin/gsettings"))
                     ,(dirname (search-input-file inputs "/bin/kreadconfig6"))))
                  `("XDG_DATA_DIRS" prefix
                    (,(string-append out "/share")
                     #$(file-append gtk+ "/share")
                     #$(file-append gsettings-desktop-schemas "/share")))
                  `("GIO_EXTRA_MODULES" prefix
                    (#$(file-append glib-networking "/lib/gio/modules"))))))))))
    (native-inputs (list patchelf))
    (inputs (list glibc `(,gcc "lib") gtk+ gdk-pixbuf cairo glib `(,glib "bin")
                  dbus libsoup webkitgtk-for-gtk3 libappindicator kconfig mihomo
                  glib-networking gsettings-desktop-schemas))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://github.com/clash-verge-rev/clash-verge-rev")
    (synopsis "Prebuilt Clash Verge Rev GUI with a Guix-managed Mihomo core")
    (description "This repackages the official Clash Verge Rev desktop binary
and its geographic databases.  The proxy core is built separately from source.
Use clash-verge-service-type on Guix System for privileged service and TUN mode;
the upstream systemd installation helpers are not installed.")
    (license license:gpl3)))
