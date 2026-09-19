;;; sddm-astronaut-theme —— SDDM 的 Qt6 主题（Keyitdev/sddm-astronaut-theme）
;;;
;;; 2026-09-19 在本机用 `guix build -f` 验证过可构建：
;;;   /gnu/store/7s1nidc09w5wqyakgjyl5a5rkyvnbq3m-sddm-astronaut-theme-1.4
;;;
;;; 在 operating-system 里用法（注意三件事都要做，否则 greeter 起不来）：
;;;   1) (use-modules ... (ch0r0ng packages sddm-astronaut-theme) (gnu packages qt))
;;;   2) (packages (cons* ... sddm-astronaut-theme
;;;                        qtmultimedia        ;必需：Main.qml 顶部无条件 import QtMultimedia
;;;                        qtvirtualkeyboard   ;可选：只要屏幕虚拟键盘才需要
;;;                        %base-packages))
;;;   3) (service sddm-service-type
;;;               (sddm-configuration
;;;                (sddm sddm)                      ;★ 必须 Qt6 版（主题 QtVersion=6）
;;;                (theme "sddm-astronaut-theme")))
;;; 换回 Qt5 版 sddm 时本主题不可用（Qt5 的 greeter 加载不了 Qt6 QML）。
;;;
;;; 换 commit 时重新算哈希，必须用 nar 序列化（-S git 会被 git-fetch 拒绝）：
;;;   git clone --depth 1 https://github.com/Keyitdev/sddm-astronaut-theme /tmp/ast
;;;   guix hash -x -S nar /tmp/ast
;;;
;;; 十套预设见主题目录里的 Themes/*.conf（astronaut、black_hole、cyberpunk、
;;; hyprland_kath、jake_the_dog、japanese_aesthetic、pixel_sakura(_static)、
;;; post-apocalyptic_hacker、purple_leaves）。想换默认预设，取消下面
;;; 'choose-preset' 阶段的注释并改文件名。

(define-module (ch0r0ng packages sddm-astronaut-theme)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix gexp))

(define-public sddm-astronaut-theme
  (package
   (name "sddm-astronaut-theme")
   (version "1.4")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/Keyitdev/sddm-astronaut-theme")
                  ;; master，2026-09-19 抓取
                  (commit "abb3163c724935af888ba5ea9ac0c4f22afd8048")))
            (sha256
             (base32
              "1lf8m9m01sg95i06ni4splaqk7l6ggndrrw7cj7pwc15hj7d5s06"))))
   (build-system copy-build-system)
   (arguments
    (list #:install-plan #~'(("." "share/sddm/themes/sddm-astronaut-theme"))
          ;; 默认预设：改这里换风格（可选值见主题的 Themes/*.conf）
          #:phases #~(modify-phases %standard-phases
                       (add-after 'unpack 'choose-preset
                         (lambda _
                           (substitute* "metadata.desktop"
                             (("ConfigFile=Themes/astronaut.conf")
                              "ConfigFile=Themes/japanese_aesthetic.conf")))))))
   (home-page "https://github.com/Keyitdev/sddm-astronaut-theme")
   (synopsis "Astronaut theme series for SDDM")
   (description
    "Astronaut is a series of ten Qt6 QML themes for SDDM with a modern look,
animated wallpapers and virtual keyboard support.  Written by Keyitdev, based
on Sugar Dark by MarianArlt.  It requires an SDDM built against Qt6 plus the
@code{qtmultimedia} QML module in the system profile (@code{Main.qml} imports
@code{QtMultimedia} unconditionally); @code{qtvirtualkeyboard} is optional and
only enables the on-screen keyboard.")
   (license license:gpl3+)))
