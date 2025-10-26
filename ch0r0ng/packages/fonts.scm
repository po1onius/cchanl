(define-module (ch0r0ng packages fonts)
  #:use-module (ice-9 string-fun)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fonts)
  #:use-module (guix deprecation)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system font)
  #:use-module (guix build-system copy)
  #:use-module (nonguix licenses))

(define* (apple-font #:key
                     font-name
                     archive-timestamp
                     version
                     file
                     hash
                     synopsis
                     description)
  (package
    (name (string-append "font-apple-"
                         (string-replace-substring
                          (string-downcase font-name)
                          " " "-")))
    (version version)
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             ;; Download link is unversioned, use a stable snapshot.
             "https://web.archive.org/web/" archive-timestamp "/"
             "https://devimages-cdn.apple.com/design/resources/download/"
             file ".dmg"))
       (sha256
        (base32 hash))))
    (build-system font-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack
            (lambda* (#:key source inputs #:allow-other-keys)
              (let ((7z-exe (search-input-file inputs "/bin/7z")))
                (invoke 7z-exe "x" source)
                (invoke 7z-exe "x" (car (find-files "." "\\.pkg$")))
                (invoke 7z-exe "x" (car (find-files "." "\\Payload$")))
                (invoke 7z-exe "x" "Payload~")))))))
    (native-inputs (list 7zip))
    (home-page "https://developer.apple.com/fonts")
    (synopsis (string-append font-name " typeface by Apple."))
    (description description)
    (license
     (nonfree
      "https://www.apple.com"
      "Specific license information is embedded in the font files."))))


(define-public font-apple-sf-mono
  (apple-font
   #:font-name "SF Mono"
   #:archive-timestamp "20240527221346"
   #:file "SF-Mono"
   #:version "20.0d8e1"
   #:hash "0cxj1wk6nbz1ysi0cg1w79b7ja48n00dypxkrsc3mvrn1vmdb4dm"
   #:description "This monospaced variant of San Francisco enables alignment
between rows and columns of text, and is used in coding environments like Xcode.
SF Mono features six weights and supports Latin, Greek, and Cyrillic scripts."))

