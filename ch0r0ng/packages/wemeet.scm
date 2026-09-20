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
;;;       - 四个 LD_PRELOAD 小库（见下面 wemeet-shims）；
;;;   * bin/wemeet 走原生 Wayland，bin/wemeet-xwayland 强制 XWayland，
;;;     环境变量照抄 nixpkgs 的 wrapper。
;;;
;;; ---------------------------------------------------------------------------
;;; 在 niri + Wayland 下让「共享屏幕」真正出画面，一共需要 5 处改动
;;; （前 4 处在本包，第 5 处在 niri 侧；完整分析见 ../docs/wemeet-screenshare.md）：
;;;
;;;   1. bin/wemeet 里 export WEMEET_XWAYLAND="1"  ← 见 build/wemeet.scm
;;;      screen_share 模块的 IsUseXDGDesktopPortal() 只有一个判断：
;;;          return (getenv("WEMEET_XWAYLAND") ?: "") == "1";
;;;      不等于 "1" 就退回 X11 抓屏，而 Wayland 会话里 X11 根窗口是空的
;;;      → 共享时预览是蓝块、对端整块绿色。
;;;   2. inputs 里 mesa 必须排在 libglvnd 前面：libglvnd 的 libEGL.so.1 只是
;;;      dispatcher，要读 /usr/share/glvnd/egl_vendor.d（Guix 上没有），
;;;      否则 libxcast 的 EGL 初始化失败 → 5021「会议发生异常」。
;;;   3. inputs 里要有 pipewire：模块 dlopen("libpipewire-0.3.so.0")。
;;;   4. wemeet-portal-format-fix.c：模块给 pw_stream_connect 传的 EnumFormat
;;;      过滤器是空的（format=0/size=0x0），协商必然失败（res=-32
;;;      no more input formats）。这个 shim 换成 4 个合法候选，
;;;      前两个不带 modifier（走共享内存缓冲），后两个带 Modifier::Invalid 作兼容。
;;;   5. niri 侧要用 niri-git（见 packages/wm.scm）：
;;;      SHM 采集回退已合并进 niri 主线（PR #1791）但没有 release，26.04 只 offer
;;;      DMA-BUF；而 PipeWire 约定"协商结果没有 VideoModifier ⇒ 只能用共享内存
;;;      缓冲"，强行走线性 dmabuf 又会在 Intel Gen12 上静默出黑帧（issue #4123）。
;;;
;;; 已删除的弯路：nixpkgs 里那个 wemeet-wayland-screenshare hook（以及它的包定义）。
;;; 上游 README 已发 deprecation notice 要求卸载；实测挂在 3.26.10.401 上一按
;;; 「共享屏幕」就闪退，而且它自己建 PipeWire stream 也撞同一个空 EnumFormat 的坑。
;;; 同样已删除的还有 niri-shm-sharing（26.04 + 手工移植补丁），现由 niri-git 取代。
;;; ---------------------------------------------------------------------------
;;;
;;; 构建：
;;;   guix build -L ~/cchanl wemeet

(define-module (ch0r0ng packages wemeet)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
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
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages web)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

;;; LD_PRELOAD 出来的小库的源码（放在 packages/wemeet-shims/）：
;;;   wrap.c                     —— AUR wemeet-bin 里 AvianaCruz 写的，修文件传输
;;;                                 崩溃（-DWRAP_FORCE_SINK_HARDWARE：把 sink 当硬件）
;;;   wemeet-x11-fix.c           —— nixpkgs 里的，修 Wayland 下 XSetInputFocus 崩溃
;;;   wemeet-camera-fix.c        —— nixpkgs 里的，修 Wayland 下摄像头预览渲染
;;;   wemeet-portal-format-fix.c —— 自写：wemeet 在 portal 模式下给 PipeWire 采集流
;;;                                 传的是空 EnumFormat 过滤器（format=0/size=0x0），
;;;                                 协商必然失败（res=-32 no more input formats）→
;;;                                 共享屏幕时对端全黑。本库把它换成最小的合法过滤器
;;;                                 （BGRx/BGRA + Modifier::Invalid）。
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
                   (define (incdir name)
                     (string-append (assoc-ref inputs name) "/include"))
                   (define rpath
                     (string-join (map libdir
                                       '("openssl" "pulseaudio" "libx11"
                                         "mesa" "libglvnd" "pipewire"))
                                  ":"))
                   ;; portal 抓屏的 shim 需要 pipewire/spa 头文件
                   (define pw-include
                     (list (string-append "-I" (incdir "pipewire") "/pipewire-0.3")
                           (string-append "-I" (incdir "pipewire") "/spa-0.2")))
                   (for-each
                    (lambda (spec)
                      (apply invoke "gcc" "-Wall" "-Wextra" "-fPIC" "-shared"
                             (string-append "-Wl,-rpath," rpath)
                             (append pw-include (caddr spec)
                                     (list "-o" (car spec) (cadr spec)))))
                    '(("libwemeetwrap.so" "wrap.c"
                       ("-DWRAP_FORCE_SINK_HARDWARE" "-lssl" "-lcrypto" "-lpulse"))
                      ("libwemeet-x11-fix.so" "wemeet-x11-fix.c" ("-ldl" "-lX11"))
                      ("libwemeet-camera-fix.so" "wemeet-camera-fix.c"
                       ("-ldl" "-lEGL" "-lX11"))
                      ("libwemeet-portal-format-fix.so"
                       "wemeet-portal-format-fix.c" ("-ldl" "-lpipewire-0.3"))))))
               (replace 'install
                 (lambda _
                   (let ((lib (string-append #$output "/lib")))
                     (mkdir-p lib)
                     (for-each (lambda (f) (install-file f lib))
                               '("libwemeetwrap.so"
                                 "libwemeet-x11-fix.so"
                                 "libwemeet-camera-fix.so"
                                 "libwemeet-portal-format-fix.so"))))))))
    (native-inputs (list gcc))
    (inputs (list openssl pulseaudio libx11 mesa libglvnd pipewire))
    (home-page "https://wemeet.qq.com")
    (synopsis "LD_PRELOAD shims for the official Tencent Meeting build")
    (description
     "Small shared libraries that patch around a few crashes and rendering
problems of the official Tencent Meeting (wemeet) binary: a coroutine/audio
wrapper, a fix for a Wayland @code{XSetInputFocus} crash, and a fix for the
camera preview under Wayland.")
    (license (nonfree "https://wemeet.qq.com"))))

(define %wemeet-version "3.26.10.401")

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
                                #:xkb #$(file-append xkeyboard-config
                                                     "/share/X11/xkb")))))))
    (inputs (list wemeet-shims
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
                  libice
                  libidn2
                  libpsl
                  ;; ★ 投屏模块（bin/modules/screen_share/libscreen_share_module.so）
                  ;;   用 dlopen("libpipewire-0.3.so.0") 拿 PipeWire stream，dlopen
                  ;;   不经过 DT_NEEDED，所以 ldd 扫不出来，但缺了它 Wayland 投屏
                  ;;   的 wayland_screencast_helper 会初始化失败并退回 X11 抓屏
                  ;;   （表现为：不弹选择框、画面全绿）。
                  pipewire
                  pulseaudio
                  libsm
                  libunwind
                  libx11
                  libxdamage
                  libxext
                  libxrandr
                  libxtst
                  mesa
                  ;; ★ mesa 必须排在 libglvnd 前面：libglvnd 的 libEGL.so.1 只是派发器，
                  ;;   它按 FHS 路径 /usr/share/glvnd/egl_vendor.d 找厂商实现，Guix 上找不到，
                  ;;   会导致 wemeet 的 AV 引擎 eglGetDisplay 报 EGL_BAD_PARAMETER(300c)。
                  ;;   libGL.so.1 仍然来自 libglvnd，所以 libglvnd 不能删。
                  libglvnd
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
