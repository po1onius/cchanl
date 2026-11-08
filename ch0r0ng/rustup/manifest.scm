;;; SPDX-License-Identifier: GPL-3.0-or-later
;;; Rust distribution manifests: keep upstream names and URLs, not enum indexes.
(define-module (ch0r0ng rustup manifest)
  #:use-module (ch0r0ng rustup toml)
  #:use-module (guix http-client)
  #:use-module (guix base16)
  #:use-module (guix utils)
  #:use-module (gcrypt hash)
  #:use-module (rnrs bytevectors)
  #:use-module (ice-9 textual-ports)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1)
  #:export (read-manifest fetch-manifest manifest-version manifest-sources
            system->rust-target channel-manifest-url))

(define (system->rust-target system)
  (match system
    ("x86_64-linux" "x86_64-unknown-linux-gnu")
    ("aarch64-linux" "aarch64-unknown-linux-gnu")
    ("i686-linux" "i686-unknown-linux-gnu")
    ("armhf-linux" "armv7-unknown-linux-gnueabihf")
    ("riscv64-linux" "riscv64gc-unknown-linux-gnu")
    (_ (error "Unsupported Rust toolchain host system" system))))

(define (dist-server)
  (string-trim-right (or (getenv "RUSTUP_DIST_SERVER")
                         "https://static.rust-lang.org") #\/))

(define (channel-manifest-url channel)
  (let ((m (and (string? channel)
                (string-match "^(stable|beta|nightly|[0-9]+\\.[0-9]+(\\.[0-9]+)?)(-([0-9]{4}-[0-9]{2}-[0-9]{2}))?$" channel))))
    (unless m (error "Invalid Rust channel (use a version or dated channel)" channel))
    (string-append (dist-server) "/dist/"
                   (if (match:substring m 4)
                       (string-append (match:substring m 4) "/") "")
                   "channel-rust-" (match:substring m 1) ".toml")))

(define (verify-manifest text checksum)
  (let ((expected (car (string-tokenize checksum)))
        (actual (bytevector->base16-string (sha256 (string->utf8 text)))))
    (unless (string=? expected actual)
      (error "Rust manifest SHA256 mismatch" expected actual))
    (let ((data (parse-toml text)))
      (unless (equal? (assoc-ref data "manifest-version") "2")
        (error "Unsupported Rust manifest version" (assoc-ref data "manifest-version")))
      data)))

(define (read-manifest file)
  "Read a pinned upstream TOML manifest and its adjacent .sha256 file."
  (verify-manifest (call-with-input-file file get-string-all)
                   (call-with-input-file (string-append file ".sha256") get-string-all)))

(define (fetch-text url)
  ;; Only explicit rustup calls fetch. Importing the module never accesses the
  ;; network or store. Guix caches moving channels for one hour, immutable ones
  ;; also remain protected by their upstream checksum.
  (let ((port (http-fetch/cached url #:ttl 3600 #:text? #t)))
    (dynamic-wind (lambda () #t)
                  (lambda () (get-string-all port))
                  (lambda () (close-port port)))))

(define (fetch-manifest channel)
  (let* ((url (channel-manifest-url channel))
         (checksum (fetch-text (string-append url ".sha256")))
         (text (fetch-text url)))
    (verify-manifest text checksum)))

(define (manifest-version data)
  (let ((v (car (string-tokenize
                 (or (recursive-assoc-ref data '("pkg" "rust" "version"))
                     (recursive-assoc-ref data '("pkg" "rustc" "version")))))))
    (if (or (string-contains v "nightly") (string-contains v "beta"))
        (string-append v "-" (assoc-ref data "date")) v)))

(define (as-name value)
  (cond ((symbol? value) (symbol->string value))
        ((string? value) value)
        (else (error "Expected a Rust component or target name" value))))

(define (mirror-url url)
  (let ((prefix "https://static.rust-lang.org/"))
    (if (string-prefix? prefix url)
        (string-append (dist-server) "/" (substring url (string-length prefix)))
        url)))

(define* (manifest-sources data host #:key (profile 'default)
                           (components '()) (targets '()))
  "Return (COMPONENT TARGET URL SHA256) entries; validate selected entries only."
  (unless (and (list? components) (list? targets))
    (error "Rust components and targets must be lists" components targets))
  (let* ((packages (assoc-ref data "pkg"))
         (profiles (assoc-ref data "profiles"))
         (selected (assoc-ref profiles (as-name profile)))
         (renames (assoc-ref data "renames")))
    (unless selected (error "Unknown Rust profile" profile))
    (define (canonical name)
      (or (and=> (assoc-ref renames (as-name name))
                 (lambda (entry) (assoc-ref entry "to"))) (as-name name)))
    (define (entry name target required?)
      (let* ((name (canonical name))
             (pkg (assoc-ref packages name))
             (platforms (and pkg (assoc-ref pkg "target")))
             (item (and platforms (or (assoc-ref platforms target)
                                     (assoc-ref platforms "*")))))
        (cond
         ((and item (assoc-ref item "available"))
          (let ((prefix (find (lambda (prefix)
                                (and (assoc-ref item (string-append prefix "url"))
                                     (assoc-ref item (string-append prefix "hash"))))
                              '("xz_" ""))))
            (unless prefix (error "Missing Rust component URL/hash" name target))
            (list name (if (assoc-ref platforms target) target "*")
                  (mirror-url (assoc-ref item (string-append prefix "url")))
                  (assoc-ref item (string-append prefix "hash")))))
         (required? (error "Rust component unavailable for selected toolchain/target"
                           name target (manifest-version data)))
         (else #f))))
    (delete-duplicates
     (append
      ;; Profiles can contain platform-specific or unavailable optional tools.
      ;; The compiler, cargo and host std must always be present.
      (map (lambda (name) (entry name host #t)) '("rustc" "cargo" "rust-std"))
      (filter-map (lambda (name) (entry name host #f)) selected)
      (map (lambda (name) (entry name host #t)) components)
      (map (lambda (target) (entry "rust-std" (as-name target) #t)) targets)))))
