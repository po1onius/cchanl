;;; Source-built and prebuilt Codex CLI packages.
(define-module (ch0r0ng packages codex)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix base16)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-13)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages regex)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xiph)
  #:use-module (ch0r0ng packages codex crates))

;; These sandbox-enabled archives are built and published by OpenAI.  Their
;; checksums are authenticated by the manifest pinned in the Codex source tree.
(define (v8-artifact binding?)
  (let* ((arm? (string-prefix? "aarch64" (%current-system)))
         (target (if arm? "aarch64-unknown-linux-gnu" "x86_64-unknown-linux-gnu"))
         (file (string-append (if binding? "src_binding_" "librusty_v8_")
                             "ptrcomp_sandbox_release_" target
                             (if binding? ".rs" ".a.gz"))))
    (origin
      (method url-fetch)
      (uri (string-append "https://github.com/openai/codex/releases/download/"
                          "rusty-v8-v150.4.0/" file))
      (sha256 (base16-string->bytevector (cond
        (binding? "7727826ae479bdb645e807239fb12d1f8e2e23de7a6cf16f5ee592690d1d8506")
        (arm? "d1517eed405468537029b005d5fe997ec74d5c8d351f916b3a6df20b7d2811ba")
        (else "a35c75d1f26e6a983885a45b33490a4ebe54f05050568b32b89cfb421b30b583")))))))

(define %codex-rust
  (package
    (name "codex")
    (version "0.154.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/openai/codex")
             (commit "6b9826e3aa83b1a5947db50f4332cb9c65f1b340")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0ax4ck7jyd9lr6qha8k6y913hj28jl4gw9mvijhi27wqvvablvrn"))))
    (build-system cargo-build-system)
    (arguments
     (list
      #:rust rust-1.95
      #:install-source? #f
      #:cargo-build-flags '(list "--release" "--package" "codex-cli"
                                "--package" "codex-code-mode-host"
                                "--package" "codex-voice-host"
                                "--bin" "codex" "--bin" "codex-code-mode-host"
                                "--bin" "codex-voice-host")
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'enter-workspace
            (lambda _ (chdir "codex-rs")))
          (delete 'prepare-rust-crates)
          (replace 'unpack-rust-crates
            (lambda* (#:key source inputs vendor-dir #:allow-other-keys)
              ;; Git dependencies are complete workspaces, not registry crates.
              ((assoc-ref %standard-phases 'unpack-rust-crates)
               #:source source #:vendor-dir vendor-dir
               #:inputs (filter (lambda (input)
                                  (string-prefix? "rust-" (car input)))
                                inputs))))
          (add-before 'configure 'prepare-offline-build
            (lambda* (#:key inputs #:allow-other-keys)
              (use-modules (ice-9 regex) (ice-9 rdelim)
                           (ice-9 textual-ports)
                           (srfi srfi-1) (srfi srfi-13))
              ;; Keep the source preparation in the Guile build phase.  The
              ;; Git inputs are complete workspaces, so they must live outside
              ;; codex-rs or Cargo will treat them as Codex workspace members.
              (define (read-text file)
                (call-with-input-file file get-string-all))
              (define (write-text file text)
                (call-with-output-file file
                  (lambda (port) (display text port))))
              (define (replace-all text old new)
                (let loop ((start 0) (parts '()))
                  (let ((position (string-contains text old start)))
                    (if position
                        (loop (+ position (string-length old))
                              (cons new
                                    (cons (substring text start position) parts)))
                        (apply string-append
                               (reverse (cons (substring text start) parts)))))))
              (define (field-value text field)
                (let ((match
                       (regexp-exec
                        (make-regexp
                         (string-append
                          "(^|[,\\n])[[:space:]]*" field
                          "[[:space:]]*=[[:space:]]*\\\"([^\\\"]*)\\\""))
                        text)))
                  (and match (match:substring match 2))))
              (define (package-name manifest)
                (call-with-input-file manifest
                  (lambda (port)
                    (let loop ((line (read-line port)) (in-package? #f))
                      (cond
                       ((eof-object? line) #f)
                       ((string=? (string-trim-both line) "[package]")
                        (loop (read-line port) #t))
                       ((and in-package?
                             (string-prefix? "[" (string-trim-both line)))
                        #f)
                       (in-package?
                        (let ((match
                               (regexp-exec
                                (make-regexp
                                 "^[[:space:]]*name[[:space:]]*=[[:space:]]*\\\"([^\\\"]+)\\\"")
                                line)))
                          (if match
                              (match:substring match 1)
                              (loop (read-line port) #t))))
                       (else (loop (read-line port) #f)))))))
              (define (lookup-package package-paths name)
                (let ((entry (assoc name package-paths)))
                  (and entry (cdr entry))))
              (define (inline-field-name field)
                (let ((match
                       (regexp-exec
                        (make-regexp
                         "^[[:space:]]*([[:alnum:]_-]+)[[:space:]]*=")
                        field)))
                  (and match (match:substring match 1))))
              (define (transform-inline line package-paths)
                (let* ((open (string-index line #\{))
                       (close (and open (string-rindex line #\}))))
                  (if (and open close (> close open))
                      (let* ((table (substring line (+ open 1) close))
                             (key-end (string-index line #\=))
                             (key (and key-end
                                       (string-trim-both
                                        (substring line 0 key-end))))
                             (name (or (field-value table "package") key))
                             (path (and (field-value table "git")
                                        (lookup-package package-paths name))))
                        (if path
                            (let ((fields
                                   (filter-map
                                    (lambda (field)
                                      (let ((field-name (inline-field-name field)))
                                        (cond
                                         ((and field-name (string=? field-name "git"))
                                          (string-append "path = \"" path "\""))
                                         ((and field-name
                                               (member field-name '("rev" "branch" "tag")))
                                          #f)
                                         (else field))))
                                    (map string-trim-both
                                         (string-split table #\,)))))
                              (string-append (substring line 0 open) "{"
                                             (string-join fields ", ")
                                             (substring line close)))
                            line))
                      line)))
              (define (header? line)
                (let ((line (string-trim-both line)))
                  (and (> (string-length line) 1)
                       (char=? (string-ref line 0) #\[)
                       (char=? (string-ref line (- (string-length line) 1)) #\]))))
              (define (section-package header)
                (let* ((name (string-trim-both header))
                       (name (substring name 1 (- (string-length name) 1)))
                       (dot (string-rindex name #\.))
                       (name (if dot (substring name (+ dot 1)) name)))
                  (string-trim-both
                   (if (and (> (string-length name) 1)
                            (char=? (string-ref name 0) #\")
                            (char=? (string-ref name (- (string-length name) 1)) #\"))
                       (substring name 1 (- (string-length name) 1))
                       name))))
              (define (field-line? line field)
                (regexp-exec
                 (make-regexp
                  (string-append "^[[:space:]]*" field
                                 "[[:space:]]*=[[:space:]]*\\\"[^\\\"]*\\\""))
                 line))
              (define (replace-field-line line field path)
                (let ((match
                       (regexp-exec
                        (make-regexp
                         (string-append
                          "^([[:space:]]*)" field
                          "[[:space:]]*=[[:space:]]*\\\"[^\\\"]*\\\"(.*)$"))
                        line)))
                  (if match
                      (string-append (match:substring match 1)
                                     "path = \"" path "\""
                                     (match:substring match 2))
                      line)))
              (define (obsolete-field-line? line)
                (or (field-line? line "rev")
                    (field-line? line "branch")
                    (field-line? line "tag")))
              (define (process-block block package-paths)
                (let* ((header (and (header? (car block)) (car block)))
                       (body (if header (cdr block) block))
                       (body (map (lambda (line)
                                    (transform-inline line package-paths))
                                  body))
                       (body-text (string-join body "\n"))
                       (name (and header (section-package header)))
                       (name (or (field-value body-text "package") name))
                       (path (and name
                                  (lookup-package package-paths name))))
                  (if (and path (field-value body-text "git"))
                      (cons header
                            (filter (lambda (line)
                                      (not (obsolete-field-line? line)))
                                    (map (lambda (line)
                                           (if (field-line? line "git")
                                               (replace-field-line line "git" path)
                                               line))
                                         body)))
                      (if header (cons header body) body))))
              (define (process-manifest manifest package-paths)
                (let* ((lines (string-split (read-text manifest) #\newline))
                       (blocks
                        (let loop ((remaining lines) (current '()) (result '()))
                          (cond
                           ((null? remaining)
                            (reverse
                             (if (null? current)
                                 result
                                 (cons (reverse current) result))))
                           ((and (pair? current) (header? (car remaining)))
                            (loop (cdr remaining) (list (car remaining))
                                  (cons (reverse current) result)))
                           (else
                            (loop (cdr remaining) (cons (car remaining) current)
                                  result))))))
                  (write-text manifest
                              (string-join
                               (map (lambda (block)
                                      (string-join
                                       (process-block block package-paths) "\n"))
                                    blocks)
                               "\n"))))
              (let* ((git-root (string-append (getcwd) "/../guix-git"))
                     (git-inputs
                      (map cdr
                           (filter (lambda (input)
                                     (string-prefix? "git-" (car input)))
                                   inputs)))
                     (package-paths '())
                     (manifests '()))
                (mkdir-p git-root)
                (for-each
                 (lambda (source)
                   (let ((target (string-append git-root "/" (basename source))))
                     (copy-recursively source target)
                     (for-each
                      (lambda (path)
                        (let ((stat (lstat path)))
                          (unless (eq? (stat:type stat) 'symlink)
                            (chmod path (logior (stat:mode stat) #o200)))))
                      (find-files target (const #t) #:directories? #t))
                     (for-each
                      (lambda (manifest)
                        (let ((name (package-name manifest)))
                          (when name
                            (set! package-paths
                                  (acons name (dirname manifest) package-paths)))
                          (set! manifests (cons manifest manifests))))
                      (find-files target "Cargo\\.toml$"))))
                 git-inputs)
                (for-each
                 (lambda (manifest)
                   (process-manifest manifest package-paths))
                 (append manifests
                         (filter (lambda (manifest)
                                   (and (not (string-contains manifest "/guix-vendor/"))
                                        (not (string-contains manifest "/guix-git/"))))
                                 (find-files "." "Cargo\\.toml$")))))
              (setenv "PROTOC" (search-input-file inputs "/bin/protoc"))
              (setenv "GUIX_BASH" (search-input-file inputs "/bin/bash"))
              (setenv "GUIX_SH" (search-input-file inputs "/bin/sh"))
              (setenv "RUSTY_V8_ARCHIVE" (assoc-ref inputs "v8-archive"))
              (setenv "RUSTY_V8_SRC_BINDING_PATH" (assoc-ref inputs "v8-bindings"))
              (setenv "STABLE_GIT_COMMIT" "6b9826e3aa83b1a5947db50f4332cb9c65f1b340")
              (let ((build-script "code-mode-protocol/build.rs"))
                (let ((text (read-text build-script)))
                  (unless (string-contains
                           text "protoc_bin_vendored::protoc_bin_path()?")
                    (error "expected vendored protoc invocation"))
                  (write-text
                   build-script
                   (replace-all text
                                "protoc_bin_vendored::protoc_bin_path()?"
                                (string-append "PathBuf::from(\""
                                               (getenv "PROTOC") "\")")))))
              (for-each
               (lambda (file)
                 (let ((text (read-text file)))
                   (unless (string-contains text "\"/nix/store\",")
                     (error "expected Nix store path list"))
                   (write-text file
                               (replace-all text "\"/nix/store\","
                                            "\"/nix/store\",\n    \"/gnu/store\","))))
               '("linux-sandbox/src/bwrap.rs"
                 "utils/path-utils/src/system_commands.rs"))
              (let ((file "shell-command/src/shell_detect.rs")
                    (text (read-text "shell-command/src/shell_detect.rs")))
                (write-text
                 file
                 (replace-all
                  (replace-all text "&[\"/bin/bash\", \"/usr/bin/bash\"]"
                               (string-append "&[\"" (getenv "GUIX_BASH")
                                              "\", \"/bin/bash\", \"/usr/bin/bash\"]"))
                  "&[\"/bin/sh\"]"
                  (string-append "&[\"" (getenv "GUIX_SH") "\", \"/bin/sh\"]"))))
              ;; Lower peak memory while retaining release optimization.
              (setenv "CARGO_PROFILE_RELEASE_LTO" "false")
              (setenv "CARGO_PROFILE_RELEASE_DEBUG" "0")
              (setenv "CARGO_PROFILE_RELEASE_CODEGEN_UNITS" "16")))
          (replace 'check
            (lambda* (#:key tests? #:allow-other-keys)
              ;; Exercise the real CLI without credentials, network, or a TTY.
              (when tests?
                (setenv "HOME" (string-append (getcwd) "/test-home"))
                (mkdir-p (getenv "HOME"))
                (invoke "target/release/codex" "--version")
                (invoke "target/release/codex" "--help")
                (invoke "target/release/codex" "exec" "--help")
                (invoke "target/release/codex" "sandbox" "--help")
                (invoke "target/release/codex-code-mode-host" "--help")
                (invoke "target/release/codex-voice-host" "--build-commit"))))
          (replace 'install
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (resources (string-append out "/codex-resources"))
                     (voice (string-append resources "/voice"))
                     (plugins (string-append voice "/lib/gstreamer-1.0")))
                (install-file "target/release/codex" (string-append out "/bin"))
                (install-file "target/release/codex-code-mode-host" resources)
                (install-file "target/release/codex-voice-host" (string-append voice "/bin"))
                (mkdir-p plugins)
                ;; Upstream verifies physical paths, so these must be real files.
                (copy-file (search-input-file inputs "/lib/libgstreamer-1.0.so.0")
                           (string-append voice "/lib/libgstreamer-1.0.so.0"))
                (for-each
                 (lambda (name)
                   (let ((file (string-append "libgst" name ".so")))
                     (copy-file (search-input-file inputs
                                  (string-append "/lib/gstreamer-1.0/" file))
                                (string-append plugins "/" file))))
                 '("app" "audioconvert" "audioresample" "coreelements"
                   "opus" "rtp" "rtpmanager"))
                (symlink (search-input-file inputs "/bin/rg")
                         (string-append resources "/rg"))
                (call-with-output-file (string-append out "/codex-package.json")
                  (lambda (port)
                    (display "{\"version\":\"0.154.0\"}\n" port)))
                (install-file "../LICENSE" (string-append out "/share/doc/codex"))))))))
    (native-inputs
     (list clang cmake-minimal pkg-config protobuf))
    (inputs
     (append
      (list (list "bash" bash)
            (list "v8-archive" (v8-artifact #f))
            (list "v8-bindings" (v8-artifact #t))
            (list "alsa-lib" alsa-lib)
            (list "gstreamer" gstreamer)
            (list "gst-plugins-base" gst-plugins-base)
            (list "gst-plugins-good" gst-plugins-good)
            (list "opus" opus)
            (list "ripgrep" ripgrep)
            (list "libcap" libcap)
            (list "oniguruma" oniguruma)
            (list "openssl" openssl)
            (list "sqlite" sqlite)
            (list "zlib" zlib)
            (list "zstd" zstd "lib"))
      (map (lambda (source) (list (origin-file-name source) source))
           %codex-crate-sources)
      (map (lambda (entry) (list (car entry) (cdr entry))) %codex-git-sources)))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://github.com/openai/codex")
    (synopsis "OpenAI coding agent for the terminal")
    (description
     "Codex CLI provides an interactive terminal interface and a non-interactive
coding agent, with tools for editing files, running commands, and reviewing code.
This package builds the CLI and its Code Mode and voice companion programs from
source with locked Rust dependencies.  The V8 engine uses OpenAI's pinned,
sandbox-enabled static release library.")
    (license license:asl2.0)))

;; Keep the small native sandbox and runtime assembly independent of the Rust
;; build, so resource-layout adjustments do not recompile the whole workspace.
(define %codex-bwrap
  (package
    (name "codex-bubblewrap")
    (version (package-version %codex-rust))
    (source (package-source %codex-rust))
    (build-system gnu-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'enter-bubblewrap
            (lambda _ (chdir "codex-rs/vendor/bubblewrap")))
          (replace 'configure
            (lambda _
              (call-with-output-file "config.h"
                (lambda (port)
                  (display "#pragma once\n#define PACKAGE_STRING \"bubblewrap built for Codex\"\n" port)))))
          (replace 'build
            (lambda _
              (invoke "gcc" "-O2" "-D_GNU_SOURCE" "-I."
                      "bubblewrap.c" "bind-mount.c" "network.c" "utils.c"
                      "-lcap" "-o" "bwrap")))
          (replace 'check
            (lambda* (#:key tests? #:allow-other-keys)
              (when tests? (invoke "./bwrap" "--version") (invoke "./bwrap" "--help"))))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (install-file "bwrap" (string-append (assoc-ref outputs "out") "/bin")))))))
    (inputs (list libcap))
    (home-page (package-home-page %codex-rust))
    (synopsis "Bubblewrap sandbox shipped with Codex")
    (description "This builds the bubblewrap C sources vendored in the pinned
Codex release, with the configuration used by its standalone bwrap helper.")
    (license license:lgpl2.0+)))

(define-public codex
  (package
    (inherit %codex-rust)
    (build-system trivial-build-system)
    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))
          (copy-recursively #$%codex-rust #$output)
          (install-file (string-append #$%codex-bwrap "/bin/bwrap")
                        (string-append #$output "/codex-resources"))
          (copy-recursively (string-append #$%codex-bwrap "/share/doc")
                            (string-append #$output "/share/doc")))))
    (native-inputs '())
    (inputs (list %codex-rust %codex-bwrap))
    (license (list license:asl2.0 license:lgpl2.0+))))

;;; Repackage the complete upstream binary distribution, including its helpers.
(define %codex-bin-tinfo
  ;; Upstream zsh requires NCURSES6_TINFO_5.0.19991023.  Guix's regular
  ;; ncurses-with-tinfo exports unversioned symbols, which causes loader warnings.
  (package
    (inherit ncurses/tinfo)
    (name "codex-bin-ncurses-with-tinfo")
    (arguments
     (substitute-keyword-arguments (package-arguments ncurses/tinfo)
       ((#:configure-flags flags)
        #~(cons "--with-versioned-syms" #$flags))))))

(define-public codex-bin
  (package
    (name "codex-bin")
    (version "0.154.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/openai/codex/releases/download/rust-v"
             version "/codex-package-"
             (if (string-prefix? "aarch64" (%current-system))
                 "aarch64" "x86_64")
             "-unknown-linux-musl.tar.gz"))
       (file-name (string-append name "-" version "-" (%current-system)
                                 ".tar.gz"))
       ;; Published in the release's codex-package_SHA256SUMS.
       (sha256
        (base16-string->bytevector
         (if (string-prefix? "aarch64" (%current-system))
             "97d93e11df72d3c26772db019e6ea8bb72c246500d46b98c760839f3240355e6"
             "fc6e3e3b85f2cf7d664520ee5c66a7fe4aa12bae7d46834f47e2f165fd0d6f78")))))
    (build-system copy-build-system)
    (arguments
     (list
      #:strip-binaries? #f
      #:install-plan #~'(("." "./"))
      #:phases
      #~(modify-phases %standard-phases
          ;; The release has several top-level directories, not one source root.
          (replace 'unpack
            (lambda* (#:key source #:allow-other-keys)
              (mkdir "source")
              (chdir "source")
              (invoke "tar" "xf" source)))
          (add-after 'install 'patch-bundled-zsh
            (lambda* (#:key inputs outputs #:allow-other-keys)
              ;; The CLI and Rust helpers are static musl executables, but the
              ;; bundled zsh uses glibc and the separate ncurses terminfo library.
              (let ((zsh (string-append (assoc-ref outputs "out")
                                       "/codex-resources/zsh/bin/zsh")))
                (invoke "patchelf" "--set-interpreter"
                        (search-input-file inputs #$(glibc-dynamic-linker)) zsh)
                (invoke "patchelf" "--set-rpath"
                        (string-append
                         (dirname (search-input-file inputs "/lib/libc.so.6"))
                         ":"
                         (dirname (search-input-file inputs "/lib/libtinfo.so.6")))
                        zsh))))
          (add-after 'patch-bundled-zsh 'check-installed-programs
            (lambda* (#:key outputs tests? #:allow-other-keys)
              (when tests?
                (let ((out (assoc-ref outputs "out")))
                  (invoke (string-append out "/bin/codex") "--version")
                  (invoke (string-append out "/bin/codex") "exec" "--help")
                  (invoke (string-append out "/bin/codex-code-mode-host")
                          "--help")
                  (invoke (string-append out "/codex-resources/bwrap")
                          "--version")
                  (invoke (string-append out "/codex-path/rg") "--version")
                  (invoke (string-append out "/codex-resources/zsh/bin/zsh")
                          "-f" "-e" "-c"
                          "[[ $((6 * 7)) = 42 ]]; print -r -- codex-zsh-ok"))))))))
    (native-inputs (list patchelf))
    (inputs (list glibc %codex-bin-tinfo))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://github.com/openai/codex")
    (synopsis "Prebuilt OpenAI coding agent for the terminal")
    (description
     "Codex CLI provides an interactive terminal interface and a non-interactive
coding agent.  This package installs OpenAI's prebuilt release bundle, including
the Code Mode host, ripgrep, bubblewrap, and zsh.  The application and its
bundled libraries are not compiled from source by this package.")
    (license (list license:asl2.0 license:lgpl2.0+))))
