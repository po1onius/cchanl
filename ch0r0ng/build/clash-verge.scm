;;; Runtime directory policy shared by activation and Shepherd restarts.
(define-module (ch0r0ng build clash-verge)
  #:use-module (guix build utils)
  #:export (prepare-clash-verge-directories))

(define (maybe-lstat path)
  (catch 'system-error
    (lambda () (lstat path))
    (lambda args
      (if (= ENOENT (system-error-errno args)) #f (apply throw args)))))

(define* (prepare-clash-verge-directories gid
                                        #:key (root "") (owner 0))
  "Prepare root-owned directories and the binary GUI's compatibility link.
ROOT and OWNER allow exercising this policy in an unprivileged temporary tree."
  (define (path name) (string-append root name))
  (define (directory name mode group)
    (let* ((name (path name))
           (info (maybe-lstat name)))
      (when (and info
                 (or (not (eq? 'directory (stat:type info)))
                     (not (= owner (stat:uid info)))
                     (not (zero? (logand #o022 (stat:perms info))))))
        (error "Clash Verge directory must be owned by root and not writable by others" name))
      (unless info (mkdir name #o700))
      (chown name owner group)
      (chmod name mode)))
  ;; Parents are provided by Guix System.  Do not recursively follow or replace
  ;; existing user-controlled paths under /tmp.
  (directory "/run/clash-verge-rev" #o750 gid)
  (directory "/var/lib/clash-verge-service" #o700 gid)
  (directory "/var/log/clash-verge-service" #o750 gid)
  (let* ((link (path "/tmp/verge"))
         (target (path "/run/clash-verge-rev"))
         (info (maybe-lstat link)))
    (cond
     ((not info) (symlink target link))
     ((and (eq? 'symlink (stat:type info))
           (= owner (stat:uid info))
           (string=? target (readlink link))) #t)
     (else
      (error "Clash Verge refuses to replace existing /tmp/verge; stop the old instance and inspect that path" link))))
  #t)
