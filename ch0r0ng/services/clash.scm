(define-module (ch0r0ng services clash)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (ice-9 match)
  #:export (clash-configuration
            clash-service-type))

(define-record-type* <clash-configuration>
  clash-configuration make-myservice-configuration
  clash-configuration?
  (param1 myservice-configuration-param1
          (default "foo")))

(define clash-service-type 
  (match-lambda
    (($ <clash-configuration> param1)
      (list (shepherd-service
              (provision '(clash))
              (documentation "clash service")
              (requirement '(networking))  ; services need to be started before current service
              (start #~(make-forkexec-constructor
                        (list (string-append #$mihomo-bin "/bin/mihomo")
                              "-foo" "-bar" ; list of command line arguments
                          )))
              (stop #~(make-kill-destructor)))))))

(define myservice-service-type
  (service-type
    (name 'myservice)
    (extensions (list (service-extension shepherd-root-service-type
                                         myservice-shepherd-service)))
    (default-value (myservice-configuration))))
