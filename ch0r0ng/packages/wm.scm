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
    (version "1.43")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://gitlab.freedesktop.org/wayland/wayland-protocols")
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1pgjkc0gw11xb55kn8hf8adnmx3bkpgb4p0haylb2jh7irqhxhqd"))))
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
    (version "0.44.0")
    (source
     (origin
       (method url-fetch)
       (uri
        (string-append
         "https://www.cairographics.org/releases/pixman-"
         version ".tar.gz"))
       (sha256
        (base32 "1b3xib3zwf8p5qmnkmr76zzf1zdg5v5h50khzvgj62sywkhw3949"))))
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


(define-public wlroots
  (package
    (name "wlroots")
    (version "0.19.0-rc1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://gitlab.freedesktop.org/wlroots/wlroots")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0a3hc0f8722q3x7vjsdx8yd38x7d304hrswl857d1c1syrzy1p5k"))))
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


(define-public maomaowm
  (package
    (name "maomaowm")
    (version "0.4.1")
    (source (origin
              (method url-fetch)
              ;https://github.com/DreamMaoMao/maomaowm/archive/refs/tags/0.4.1.tar.gz
              (uri (string-append "https://github.com/DreamMaoMao/maomaowm/archive/refs/tags/"
                                  version ".tar.gz"))
              (sha256
               (base32
                "007fny3dj0sxfxvd5c7jmi56cdfd2zv753pzhmxn3c9pi7nvhnlf"))))
    (build-system meson-build-system)
    (native-inputs
     (list pkg-config))
    (inputs
     (list wlroots))
    (home-page "https://codeberg.org/dwl/dwl")
    (synopsis "Dynamic window manager for Wayland")
    (description
     "@command{dwl} is a compact, hackable compositor for Wayland based on
wlroots.  It is intended to fill the same space in the Wayland world that dwm
does in X11, primarily in terms of philosophy, and secondarily in terms of
functionality.  Like dwm, dwl is easy to understand and hack on, due to a
limited size and a few external dependencies.  It is configurable via
@file{config.h}.")
    ;;             LICENSE       LICENSE.dwm   LICENSE.tinywl
    (license (list license:gpl3+ license:expat license:cc0))))
