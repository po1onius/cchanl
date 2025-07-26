(define-module (ch0r0ng services network)

  #:use-module     (gnu home)
	#:use-module     (gnu home services)
	#:use-module     (gnu home services sound)
	#:use-module     (gnu packages wm)
	#:use-module     (gnu packages image)
	#:use-module     (gnu packages ssh)
	#:use-module     (gnu packages fcitx5)
	#:use-module     (gnu packages gtk)
	#:use-module     (gnu packages terminals)
	#:use-module     (gnu packages linux)
	#:use-module     (gnu packages xdisorg)
	#:use-module     (gnu packages text-editors)
	#:use-module     (gnu packages containers)
	#:use-module     (gnu packages freedesktop)
	#:use-module     (gnu packages fonts)
	#:use-module     (gnu packages version-control)
	#:use-module     (gnu packages package-management)
	#:use-module     (gnu services configuration)
	#:use-module     (gnu home services shells)
	#:use-module     (gnu home services desktop)
	#:use-module     (gnu home services shepherd)
	#:use-module     (guix gexp)
	#:use-module     (guix records)
	#:use-module     (nongnu packages chrome)
	#:use-module     (nongnu packages fonts)
	#:use-module     (ch0r0ng packages wm)
	#:use-module     (gnu services)
	#:use-module     (gnu system shadow)
	#:use-module     (rosenthal packages binaries)

#:export (home-clash-service-type
          home-clash-configuration))


(define-configuration home-clash-configuration
  (clash
   (file-like mihomo-bin)
   "The clash package.")

  (config-path
   (string ".config/clash")
   "config path")
  (no-serialization))

(define clash-shepherd-service
  (match-record-lambda
   <clash-configuration>
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
