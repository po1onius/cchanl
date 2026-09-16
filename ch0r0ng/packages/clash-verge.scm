;;; Clash Verge's GUI, privileged IPC service, and independently built core.
(define-module (ch0r0ng packages clash-verge)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
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
  #:use-module (gnu packages node)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages webkit)
  #:use-module (ch0r0ng packages clash-verge crates)
  #:use-module (ch0r0ng packages clash-verge gui-crates)
  #:use-module (ch0r0ng packages clash-verge npm-inputs)
  #:use-module (ch0r0ng packages clash-verge go-modules)
  #:export (mihomo clash-verge-service-for clash-verge-service
            clash-verge-rev clash-verge-rev-bin))

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

;; The GUI release pins these crates to Git revisions.  Keep them in the same
;; offline Cargo vendor set as the crates.io dependencies.
(define %gui-git-crates
  (list
   (list "rust-clash-verge-logger-0.2.2"
         %service-logger)
   (list "rust-nix-0.31.0"
         (origin
           (method url-fetch)
           (uri "https://crates.io/api/v1/crates/nix/0.31.0/download")
           (file-name "nix-0.31.0.crate")
           (sha256 (base32 "1blg4y5fh0zchlgcfn4vgsrmqna97l6cccawvyc8wryp7qbjp7yv"))))
   (list "rust-windows-service-0.8.0"
         (origin
           (method url-fetch)
           (uri "https://crates.io/api/v1/crates/windows-service/0.8.0/download")
           (file-name "windows-service-0.8.0.crate")
           (sha256 (base32 "1b1mmhhm5i9dvpv0b4x7sjh1z2wjlxxxbza7r5dw70brcj7awg0r"))))
   (list "rust-dotenvy-0.15.7"
         (origin
           (method url-fetch)
           (uri "https://crates.io/api/v1/crates/dotenvy/0.15.7/download")
           (file-name "dotenvy-0.15.7.crate")
           (sha256 (base32 "16s3n973n5aqym02692i1npb079n5mb0fwql42ikmwn8wnrrbbqs"))))
   (list "rust-libc-0.2.180"
         (origin
           (method url-fetch)
           (uri "https://crates.io/api/v1/crates/libc/0.2.180/download")
           (file-name "libc-0.2.180.crate")
           (sha256 (base32 "1z2n7hl10fnk1xnv19ahhqxwnb4qi9aclnl6gigim2aaahw5mhxw"))))
   (list "rust-sysinfo-0.38.2"
         (origin
           (method url-fetch)
           (uri "https://crates.io/api/v1/crates/sysinfo/0.38.2/download")
           (file-name "sysinfo-0.38.2.crate")
           (sha256 (base32 "1a6dva245hhg85rap9q0bhbmpxcjq4j7kb2lyskblrjbbf9ikz0y"))))
   (list "rust-clash-verge-service-2.3.3"
         (origin
           (method url-fetch)
           (uri "https://codeload.github.com/clash-verge-rev/clash-verge-service-ipc/tar.gz/refs/tags/v2.3.3")
           (file-name "clash-verge-service-2.3.3.tar.gz")
           (sha256 (base32 "1389ywwdzxnfd12gq9pcx80jmp178jafi0jhzvd40fdj43z3jjql"))))
   (list "rust-dark-light-2.0.0"
         (origin
           (method url-fetch)
           (uri "https://codeload.github.com/rust-dark-light/dark-light/tar.gz/0f18d2fbcaa5d1c175db8aae7d53428988d7e961")
           (file-name "dark-light-2.0.0.tar.gz")
           (sha256 (base32 "1iw515c7kz2f704j6diy6jb9vwxcbrmp0cvlsqc8h74rcncq9dw4"))))
   (list "rust-sysproxy-0.5.4"
         (origin
           (method url-fetch)
           (uri "https://codeload.github.com/clash-verge-rev/sysproxy-rs/tar.gz/d214eba9f61d655d49a35f6ae17c359f7ad68d79")
           (file-name "sysproxy-0.5.4.tar.gz")
           (sha256 (base32 "1pfd1l89bhfqwlpc3hpbbfp8b1bjhfhcbhm3kxijx8v5xqb7y0xj"))))
   (list "rust-tauri-plugin-mihomo-0.5.4"
         (origin
           (method url-fetch)
           (uri "https://codeload.github.com/clash-verge-rev/tauri-plugin-mihomo/tar.gz/cf97ff99e390a9b437d5cf94c6f454f024fc8f69")
           (file-name "tauri-plugin-mihomo-0.5.4.tar.gz")
           (sha256 (base32 "1xxjrgs033ixqpa6m3jpfqxfp1b22383m9zmlgn1i6l6wndc9i7i"))))))

(define %pnpm
  (origin
    (method url-fetch)
    (uri "https://registry.npmjs.org/pnpm/-/pnpm-11.3.0.tgz")
    (file-name "pnpm-11.3.0.tgz")
    (sha256 (base32 "0x44zcnnnmypf2gr711npag6hm1n03wylc89l3s42r7k3ksixpjs"))))

(define pnpm-local
  (package
    (name "pnpm-local")
    (version "11.3.0")
    (source %pnpm)
    (build-system gnu-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (delete 'configure)
          (delete 'build)
          (delete 'check)
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let ((out (assoc-ref outputs "out"))
                    (node (which "node")))
                (copy-recursively "bin" (string-append out "/libexec/bin"))
                (copy-recursively "dist" (string-append out "/libexec/dist"))
                (mkdir-p (string-append out "/bin"))
                (call-with-output-file (string-append out "/bin/pnpm")
                  (lambda (port)
                    (format port "#!~a~%exec ~a ~a \"$@\"~%"
                            (which "sh") node
                            (string-append out "/libexec/bin/pnpm.cjs"))))
                (chmod (string-append out "/bin/pnpm") #o755)))))))
    (native-inputs (list node))
    (synopsis "pnpm package manager")
    (description "Local pnpm executable used to build Clash Verge's web UI.")
    (home-page "https://pnpm.io/")
    (license license:expat)))

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

(define %tauri-plugin-mihomo-api
  (origin
    (method url-fetch)
    (uri "https://codeload.github.com/clash-verge-rev/tauri-plugin-mihomo/tar.gz/ff75ee3edd61923e6c76a7f3cf3c3fbd0f8e22c0")
    (file-name "tauri-plugin-mihomo-api-0.5.4.tar.gz")
    (sha256 (base32 "0n945sgb65jgzrzp2qs9svn9l56x6iw4cxkymb4pwm6ay348nn4l"))))

(define clash-verge-rev
  (package
    (name "clash-verge-rev")
    (version "2.5.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://codeload.github.com/clash-verge-rev/clash-verge-rev/tar.gz/refs/tags/v" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256 (base32 "1239q7wdlk6rxazd7272cnp2ka73y8ajxm813d43pcw3br1ps61i"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:cargo-inputs (append %clash-verge-gui-crates %gui-git-crates)
      #:install-source? #f
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack-rust-crates
            (lambda* (#:key inputs #:allow-other-keys)
              (use-modules (guix build utils))
              (mkdir-p "guix-vendor")
              (for-each
               (lambda (input)
                 (when (string-prefix? "rust-" (car input))
                   (let* ((path (cdr input))
                          (destination
                           (string-append "guix-vendor/"
                                          (strip-store-file-name path))))
                     (unless (file-exists? destination)
                       (mkdir-p destination)
                       (if (directory-exists? path)
                           (copy-recursively path destination)
                           (invoke "tar" "xf" path "-C" destination
                                   "--strip-components" "1"))))))
               inputs)))
          (add-before 'configure 'build-web-ui
            (lambda* (#:key inputs #:allow-other-keys)
              (setenv "XDG_CACHE_HOME" (string-append (getcwd) "/.cache"))
              (use-modules (json) (ice-9 popen) (ice-9 rdelim)
                           (ice-9 textual-ports)
                           (srfi srfi-1) (srfi srfi-13))
              (let* ((npm-inputs
                      (filter (lambda (input)
                                (string-prefix? "npm-" (car input)))
                              inputs))
                     (lock-map
                      (append
                       (filter-map
                       (lambda (input)
                         (let* ((port
                                 (open-pipe*
                                  OPEN_READ "sh" "-c"
                                  "member=$(tar -tzf \"$1\" 2>/dev/null | grep '^package/package.json$' | head -n 1); test -n \"$member\" || member=$(tar -tzf \"$1\" 2>/dev/null | grep '/package.json$' | head -n 1); test -n \"$member\" && tar -xOf \"$1\" \"$member\""
                                  "sh" (cdr input)))
                                (metadata (catch #t
                                            (lambda () (json->scm port))
                                            (lambda args #f))))
                           (close-pipe port)
                           (let ((package-name (and metadata
                                                    (assoc-ref metadata "name")))
                                 (package-version (and metadata
                                                       (assoc-ref metadata "version"))))
                             (and package-name package-version
                                  (cons (string-append package-name "@"
                                                       package-version)
                                        (cdr input))))))
                       npm-inputs)
                      ;; tslib's registry archive is republished with a
                      ;; different top-level layout; keep an explicit entry
                      ;; for the lockfile resolver.
                      (list (cons "tslib@2.8.1"
                                  (cdr (assoc "npm-tslib-2.8.1" npm-inputs)))
                            (cons "@emotion/react@11.14.0"
                                  (cdr (assoc "npm-emotion-react-11.14.0"
                                              npm-inputs)))
                            (cons "@babel/runtime@7.29.7"
                                  (cdr (assoc "npm-babel-runtime-7.29.7"
                                              npm-inputs)))
                            (cons "yaml@1.10.3"
                                  (cdr (assoc "npm-yaml-1.10.3"
                                              npm-inputs)))
                            (cons "stylis@4.2.0"
                                  (cdr (assoc "npm-stylis-4.2.0"
                                              npm-inputs)))
                            (cons "@emotion/styled@11.14.1"
                                  (cdr (assoc "npm-emotion-styled-11.14.1"
                                              npm-inputs)))
                            (cons "react-transition-group@4.4.5"
                                  (cdr (assoc "npm-react-transition-group-4.4.5"
                                              npm-inputs)))
                            (cons "tauri-plugin-mihomo-api@https://codeload.github.com/clash-verge-rev/tauri-plugin-mihomo/tar.gz/ff75ee3edd61923e6c76a7f3cf3c3fbd0f8e22c0"
                                  (cdr (assoc "npm-tauri-plugin-mihomo-api-0.5.4"
                                              npm-inputs))))))
                     (lockfile
                      (call-with-input-file "pnpm-lock.yaml" get-string-all)))
                (call-with-output-file "pnpm-lock.yaml"
                  (lambda (output-port)
                    (let loop ((lines (string-split lockfile #\newline))
                               (section #f))
                      (unless (null? lines)
                        (let* ((line (car lines))
                               (trimmed (string-trim-both line))
                               (new-section
                                (if (and (string-prefix? "  " line)
                                         (not (string-prefix? "    " line))
                                         (string-suffix? ":" trimmed))
                                    (let ((key (substring trimmed 0
                                                           (- (string-length trimmed) 1))))
                                      (if (and (string-prefix? "'" key)
                                               (string-suffix? "'" key))
                                          (substring key 1 (- (string-length key) 1))
                                          key))
                                    section))
                               (local-source
                                (and (string-prefix? "    resolution: {"
                                                      line)
                                     (assoc new-section lock-map)))
                               (output-line
                                (if local-source
                                    (string-append
                                     "    resolution: {tarball: \"file:"
                                     (cdr local-source) "\"}")
                                    line)))
                          (format output-port "~a~%" output-line)
                          (loop (cdr lines) new-section))))))
                (invoke "pnpm" "--store-dir" ".pnpm-store"
                        "install" "--offline" "--no-frozen-lockfile"
                      "--ignore-scripts" "--trust-lockfile")
              (invoke "node" "node_modules/typescript/bin/tsc" "--noEmit")
              (invoke "node" "node_modules/vite/bin/vite.js" "build"))))
          (add-before 'configure 'patch-tauri-bundle
            (lambda _
              (substitute* "src-tauri/Cargo.toml"
                (("clash_verge_logger = \\{ git = [^}]+\\}")
                 "clash_verge_logger = { path = \"../guix-vendor/clash-verge-logger-e4768e3.tar.gz\" }")
                (("clash_verge_service_ipc = \\{")
                 "clash_verge_service_ipc = { path = \"../guix-vendor/clash-verge-service-2.3.3.tar.gz\",")
                ((", git = \"https://github.com/clash-verge-rev/clash-verge-service-ipc\"")
                 "")
                (("sysproxy = \\{ git = \"https://github.com/clash-verge-rev/sysproxy-rs\", features = \\[")
                 "sysproxy = { path = \"../guix-vendor/sysproxy-0.5.4.tar.gz\", features = [")
                (("tauri-plugin-mihomo = \\{ git = [^}]+\\}")
                 "tauri-plugin-mihomo = { path = \"../guix-vendor/tauri-plugin-mihomo-0.5.4.tar.gz\" }")
                (("dark-light = \\{ git = [^}]+\\}")
                 "dark-light = { path = \"../guix-vendor/dark-light-2.0.0.tar.gz\" }"))
      (invoke "sed" "-i" "/^\\[\\[bench\\]\\]/,/^$/d"
              "guix-vendor/sysproxy-0.5.4.tar.gz/Cargo.toml")
      (invoke "sed" "-i" "/^[[:space:]]*criterion[[:space:]]*=/d"
              "guix-vendor/sysproxy-0.5.4.tar.gz/Cargo.toml")
      (invoke "sed" "-i" "/^[[:space:]]*serial_test[[:space:]]*=/d"
              "guix-vendor/sysproxy-0.5.4.tar.gz/Cargo.toml")
      (invoke "sed" "-i"
              "s/version = \"=0\\.2\\.180\"/version = \"0.2.186\"/"
              "guix-vendor/nix-0.31.0.crate/Cargo.toml")
      (substitute* "guix-vendor/clash-verge-service-2.3.3.tar.gz/Cargo.toml"
        (("clash_verge_logger = \\{ git = [^}]+\\}")
         "clash_verge_logger = { path = \"../clash-verge-logger-e4768e3.tar.gz\" }"))
      (invoke "sed" "-i"
              "/^\\[features\\]/,/^\\[dependencies\\]/{/^[[:space:]]*\\\"clash_verge_logger\\\",$/d;}"
              "guix-vendor/clash-verge-service-2.3.3.tar.gz/Cargo.toml")
      (invoke "sed" "-i"
              "/^[[:space:]]*serial_test[[:space:]]*=/d"
              "guix-vendor/clash-verge-service-2.3.3.tar.gz/Cargo.toml")
      (invoke "find" "." "-name" "Cargo.toml" "-exec" "sed" "-i"
              "s/rust-version = \"1.95\"/rust-version = \"1.93\"/g"
              "{}" ";")
      (invoke "sed" "-i"
              "s/sysinfo = { version = \"0.39.5\"/sysinfo = { version = \"0.38.2\"/"
              "crates/tauri-plugin-clash-verge-sysinfo/Cargo.toml")
      (invoke "sed" "-i"
              "s/windows-sys = \"=0\\.3\\.1\"/windows-sys = \"0.3.2\"/"
              "guix-vendor/sysinfo-0.38.2.crate/Cargo.toml")
      (invoke "sed" "-i"
              "/^\\[target.*macos/,/^default-features = false$/d"
              "guix-vendor/sysinfo-0.38.2.crate/Cargo.toml")
      (invoke "sed" "-i" "/objc2-/d"
              "guix-vendor/sysinfo-0.38.2.crate/Cargo.toml")
              (substitute* "src-tauri/src/utils/dirs.rs"
                (("once\\(\"/tmp\"\\)")
                 "once(&std::env::var(\"XDG_RUNTIME_DIR\").unwrap_or_else(|_| \"/tmp\".to_string()))")
                (("join\\(\"verge\"\\)") "join(\"clash-verge-rev\")"))
              (substitute* "src-tauri/tauri.conf.json"
                (("\"externalBin\": \\[[^]]*\\],") "\"externalBin\": [],")
                (("\"resources\": \\[[^]]*\\],") "\"resources\": [],")
                (("\"createUpdaterArtifacts\": true") "\"createUpdaterArtifacts\": false"))
              (substitute* "src-tauri/tauri.linux.conf.json"
                (("\"externalBin\": \\[[^]]*\\]") "\"externalBin\": []"))
              (invoke "sed" "-i"
                      "/\"externalBin\": \\[/,/^[[:space:]]*]/c\\    \"externalBin\": []"
                      "src-tauri/tauri.linux.conf.json")))
          (delete 'check)
          (replace 'build
            (lambda _
              (invoke "cargo" "build" "--release" "--offline"
                      "--no-default-features" "--features" "custom-protocol"
                      "-p" "clash-verge")))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let ((out (assoc-ref outputs "out")))
                (install-file "target/release/clash-verge"
                              (string-append out "/bin"))
                (copy-recursively "src-tauri/icons"
                                  (string-append out "/share/icons"))
                (copy-recursively "dist"
                                  (string-append out "/share/clash-verge"))
                (mkdir-p (string-append out "/share/applications"))
                (call-with-output-file
                    (string-append out "/share/applications/clash-verge.desktop")
                  (lambda (port)
                    (display "[Desktop Entry]\nName=Clash Verge\nComment=Clash GUI based on Tauri\nExec=clash-verge\nIcon=clash-verge\nTerminal=false\nType=Application\nCategories=Network;\n" port))))))))
          )
    (native-inputs
     (append (list (list "node" node) (list "pnpm" pnpm-local)
                   (list "pkg-config" pkg-config)
                   (list "zstd" zstd "lib"))
             (list (list "npm-tauri-plugin-mihomo-api-0.5.4"
                         %tauri-plugin-mihomo-api))
             %clash-verge-npm-inputs))
    (inputs (list glib gtk+ gdk-pixbuf cairo dbus libsoup
                  webkitgtk-for-gtk3 libappindicator kconfig mihomo
                  glib-networking gsettings-desktop-schemas))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://github.com/clash-verge-rev/clash-verge-rev")
    (synopsis "Clash Verge Rev GUI built from source")
    (description "Clash Verge Rev is a Tauri-based desktop GUI for Mihomo.
The Rust application and web frontend are built from the tagged source tree;
no precompiled upstream application is used.")
    (license license:gpl3)))

(define clash-verge-rev-bin clash-verge-rev)
