;;; Shepherd integration for Clash Verge Rev's privileged IPC service.
(define-module (ch0r0ng services clash-verge)
  #:use-module (guix gexp)
  #:use-module (guix modules)
  #:use-module (guix records)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services configuration)
  #:use-module (gnu services linux)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services sysctl)
  #:use-module (gnu system accounts)
  #:use-module (gnu system privilege)
  #:use-module (gnu system shadow)
  #:use-module (ch0r0ng packages clash-verge)
  #:export (clash-verge-configuration
            clash-verge-configuration?
            clash-verge-service-type))

(define %runtime-modules
  (source-module-closure '((guix build utils))))

(define-configuration/no-serialization clash-verge-configuration
  (package
   (file-like clash-verge-rev-bin)
   "Clash Verge Rev package to run.")
  (group
   (string "clash-verge")
   "System group allowed to access the Clash Verge service socket.")
  (install-gui?
   (boolean #t)
   "Whether to install the GUI package in the system profile.")
  (auto-start?
   (boolean #t)
   "Whether Shepherd starts the service automatically.")
  (tun-mode?
   (boolean #f)
   "Whether to enable the capabilities and kernel settings required by
TUN mode."))

(define (clash-verge-accounts config)
  (list (user-group
         (name (clash-verge-configuration-group config))
         (system? #t))))

(define (clash-verge-prepare-directories config)
  (let ((group (clash-verge-configuration-group config)))
    (with-imported-modules %runtime-modules
      #~(begin
        (use-modules (guix build utils))
        (let ((gid (group:gid (getgrnam #$group))))
          ;; The service binary uses this fixed path after the binary patch.
          ;; Do not let it create a socket directory in world-writable /tmp.
          (mkdir-p "/run/cvgeX")
          (chown "/run/cvgeX" 0 gid)
          (chmod "/run/cvgeX" #o2770)
          (mkdir-p "/var/lib/clash-verge-service")
          (chown "/var/lib/clash-verge-service" 0 gid)
          (chmod "/var/lib/clash-verge-service" #o750)
          (mkdir-p "/var/log/clash-verge-service")
          (chown "/var/log/clash-verge-service" 0 gid)
          (chmod "/var/log/clash-verge-service" #o750))))))

(define (clash-verge-shepherd config)
  (let ((package (clash-verge-configuration-package config))
        (group (clash-verge-configuration-group config)))
    (list
     (shepherd-service
      (documentation "Run Clash Verge Rev's privileged service mode.")
      (provision '(clash-verge))
      (requirement '(user-processes networking root-file-system))
      (auto-start? (clash-verge-configuration-auto-start? config))
      (respawn? #t)
      (start
       (with-imported-modules %runtime-modules
         #~(lambda _
           ;; /run is volatile, so repeat the directory policy on every
           ;; manual Shepherd restart as well as during system activation.
           (use-modules (guix build utils))
           (let ((gid (group:gid (getgrnam #$group))))
             (mkdir-p "/run/cvgeX")
             (chown "/run/cvgeX" 0 gid)
             (chmod "/run/cvgeX" #o2770)
             (mkdir-p "/var/lib/clash-verge-service")
             (chown "/var/lib/clash-verge-service" 0 gid)
             (chmod "/var/lib/clash-verge-service" #o750)
             (mkdir-p "/var/log/clash-verge-service")
             (chown "/var/log/clash-verge-service" 0 gid)
             (chmod "/var/log/clash-verge-service" #o750))
           ((make-forkexec-constructor
             (list #$(file-append package "/bin/clash-verge-service"))
             #:user "root"
             #:group #$group
             #:directory "/var/lib/clash-verge-service"
             #:log-file "/var/log/clash-verge-service/daemon.log"
             #:environment-variables
             '("XDG_STATE_HOME=/var/lib" "RUST_LOG=info"))))))
      (stop #~(make-kill-destructor))))))

(define (clash-verge-privileged-programs config)
  (if (clash-verge-configuration-tun-mode? config)
      ;; The GUI asks the service to launch this fixed privileged path when
      ;; TUN mode is active.  Give the capability-bearing copy to the core,
      ;; not to the GUI: a capability-bearing GTK process enters AT_SECURE,
      ;; which breaks session-bus environment handling and prevents Tauri
      ;; from locating its resources relative to the store executable.
      (list
       (privileged-program
        (program (file-append
                  (clash-verge-configuration-package config)
                  "/bin/verge-mihomo"))
        (capabilities "cap_net_bind_service,cap_net_raw,cap_net_admin=ep")))
      '()))

(define (clash-verge-sysctl-settings config)
  (if (clash-verge-configuration-tun-mode? config)
      ;; Match NixOS's loose reverse path filtering for policy-routed TUN
      ;; traffic.  Set both existing and newly-created interfaces.
      '(("net.ipv4.conf.all.rp_filter" . "2")
        ("net.ipv4.conf.default.rp_filter" . "2"))
      '()))

(define clash-verge-service-type
  (service-type
   (name 'clash-verge)
   (extensions
    (list
     (service-extension account-service-type clash-verge-accounts)
     (service-extension activation-service-type
                        clash-verge-prepare-directories)
     (service-extension shepherd-root-service-type clash-verge-shepherd)
     (service-extension privileged-program-service-type
                        clash-verge-privileged-programs)
     (service-extension sysctl-service-type clash-verge-sysctl-settings)
     ;; Clash Verge's TUN mode needs this module.  Only load it when the
     ;; corresponding service option is enabled.
     (service-extension kernel-module-loader-service-type
                        (lambda (config)
                          (if (clash-verge-configuration-tun-mode? config)
                              '("tun")
                              '())))
     (service-extension profile-service-type
                        (lambda (config)
                          (if (clash-verge-configuration-install-gui? config)
                              (list (clash-verge-configuration-package config))
                              '())))))
   (default-value (clash-verge-configuration))
   (description
    "Run Clash Verge Rev's bundled IPC service under Shepherd.  The service
socket is restricted to the configured group; add desktop users that need GUI
control to that group.  The upstream systemd installer is not used.")))
