;;; feishu —— 飞书（Feishu / Lark）Linux 官方客户端（二进制 .deb）
;;;
;;; 参考 nixpkgs 的 pkgs/by-name/fe/feishu/package.nix：
;;;   * source 直接用官方 .deb（fixed-output origin）；
;;;   * 用 nonguix 的 binary-build-system（ch0r0ng 本来就依赖 nonguix）：
;;;     它的 binary-unpack 阶段用 ar x + tar x 解开 .deb，正好绕开
;;;     「deb 里的 chrome-sandbox 带 setuid 位、dpkg -x 会失败」那个坑；
;;;   * 构建阶段（install-feishu / patch-elf / wrap-feishu）写在
;;;     ch0r0ng/build/feishu.scm 里作为构建端模块导入；
;;;   * nixpkgs 用 autoPatchelfHook，这里等价地自己全量 patchelf：
;;;     interpreter 改成 Guix glibc 的 ld-linux，RPATH 写
;;;     "$ORIGIN:<包内所有含 .so 的目录>:<所有 input 的 lib 目录>"。
;;;     ★ $ORIGIN 必须保留：飞书自带的 libEGL.so / libGLESv2.so /
;;;       libffmpeg.so / libatomic.so.1 都是靠它加载的。
;;;
;;; 依赖表不是照抄 nixpkgs，而是拿 readelf -d 扫了全部 46 个 ELF 的 NEEDED，
;;; 再补上 nixpkgs 列出的、运行期 dlopen 的那几个（libappindicator、
;;; libdbusmenu、libnotify、libxscrnsaver、wayland、pipewire …）。
;;; 扫出来的结论里值得一提的：
;;;   * libatk-1.0 与 libatk-bridge-2.0 现在都由 at-spi2-core 提供
;;;     （Guix 里已经没有独立的 atk / at-spi2-atk 包）；
;;;   * libgbm 在 Guix 里由 mesa 提供（没有单独的 libgbm 包）；
;;;   * libgcc_s / libstdc++ / libgomp 来自 (gcc "lib")；
;;;   * 没有 libsystemd/libelogind 的依赖，所以不需要 elogind。
;;;
;;; version 7.66.11 的 deb 我实际下载校验过，sha256 与 nixpkgs 记录的完全一致：
;;;   base16 dc4f0d2c2db3cc83bb9758cf71e3e131f09a7e08eec963b378d660c534ccfd31
;;;   base64 3E8NLC2zzIO7l1jPcePhMfCafgjuyWOzeNZgxTTM/TE=   （= nixpkgs）
;;;
;;; 与 nixpkgs 版本的差别：
;;;   * nixpkgs 的 FIXME 说上游在原生 Wayland 上会崩，所以它把 NIXOS_OZONE_WL
;;;     拿掉了；这里同样不设任何 ozone 变量，默认走 X11（niri 下由
;;;     xwayland-satellite 提供 XWayland）。
;;;   * nixpkgs 还 wrap 了 vulcan/vulcan；这一版 deb 的 vulcan/ 里已经没有
;;;     那个可执行文件了，只 wrap 上游启动器 bytedance-feishu。
;;;   * 不传 --no-sandbox：系统的 user.max_user_namespaces 足够大，
;;;     Chromium 的 namespace 沙箱可以直接用。
;;;
;;; 构建：
;;;   guix build -L ~/cchanl feishu

(define-module (ch0r0ng packages feishu)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (nonguix build-system binary)
  #:use-module (nonguix licenses)
  #:use-module (ch0r0ng build feishu)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

(define %feishu-version "7.66.11")

(define %feishu-inputs
  ;; 前一段是 readelf 扫出来的 NEEDED，后一段是运行期 dlopen 的
  ;; （托盘、屏幕共享、GPU 探测），漏了不会立刻报错但会在运行到某个功能时挂。
  (list alsa-lib                    ;libasound
        at-spi2-core                ;libatspi / libatk / libatk-bridge
        bash-minimal                ;wrapper
        cairo
        cups
        dbus
        eudev                       ;libudev
        expat
        fontconfig
        freetype
        `(,gcc "lib")               ;libgcc_s / libstdc++ / libgomp
        gdk-pixbuf
        glib                        ;libgio / libglib / libgobject
        gnutls
        gtk+                        ;libgdk-3
        libgcrypt                   ;libframe/libmonitor/vulcan 需要
        libappindicator             ;托盘（dlopen）
        libdbusmenu                 ;托盘菜单（dlopen）
        libdrm
        libglvnd                    ;libEGL / libGL
        libnotify                   ;通知（dlopen）
        libx11
        libxcb
        libxcomposite
        libxcursor
        libxdamage
        libxext
        libxfixes
        libxi
        libxkbfile
        libxkbcommon
        libxrandr
        libxrender
        libxscrnsaver               ;防息屏（dlopen）
        libxshmfence
        libxtst
        mesa                        ;libgbm
        nspr
        nss
        pango
        pixman
        pipewire                    ;屏幕共享（dlopen）
        pulseaudio                  ;libpulse
        util-linux                  ;libuuid
        wayland
        xdg-utils                   ;打开链接 / xdg-settings
        zlib))

(define-public feishu
  (package
    (name "feishu")
    (version %feishu-version)
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://sf3-cn.feishucdn.com/obj/ee-appcenter/6e3610b5/"
                    "Feishu-linux_x64-" %feishu-version ".deb"))
              (sha256
               (base32
                "0cgxrhscaq6ng2rn7jgf11z9mw1iw7ip3ksqjyxq7k5k5ln0skyw"))))
    (build-system binary-build-system)
    (arguments
     (list #:modules '((ch0r0ng build feishu)
                       (nonguix build binary-build-system)
                       (guix build utils)
                       (nonguix build utils))
           #:imported-modules `((ch0r0ng build feishu)
                                ,@%binary-build-system-modules)
           #:phases
           #~(modify-phases %standard-phases
               (replace 'install install-feishu)
               (delete 'patchelf)
               (add-after 'install 'patch-elf patch-elf)
               (add-after 'patch-elf 'wrap-bin
                 (lambda* (#:key inputs outputs #:allow-other-keys)
                   (wrap-feishu #:inputs inputs
                                #:outputs outputs
                                #:bash #$(file-append bash-minimal "/bin/bash")
                                #:gsettings #$(file-append gsettings-desktop-schemas
                                                           "/share")
                                #:gtk #$(file-append gtk+ "/share")
                                #:glib #$(file-append glib "/share")
                                #:xdg-utils #$(file-append xdg-utils "/bin")))))))
    (inputs %feishu-inputs)
    (home-page "https://www.feishu.cn/")
    (synopsis "Feishu / Lark collaboration client (official binary)")
    (description
     "Feishu (Lark) is ByteDance's all-in-one collaboration platform:
instant messaging, calendar, video meetings, and collaborative documents.
This package installs the official Linux build, which ships as a @file{.deb}
package containing a Chromium-based application.  All bundled ELF files are
patched to use Guix's dynamic loader and library paths; a wrapper script sets
up the environment (GSettings schemas, XDG data directories, xdg-utils) and
launches the upstream launcher.  The application runs as an X11 client; under
Wayland compositors such as @code{niri} this goes through XWayland.")
    (license (nonfree "https://www.feishu.cn/"))
    (supported-systems '("x86_64-linux"))))

;;; feishu.scm ends here
