;;; qq —— 腾讯 QQ（Linux 版官方 .deb 二进制）
;;;
;;; 参考 nixpkgs 的 pkgs/by-name/qq/qq 和 nonguix 的 google-chrome 的写法：
;;;   * source 直接用官方 .deb（fixed-output origin）；
;;;   * 用 nonguix 的 binary-build-system（ch0r0ng 本来就依赖 nonguix）：
;;;     它的 binary-unpack 阶段会 ar x + tar x 把 .deb 解开，
;;;     之后的工作目录就是 .deb 的根（opt/... usr/...）；
;;;   * 构建阶段（install-qq / patch-elf / wrap-qq）写在
;;;     ch0r0ng/build/qq.scm 里，作为构建端模块导入 —— 这些过程比较长，
;;;     放普通模块里可以直接编译检查，比塞在 gexp 里好调；
;;;   * 自己全量 patchelf：把每个 ELF 的 interpreter 改成 Guix glibc 的
;;;     ld-linux，RPATH 写成 "$ORIGIN:<所有 input 的 lib 目录>"。
;;;     ★ $ORIGIN 必须保留：QQ 自带的 libffmpeg.so / liblinux_compat.so /
;;;       libEGL.so / resources/app/avsdk/*.so 都是靠 RPATH=$ORIGIN（或相对
;;;       自己目录）加载的，覆盖掉就会起不来；
;;;   * bin/qq 用 wrap-program 包一层：LD_LIBRARY_PATH、GSettings schema、
;;;     Wayland 下的输入法参数，并写 ~/.config/QQ/versions/config.json
;;;     关掉自动更新（QQ 的更新器没法往只读的 /gnu/store 里写）。
;;;
;;; 与 nixpkgs 版本的差别：
;;;   * nix 用 autoPatchelfHook + wrapGAppsHook3，这里等价地用自写阶段；
;;;   * nix 把 libssh2 放进 LD_PRELOAD，这里直接删掉上游自带的
;;;     resources/app/libssh2.so.1，让系统那份通过 RPATH/LD_LIBRARY_PATH
;;;     被找到（更省事，效果一样）；
;;;   * nix 在运行时用 sed 读 package.json 拿 INTERNAL_VERSION，这里在打包时
;;;     就把版本号写死成 %qq-internal-version。
;;;
;;; 构建：
;;;   guix build -L ~/cchanl qq
;;; 如果 Wayland（niri）下沙箱报错，可以试 `qq --no-sandbox`。

(define-module (ch0r0ng packages qq)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (nonguix build-system binary)
  #:use-module (nonguix licenses)
  #:use-module (ch0r0ng build qq)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

(define %qq-version "3.2.32")

;;; 上游 .deb 里 opt/QQ/resources/app/package.json 的 version 字段。
;;; QQ 会拿它和 ~/.config/QQ/versions/config.json 比对，不一致就尝试自动更新；
;;; 写上同样的版本号可以让它安静下来。
(define %qq-internal-version "3.2.32-52194")

(define %qq-inputs
  ;; 依赖表参考 nonguix 的 chromium-binary-build-system 自带的 Electron 依赖，
  ;; 再加上实际 readelf 扫出来的这几个：
  ;;   gnutls/nettle/gmp ← 自带的 avsdk/librtmp.so
  ;;   libssh2          ← 顶掉上游自带的 libssh2.so.1
  ;;   libappindicator/libnotify ← 托盘图标（运行时 dlopen）
  ;;   gsettings-desktop-schemas ← GTK 设置
  (list alsa-lib
        at-spi2-core
        bash-minimal
        cairo
        cups
        dbus
        eudev
        expat
        fontconfig
        freetype
        `(,gcc "lib")
        glib
        gmp
        gnutls
        gsettings-desktop-schemas
        gtk+
        libappindicator
        libdrm
        libnotify
        librsvg
        libsecret
        libglvnd
        libssh2
        libx11
        libxcb
        libxcomposite
        libxcursor
        libxdamage
        libxext
        libxfixes
        libxft
        libxi
        libxkbfile
        libxkbcommon
        libxrandr
        libxrender
        libxshmfence
        libxtst
        mesa
        mit-krb5
        nettle
        nspr
        nss
        pango
        pulseaudio
        sqlcipher
        util-linux
        xcb-util
        xcb-util-image
        xcb-util-keysyms
        xcb-util-renderutil
        xcb-util-wm
        xdg-utils
        zlib))

(define-public qq
  (package
    (name "qq")
    (version %qq-version)
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://qqdl.gtimg.cn/qqfile/QQNT/9.9.33/release/3f89efc5/"
                    "QQ_3.2.32_260812_amd64_01.deb"))
              (sha256
               (base32
                "1s5hsw9nx8d0ljbpwxs5sj782ac1d27k157ip4g0c9bj764xv1fh"))))
    (build-system binary-build-system)
    (arguments
     (list #:modules '((ch0r0ng build qq)
                       (nonguix build binary-build-system)
                       (guix build utils)
                       (nonguix build utils))
           #:imported-modules `((ch0r0ng build qq)
                                ,@%binary-build-system-modules)
           #:phases
           #~(modify-phases %standard-phases
               (replace 'install install-qq)
               (delete 'patchelf)
               (add-after 'install 'patch-elf patch-elf)
               (add-after 'patch-elf 'wrap-bin
                 (lambda* (#:key inputs outputs #:allow-other-keys)
                   (wrap-qq #:inputs inputs
                            #:outputs outputs
                            #:bash #$(file-append bash-minimal "/bin/bash")
                            #:gsettings #$(file-append gsettings-desktop-schemas
                                                       "/share")
                            #:gtk #$(file-append gtk+ "/share")
                            #:glib #$(file-append glib "/share")
                            #:internal-version #$%qq-internal-version))))))
    (inputs %qq-inputs)
    (home-page "https://im.qq.com/")
    (synopsis "Tencent QQ instant messaging client (official binary)")
    (description
     "QQ is Tencent's instant messaging client.  This package installs the
official Linux build, which is an Electron application distributed as a
@file{.deb} package.  All bundled ELF files are patched to use Guix's dynamic
loader and library paths; a wrapper script sets up the environment (GSettings
schemas, Wayland text input) and disables the built-in updater, which cannot
work with the read-only store.")
    (license (nonfree "https://im.qq.com/"))
    (supported-systems '("x86_64-linux"))))
