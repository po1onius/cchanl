(define-module (ch0r0ng services network)
#:use-module (rosenthal packages binaries)
	#:use-module     (gnu services configuration)
	#:use-module     (gnu services)
	#:use-module     (guix gexp)
	#:use-module     (guix records)
	#:use-module     (gnu home services shepherd)
#:use-module (gnu home services)
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
