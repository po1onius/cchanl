(define-module (ch0r0ng packages wm)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system haskell)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages build-tools)
  #:use-module (gnu packages calendar)
  #:use-module (gnu packages check)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages crates-check)
  #:use-module (gnu packages crates-compression)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages datastructures)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages haskell-check)
  #:use-module (gnu packages haskell-web)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libbsd)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp-check)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages logging)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpd)
  #:use-module (gnu packages pciutils)
  #:use-module (gnu packages music)
  #:use-module (gnu packages pantheon)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages regex)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))


(define-public wayland-protocols
  (package
   (name "wayland-protocols")
   (version "1.45")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://gitlab.freedesktop.org/wayland/wayland-protocols")
                  (commit version)))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "1d2fv41vq75pvgkd3ykjypnp8zv0afv71p36cd91h19lbmwaia8h"))))
   (build-system meson-build-system)
   (inputs
    (list wayland))
   (native-inputs (cons* pkg-config python
                         (if (%current-target-system)
                             (list pkg-config-for-build
                                   wayland) ; for wayland-scanner
                             '())))
   (synopsis "Wayland protocols")
   (description "Wayland-Protocols contains Wayland protocols that add
functionality not available in the Wayland core protocol.  Such protocols either
add completely new functionality, or extend the functionality of some other
protocol either in Wayland core, or some other protocol in wayland-protocols.")
   (home-page "https://wayland.freedesktop.org")
   (license license:expat)))



(define-public pixman
  (package
   (name "pixman")
   (version "0.46.4")
   (source
    (origin
     (method url-fetch)
     (uri
      (string-append
       "https://www.cairographics.org/releases/pixman-"
       version ".tar.gz"))
     (sha256
      (base32 "072rd8sd454rzybmxx90fdzvabzvx0pr57y745qfwnxxqgml976h"))))
   (build-system meson-build-system)
   (native-inputs
    (list pkg-config))
   (inputs
    (list libpng zlib))
   (synopsis "Low-level pixel manipulation library")
   (description "Pixman is a low-level software library for pixel
manipulation, providing features such as image compositing and trapezoid
rasterisation.")
   (home-page "http://www.pixman.org/")
   (license license:expat)))


(define-public scenefx
  (package
   (name "scenefx")
   (version "0.4.1")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/wlrfx/scenefx")
                  (commit version)))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "10f4rygnb8qrlcxw6f3gpl4xa20wrykx63cvn8wih74smdr48gjw"))))
   (build-system meson-build-system)
   (native-inputs (list pkg-config
                        ;; for wayland-scanner.
                        wayland))
   (inputs (list pixman
                 mesa
                 libxkbcommon
                 libdrm
                 wlroots))
   (home-page "https://github.com/wlrfx/scenefx")
   (synopsis "Drop-in replacement for the wlroots scene API")
   (description
    "A drop-in replacement for the wlroots scene API that allows wayland
compositors to render surfaces with eye-candy effects.")
   (license license:expat)))


(define-public wlroots
  (package
   (name "wlroots")
   (version "0.19.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://gitlab.freedesktop.org/wlroots/wlroots")
           (commit version)))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1fa4gi2c6iil4k0xmqf2jx1apqg3pk0r4lrf23blpfiz439zkk13"))))
   (build-system meson-build-system)
   (arguments
    (list #:phases
          #~(modify-phases %standard-phases
			   (add-before 'configure 'hardcode-paths
				       (lambda* (#:key inputs #:allow-other-keys)
						(substitute* "xwayland/server.c"
							     (("Xwayland")
							      (search-input-file inputs "bin/Xwayland")))))
			   (add-before 'configure 'fix-meson-file
				       (lambda* (#:key native-inputs inputs #:allow-other-keys)
						(substitute* "backend/drm/meson.build"
							     (("/usr/share/hwdata/pnp.ids")
							      (search-input-file
							       (or native-inputs inputs) "share/hwdata/pnp.ids"))))))))
   (propagated-inputs
    (list ;; As required by wlroots.pc.
     eudev
     libdisplay-info
     libinput-minimal
     libxkbcommon
     mesa
     pixman
     lcms
     libseat
     vulkan-headers
     vulkan-loader
     wayland
     wayland-protocols
     xcb-util-errors
     xcb-util-wm
     xorg-server-xwayland))
   (native-inputs
    (cons*
     glslang
     hwdata
     pkg-config
     wayland
     (if (%current-target-system)
         (list pkg-config-for-build)
         '())))
   (home-page "https://gitlab.freedesktop.org/wlroots/wlroots/")
   (synopsis "Pluggable, composable, unopinionated modules for building a
Wayland compositor")
   (description "wlroots is a set of pluggable, composable, unopinionated
modules for building a Wayland compositor.")
   (license license:expat)))  ; MIT license


(define-public mango-git
  (let ((commit "c19fe0df8c23fe3b3e59e3231f1428acfd90ab4a")
        (revision "0"))
    (package
     (name "mango-git")
     (version (git-version "0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/DreamMaoMao/mango")
                    (commit commit)))
              (sha256
               (base32
		"1vym56gvbkwz8k21hayqc1na2bj2nmsl92iv4h5vr37l3mb4vyrh"))))
     (build-system meson-build-system)
     (native-inputs
      (list pkg-config))
     (inputs
      (list wlroots pcre2 scenefx))
     (home-page "https://github.com/DreamMaoMao/mango")
     (synopsis "Dynamic window manager for Wayland")
     (description
      "This project is developed based on dwl, it is basically compatible with all dwm features. In addition, it is added many operation that supported in hyprland")
     (license license:expat))))


(define-public waybar-git
  (let ((commit "0776e694df56c2c849b682369148210d81324e93")
        (revision "0"))
    (package
     (name "waybar-git")
     (version (git-version "0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Alexays/Waybar")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ynvy6maz4kl4xik2iv86xjrlk62aixc9q79fm5ha0axlvh7n0xg"))))
     (build-system meson-build-system)
     (arguments
      (list #:configure-flags #~(list "--wrap-mode=nodownload")))
     (inputs (list date
                   fmt
                   gtk-layer-shell
                   gtkmm-3
                   jsoncpp
                   libdbusmenu
                   libevdev
                   libinput-minimal
                   libmpdclient
                   libnl
                   libxml2
                   pipewire
                   playerctl
                   pulseaudio
                   spdlog-1.13
                   wayland
                   wireplumber))
     (native-inputs
      (list `(,glib "bin") pkg-config scdoc wayland-protocols))
     (home-page "https://github.com/Alexays/Waybar")
     (synopsis "Wayland bar for Sway and Wlroots based compositors")
     (description "Waybar is a highly customisable Wayland bar for Sway and
Wlroots based compositors.")
     (license license:expat)))) ; MIT license
