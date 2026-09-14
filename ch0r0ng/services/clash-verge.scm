;;; System integration for the Clash Verge Rev binary GUI and IPC service.
(define-module (ch0r0ng services clash-verge)
  #:use-module (guix gexp)
  #:use-module (guix modules)
  #:use-module (guix records)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services configuration)
  #:use-module (gnu services linux)
  #:use-module (gnu services shepherd)
  #:use-module (gnu system accounts)
  #:use-module (gnu system shadow)
  #:use-module (ch0r0ng packages clash-verge)
  #:export (clash-verge-configuration
            clash-verge-configuration?
            clash-verge-service-type))

(define-configuration/no-serialization clash-verge-configuration
  (core
   (file-like mihomo)
   "Mihomo package the privileged service is permitted to execute.")
  (gui
   (file-like clash-verge-rev-bin)
   "GUI package installed in the system profile.")
  (install-gui?
   (boolean #t)
   "Whether to install the GUI in the system profile.")
  (group
   (string "clash-verge")
   "Dedicated group permitted to control the privileged service.")
  (auto-start?
   (boolean #t)
   "Whether Shepherd starts the service automatically."))

(define %runtime-modules
  ;; The default selector only accepts Guix's own module namespaces.
  (source-module-closure '((ch0r0ng build clash-verge))
                         #:select? (lambda (name)
                                     (memq (car name) '(ch0r0ng guix gnu)))))

(define (clash-verge-accounts config)
  (list (user-group
         (name (clash-verge-configuration-group config))
         (system? #t))))

(define (clash-verge-activation config)
  (with-imported-modules %runtime-modules
    #~(begin
        (use-modules (ch0r0ng build clash-verge))
        (prepare-clash-verge-directories
         (group:gid (getgrnam #$(clash-verge-configuration-group config)))))))

(define (clash-verge-shepherd config)
  (let ((daemon (clash-verge-service-for
                 (clash-verge-configuration-core config)))
        (group (clash-verge-configuration-group config)))
    (list
     (shepherd-service
      (documentation "Run Clash Verge's privileged IPC service and selected Mihomo core.")
      (provision '(clash-verge))
      (requirement '(user-processes networking))
      (auto-start? (clash-verge-configuration-auto-start? config))
      (respawn? #t)
      (modules '((shepherd service) (ch0r0ng build clash-verge)))
      (start
       (with-imported-modules %runtime-modules
         #~(lambda _
             ;; /run and /tmp may have been cleared since activation, or the
             ;; service may have been stopped and restarted manually.
             (prepare-clash-verge-directories (group:gid (getgrnam #$group)))
             ((make-forkexec-constructor
               (list #$(file-append daemon "/bin/clash-verge-service"))
               #:user "root"
               #:group #$group
               #:file-creation-mask #o027
               #:directory "/var/lib/clash-verge-service"
               #:log-file "/var/log/clash-verge-service/daemon.log"
               #:environment-variables
               '("XDG_STATE_HOME=/var/lib" "RUST_LOG=info"))))))
      (stop #~(make-kill-destructor))))))

(define clash-verge-service-type
  (service-type
   (name 'clash-verge)
   (extensions
    (list
     (service-extension account-service-type clash-verge-accounts)
     (service-extension activation-service-type clash-verge-activation)
     (service-extension shepherd-root-service-type clash-verge-shepherd)
     (service-extension kernel-module-loader-service-type (const '("tun")))
     (service-extension profile-service-type
                        (lambda (config)
                          (if (clash-verge-configuration-install-gui? config)
                              (list (clash-verge-configuration-gui config))
                              '())))))
   (default-value (clash-verge-configuration))
   (description "Run the Clash Verge IPC service with a fixed Mihomo core and
restricted socket access.  Only trusted members should be granted access.  TUN
mode is selected in the GUI; this service does not change firewall or DNS policy.")))
