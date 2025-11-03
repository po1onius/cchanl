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
