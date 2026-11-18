;;; Google Chrome, taken from nonguix and repackaged with the Ozone platform
;;; forced to Wayland, so that Chrome runs natively on Wayland instead of
;;; through XWayland.
;;;
;;; nonguix' Chrome packages already install a launcher (bin/google-chrome)
;;; which exports CHROME_WRAPPER, LD_LIBRARY_PATH, PATH, FONTCONFIG_PATH and
;;; friends before exec'ing the real binary.  Instead of duplicating all of
;;; that, this module inherits the whole package and only adds one thin
;;; wrapper in front of that launcher, which passes the arguments below and
;;; then defers to it.
;;;
;;; Putting the flag in the package (rather than in a hand-edited .desktop
;;; file) means it survives `guix pull'/`guix home reconfigure', applies to
;;; every way of starting Chrome (menu entry, xdg-open, terminal), and shows
;;; up in the derivation where it belongs.

(define-module (ch0r0ng packages chrome)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (ice-9 regex)
  #:use-module (ice-9 string-fun)
  #:use-module (ice-9 textual-ports)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-13)
  #:use-module (nongnu packages chrome)
  #:export (%chrome-wayland-flags
            chrome-wayland
            google-chrome-stable-wayland))

(define %chrome-wayland-flags
  ;; Space-separated command-line arguments prepended to Chrome's own
  ;; arguments.  Since they come first, an explicit "--ozone-platform=x11"
  ;; typed by the user still takes precedence.
  ;;
  ;; Add e.g. "--enable-wayland-ime --wayland-text-input-version=3" here if
  ;; the input method misbehaves on Wayland.
  (string-append
   "--ozone-platform=wayland"
   " --enable-features=AcceleratedVideoDecodeLinuxGL,"
   "AcceleratedVideoDecodeLinuxZeroCopyGL"))

(define (chrome-launcher-name package)
  "Return the name of the launcher installed by nonguix' PACKAGE under bin/."
  ;; nonguix' make-google-chrome installs "bin/google-<appname>", where
  ;; appname is "chrome" for the stable channel and the package name itself
  ;; for the beta/unstable/canary channels.
  (let ((name (package-name package)))
    (if (string=? name "google-chrome-stable")
        "google-chrome"
        name)))

(define* (chrome-wayland base #:key (name #f))
  "Repackage BASE, a nonguix Google Chrome package, with the Ozone platform
forced to Wayland."
  (package
    (inherit base)
    (name (or name (string-append (package-name base) "-wayland")))
    (arguments
     (substitute-keyword-arguments (package-arguments base)
       ((#:phases phases #~%standard-phases)
        #~(modify-phases #$phases
            ;; Runs after nonguix' own 'install-wrapper' phase, so that
            ;; bin/google-chrome is already the wrapped launcher and only
            ;; needs to be pushed one layer down.
            (add-after 'install-wrapper 'install-wayland-wrapper
              (lambda _
                ;; These modules are needed inside the build environment;
                ;; module-level imports are not visible in the gexp phase.
                (use-modules (guix build utils)
                             (ice-9 regex)
                             (ice-9 string-fun)
                             (ice-9 textual-ports)
                             (srfi srfi-1)
                             (srfi srfi-13))
                (let* ((bin (string-append #$output "/bin"))
                       (launcher #$(chrome-launcher-name base))
                       (exe (string-append bin "/" launcher))
                       (wrapped (string-append bin "/." launcher "-wrapped")))
                  (rename-file exe wrapped)

                  ;; Guix 的 libglvnd 没有 Mesa 的 EGL vendor 配置，而 Mesa
                  ;; 提供的是单体 libEGL；nonguix 的 launcher 却把 libglvnd
                  ;; 放在 Mesa 前面，Chrome 的 ANGLE 因此报
                  ;; "Failed to get system egl display"。
                  ;; 把 Mesa 的 lib 目录移到 LD_LIBRARY_PATH 最前面，
                  ;; 让 libEGL.so.1 直接解析到 Mesa。
                  (let* ((text (call-with-input-file wrapped get-string-all))
                         (m (string-match "LD_LIBRARY_PATH=\"([^\"]*)\"" text))
                         (dirs (and m
                                    (string-split (match:substring m 1) #\:)))
                         (mesa (and dirs
                                    (find (lambda (dir)
                                            (and (string-contains dir "mesa-")
                                                 (file-exists?
                                                  (string-append dir "/libEGL.so.1"))))
                                          dirs))))
                    (unless mesa
                      (error "chrome-wayland: no Mesa libEGL directory in Chrome's LD_LIBRARY_PATH"))
                    (substitute* wrapped
                      (("LD_LIBRARY_PATH=\"[^\"]*\"")
                       (string-append "LD_LIBRARY_PATH=\""
                                      (string-join (cons mesa (delete mesa dirs)) ":")
                                      "\""))))

                  (call-with-output-file exe
                    (lambda (port)
                      (format port
                              "#!~a~%exec -a \"${0##*/}\" \"~a\" ~a \"$@\"~%"
                              (which "bash")
                              wrapped
                              #$%chrome-wayland-flags)))
                  (chmod exe #o555))))))))
    (synopsis (string-append (package-synopsis base)
                             ", running natively on Wayland"))))

(define-public google-chrome-stable-wayland
  (chrome-wayland google-chrome-stable))

;; The same treatment is available for the other channels, e.g.:
;;
;;   (chrome-wayland google-chrome-beta)
;;   (chrome-wayland google-chrome-unstable)
