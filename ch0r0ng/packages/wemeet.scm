;;; wemeet —— 腾讯会议（Linux 官方 .deb 二进制）
;;;
;;; 参考 nixpkgs 的 pkgs/by-name/we/wemeet：
;;;   * source 直接用官方 .deb（fixed-output origin），nonguix 的
;;;     binary-build-system 会 ar x + tar x 解开；
;;;   * 布局按 nixpkgs：opt/wemeet -> $out/app/wemeet，外加 qt.conf 修正、
;;;     desktop 文件修正、几个软链、图标；
;;;   * 补丁（nixpkgs 同名做法）：
;;;       - libwemeet_base.so 里 co_jump_to_link 的协程寄存器补丁
;;;         （48 83 ff 00 -> 49 83 fc 00），不打通话时会崩；
;;;       - 三个 LD_PRELOAD 小库（见下面 wemeet-shims）；
;;;   * bin/wemeet 走原生 Wayland，bin/wemeet-xwayland 强制 XWayland，
;;;     环境变量照抄 nixpkgs 的 wrapper。
;;;
;;; 没做的部分：nixpkgs 里那个 wemeet-wayland-screenshare（Wayland 投屏 hook，
;;; 要拉 opencv/Qt5/pipewire 一大票依赖）。没有它，Wayland 下共享屏幕用不了，
;;; 需要的话可以再补一个包。
;;;
;;; 构建：
;;;   guix build -L ~/cchanl wemeet

(define-module (ch0r0ng packages wemeet)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (nonguix build-system binary)
  #:use-module (nonguix licenses)
  #:use-module (ch0r0ng build wemeet)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages libidn)
  #:use-module (gnu packages libunwind)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages openldap)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

;;; 三个 LD_PRELOAD 出来的小库的源码（放在 packages/wemeet-shims/）：
;;;   wrap.c              —— AUR wemeet-bin 里 AvianaCruz 写的，修文件传输崩溃
;;;                          （-DWRAP_FORCE_SINK_HARDWARE：强制把 sink 当硬件）
;;;   wemeet-x11-fix.c    —— nixpkgs 里的，修 Wayland 下 XSetInputFocus 崩溃
;;;   wemeet-camera-fix.c —— nixpkgs 里的，修 Wayland 下摄像头预览渲染
(define %wemeet-shims-directory
  (string-append (current-source-directory) "/wemeet-shims"))

(define-public wemeet-shims
  (package
    (name "wemeet-shims")
    (version "3.26.10.401")
    (source (local-file %wemeet-shims-directory #:recursive? #t))
    (build-system gnu-build-system)
    (arguments
     (list #:tests? #f                  ;没有测试
           #:phases
           #~(modify-phases %standard-phases
               (delete 'configure)
               (replace 'build
                 (lambda* (#:key inputs #:allow-other-keys)
                   (define (libdir name)
                     (string-append (assoc-ref inputs name) "/lib"))
                   (define rpath
                     (string-join (map libdir
                                       '("openssl" "pulseaudio" "libx11"
                                         "mesa" "libglvnd"))
                                  ":"))
                   (for-each
                    (lambda (spec)
                      (apply invoke "gcc" "-Wall" "-Wextra" "-fPIC" "-shared"
                             (string-append "-Wl,-rpath," rpath)
                             "-o" (car spec) (cadr spec) (caddr spec)))
                    '(("libwemeetwrap.so" "wrap.c"
                       ("-DWRAP_FORCE_SINK_HARDWARE" "-lssl" "-lcrypto" "-lpulse"))
                      ("libwemeet-x11-fix.so" "wemeet-x11-fix.c" ("-ldl" "-lX11"))
                      ("libwemeet-camera-fix.so" "wemeet-camera-fix.c"
                       ("-ldl" "-lEGL" "-lX11"))))))
               (replace 'install
                 (lambda _
                   (let ((lib (string-append #$output "/lib")))
                     (mkdir-p lib)
                     (for-each (lambda (f) (install-file f lib))
                               '("libwemeetwrap.so"
                                 "libwemeet-x11-fix.so"
                                 "libwemeet-camera-fix.so"))))))))
    (native-inputs (list gcc))
    (inputs (list openssl pulseaudio libx11 mesa libglvnd))
    (home-page "https://wemeet.qq.com")
    (synopsis "LD_PRELOAD shims for the official Tencent Meeting build")
    (description
     "Small shared libraries that patch around a few crashes and rendering
problems of the official Tencent Meeting (wemeet) binary: a coroutine/audio
wrapper, a fix for a Wayland @code{XSetInputFocus} crash, and a fix for the
camera preview under Wayland.")
    (license (nonfree "https://wemeet.qq.com"))))

(define %wemeet-version "3.26.10.401")

;;; Wayland 下共享屏幕用的 hook（nixpkgs 里叫 wemeet-wayland-screenshare）：
;;; 厂商二进制只知道用 X11 抓屏，这个库直接跟 desktop portal + PipeWire 打交道，
;;; 由 wrapper 以 LD_PRELOAD 注入。装出来的路径要正好是 lib/wemeet/libhook.so
;;; （上游 CMakeLists 里写死的 DESTINATION）。
(define-public wemeet-wayland-screenshare
  (package
    (name "wemeet-wayland-screenshare")
    (version "0-unstable-2025-05-31")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/xuwd1/wemeet-wayland-screenshare")
                    (commit "7f338966e162612b09d838512b11af5901414d05")
                    ;; 仓库带一个 stb 子模块
                    (recursive? #t)))
              (sha256
               (base32
                "0nxrx4z7rzq1nzb90srykda6yad0z300pr96w32smx5y8s0drlsj"))))
    (build-system cmake-build-system)
    (arguments (list #:tests? #f))      ;上游没有测试
    (native-inputs (list pkg-config))
    (inputs (list glib
                  libportal
                  libx11
                  libxcomposite
                  libxdamage
                  libxrandr
                  opencv
                  pipewire))
    (home-page "https://github.com/xuwd1/wemeet-wayland-screenshare")
    (synopsis "Wayland screen sharing hook for Tencent Meeting")
    (description
     "This library is @code{LD_PRELOAD}ed into the official Tencent Meeting
build so that screen sharing works on Wayland: instead of using X11 screen
capture it talks to the desktop portal and PipeWire directly.")
    (license license:expat)))

(define-public wemeet
  (package
    (name "wemeet")
    (version %wemeet-version)
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://updatecdn.meeting.qq.com/cos/"
                    "72e0e0023e1d1e6d4123fba28821aea1/"
                    "TencentMeeting_0300000000_3.26.10.401_x86_64_default"
                    ".publish.officialwebsite.deb"))
              (sha256
               (base32
                "1bxcwqpkwxsq054iiizp02dcpijhcszyw4wqps8yzh09j817pwvh"))))
    (build-system binary-build-system)
    (arguments
     (list #:modules '((ch0r0ng build wemeet)
                       (nonguix build binary-build-system)
                       (guix build utils)
                       (nonguix build utils))
           #:imported-modules `((ch0r0ng build wemeet)
                                ,@%binary-build-system-modules)
           #:phases
           #~(modify-phases %standard-phases
               (replace 'install install-wemeet)
               (delete 'patchelf)
               (add-after 'install 'patch-elf patch-elf)
               (add-after 'patch-elf 'wrap-bin
                 (lambda* (#:key inputs outputs #:allow-other-keys)
                   (wrap-wemeet #:inputs inputs
                                #:outputs outputs
                                #:bash #$(file-append bash-minimal "/bin/bash")
                                #:shims #$(file-append wemeet-shims "/lib")
                                #:screenshare #$(file-append wemeet-wayland-screenshare "/lib/wemeet")
                                #:xkb #$(file-append xkeyboard-config
                                                     "/share/X11/xkb")))))))
    (inputs (list wemeet-shims
                  wemeet-wayland-screenshare
                  alsa-lib
                  curl
                  dbus
                  desktop-file-utils
                  `(,gcc "lib")
                  eudev
                  expat
                  fontconfig
                  freetype
                  glib
                  harfbuzz
                  libdrm
                  libgcrypt
                  libglvnd
                  libice
                  libidn2
                  libpsl
                  pulseaudio
                  libsm
                  libunwind
                  libx11
                  libxdamage
                  libxext
                  libxrandr
                  libxtst
                  mesa
                  mit-krb5
                  nghttp2
                  nspr
                  nss
                  openldap
                  openssl
                  rtmpdump
                  wayland
                  xkeyboard-config
                  zlib))
    (home-page "https://wemeet.qq.com")
    (synopsis "Tencent Meeting video conferencing client (official binary)")
    (description
     "Tencent Meeting (wemeet) is Tencent's video conferencing client.  This
package installs the official Linux build distributed as a @file{.deb} package.
All bundled ELF files are patched to use Guix's dynamic loader and library
paths, and small @code{LD_PRELOAD} shims fix a few crashes of the vendor build
under Wayland.  Two launchers are provided: @command{wemeet} (native Wayland)
and @command{wemeet-xwayland} (forces XWayland).")
    (license (nonfree "https://wemeet.qq.com"))
    (supported-systems '("x86_64-linux"))))
