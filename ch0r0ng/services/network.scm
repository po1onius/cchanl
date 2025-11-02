(define-module (ch0r0ng services network)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services shepherd)
  #:use-module (gnu system file-systems)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services configuration)
  #:use-module (rosenthal packages networking)
  #:export (home-clash-configuration
            home-clash-service-type
            dae-service-configuration
            dae-service-type))

(define (file-object? val)
  (or (string? val)
      (file-like? val)))


(define-configuration home-clash-configuration
  (clash
   (file-like mihomo)
   "The clash package.")
  (config-path
   (string ".config/clash")
   "config path")
  (no-serialization))

(define clash-shepherd-service
  (match-record-lambda
   <home-clash-configuration>
   (clash config-path)
   (list
    (shepherd-service
     (documentation "Run clash.")
     (provision (list 'clash))
     (start
      #~(make-forkexec-constructor
         (list
          (let ((mihomo-cmd
                 #$(file-append clash "/bin/mihomo"))
                (clash-cmd
                 #$(file-append clash "/bin/clash")))
            (if (file-exists? mihomo-cmd)
                mihomo-cmd
                clash-cmd))
          "-d" #$config-path)))
     (stop #~(make-kill-destructor))))))

(define home-clash-service-type
  (service-type
   (name 'clash)
   (extensions
    (list (service-extension
           home-shepherd-service-type
           clash-shepherd-service)))
   (description "clash service")
   (default-value (home-clash-configuration))))


(define-configuration/no-serialization dae-service-configuration
  (dae
   (file-like dae-bin)
   "dae package to be used")
  (config-file
   file-object
   "dae configuration")
  (assets-path
   (string "")
   "Directory containing geoip.dat and geosite.dat")
  (log-file
   (string "/var/log/dae.log")
   "The file to which dae’s standard output and standard error are redirected")
  (auto-start?
   (boolean #t)
   "Whether to auto start dae"))

(define dae-activation
  (match-record-lambda <dae-service-configuration>
      (dae assets-path)
    #~(begin
        (use-modules (guix build utils))
        (mkdir-p #$assets-path))))

(define dae-shepherd-service
  (match-record-lambda
   <dae-service-configuration>
   (dae config-file assets-path
        log-file auto-start?)
   (let ((environment
          #~(list (string-append "DAE_LOCATION_ASSET="
                                 (if (string=? #$assets-path "")
                                     #$(file-append dae "/share/dae")
                                     #$assets-path)))))
     (list (shepherd-service
            (provision '(dae))
            (requirement '(user-processes
                           networking
                           root-file-system
                           file-system-/sys/fs/bpf))
            (start
             #~(make-forkexec-constructor
                (list #$(file-append dae "/bin/dae")
                      "run"
                      "--config" #$config-file)
                #:environment-variables #$environment))
            (stop #~(make-kill-destructor))
            (auto-start? auto-start?))))))


(define bpf-file-system
  (file-system
   (device "none")
   (mount-point "/sys/fs/bpf")
   (type "bpf")
   (check? #f)
   (needed-for-boot? #f)
   (mount-may-fail? #t)
   (create-mount-point? #f)))

(define dae-service-type
  (service-type
    (name 'dae)
    (extensions
     (list (service-extension activation-service-type
                              dae-activation)
           (service-extension shepherd-root-service-type
                              dae-shepherd-service)
           (service-extension file-system-service-type
                              (const (list bpf-file-system)))))
    (description "Service for dae, a proxy solution using eBPF.")))

