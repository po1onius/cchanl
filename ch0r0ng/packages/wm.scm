(define-module (ch0r0ng packages wm)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages window-management))

(define-public mangowc-git
  (let ((commit "69e2e22f0330f75d51c40ef8fada0b777b68d05f")
        (revision "0"))
    (package
     (name "mangowc-git")
     (version (git-version "0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/DreamMaoMao/mangowc")
                    (commit commit)))
              (sha256
               (base32
                "0cplyq0i93vvjdby3arg5h99jdlc6v1n9igkwb4ifj40629hkcv9"))))
     (build-system meson-build-system)
     (native-inputs
      (list pkg-config))
     (inputs
      (list wlroots pcre2 scenefx))
     (home-page "https://github.com/DreamMaoMao/mangowc")
     (synopsis "Dynamic window manager for Wayland")
     (description
      "This project is developed based on dwl, it is basically compatible with all dwm features. In addition, it is added many operation that supported in hyprland")
     (license license:expat))))
