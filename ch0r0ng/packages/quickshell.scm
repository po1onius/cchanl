;;; Quickshell 的上游 git 快照（master 分支），比 Guix 官方的 release 新。
;;;
;;; 为什么需要它：官方 Guix 打包的是 quickshell 0.3.0（gnu/packages/
;;; window-management.scm），而基于 Quickshell 的桌面壳（例如 Omarchy 的
;;; shell：bar/菜单/通知/锁屏都跑在同一个 Quickshell 进程里）跟的是上游
;;; master —— Omarchy 自建仓库里的 quickshell-git 就是
;;; 0.3.0.r20.g28771c7，比 release 新。这里按同样的思路给最新 master。
;;;
;;; 实现方式：直接继承官方的 quickshell 包，只覆盖 name/version/source。
;;; Qt6 的构建参数（qt-build-system、#:qtbase、#:generator "Ninja"）、
;;; configure flags（含 -DINSTALL_QML_PREFIX=lib/qt6/qml，让其它 Qt/QML
;;; 工具能发现 Quickshell 的 QML 模块）以及全部 inputs 都复用它。
;;;
;;; 升级方法：把 %quickshell-git-commit 换成新 HEAD，%quickshell-git-revision
;;; 换成 `git -C <clone> rev-list --count v<上一个 tag>..HEAD`，然后重新构建
;;; 一次拿到新的 sha256（构建报错里会直接给出 expected hash）。
(define-module (ch0r0ng packages quickshell)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (gnu packages window-management)   ;quickshell
  #:export (quickshell-git))

;; v0.3.1-15-gfae96f1（master HEAD，提交日期 2026-09-20）
(define %quickshell-git-commit
  "fae96f1a5b7f53de9b7e40e5b53c0b7a2e97b1d7")

;; v0.3.1 之后的提交数，只用于版本号显示
(define %quickshell-git-revision "15")

(define-public quickshell-git
  (package
    (inherit quickshell)
    (name "quickshell-git")
    (version (git-version "0.3.1" %quickshell-git-revision
                          %quickshell-git-commit))
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.outfoxxed.me/quickshell/quickshell")
                    (commit %quickshell-git-commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0ac27fpxm1fm1mbr39wg2h88wwlnhdnbzfvsydyk8xnq60qavggk"))))))
