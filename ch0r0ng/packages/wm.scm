(define-module (ch0r0ng packages wm)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages rust-sources)
  #:use-module (gnu packages window-management)
  #:use-module (ch0r0ng packages niri-git-crates))

;;; niri-git —— 直接跟 niri main（不再需要我们自己打 SHM 补丁）。
;;;
;;; SHM 采集回退（上游 PR #1791）已经合并进 niri 主线，但还没有任何 release
;;; （最新 release 仍是 26.04），所以 Guix 里的 niri 还没有这个功能。niri-git
;;; 直接跟 commit，功能上不落后于「26.04 + rucnyz 的移植补丁」，而且省掉了补丁。
;;;
;;; 依赖走本 Guix（rosenthal fork）既有的做法：niri 的 inputs 里放 486 个
;;; crates.io fixed-output origin（见 niri-git-crates.scm），cargo-build-system 的
;;; prepare-rust-crates 会把它们摊成 vendor 目录；configure 还会删掉 Cargo.lock，
;;; niri 自带的 use-guix-vendored-dependencies 阶段会把 Cargo.toml 的版本要求放宽成
;;; "*"（并去掉 git 依赖），于是 cargo 按这里提供的版本重新解析依赖。
;;; smithay 这个 git 依赖单独用一个包：继承 rust-smithay，只换 source 到 main 的
;;; Cargo.lock 指定的 rev，并给它同一套 crate。
(define %niri-git-commit "7256ccf6274a1f953c6987ade34ea1c0e4944c27")
(define %smithay-git-commit "22571baa20d34d71092942dbb520c4e3fbbd6263")

(define smithay-git
  (package
    (inherit rust-smithay-0.7.0.ff5fa7d)
    (version "0.7.0-0.22571ba")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/Smithay/smithay.git")
                    (commit %smithay-git-commit)))
              (sha256
               (base32 "04fzzjm1agb2phxsybgb02rsybz4fyifhx1l641y14h1vi4hadpp"))
              (file-name (git-file-name "smithay" "0.7.0-0.22571ba"))))
    ;; crate 输入用 smithay **自己** Cargo.lock 的完整版本集（452 个）。
    ;; 不能和 niri 的那一套混用：两套 lock 的版本不同，cargo 重新解析时会挑更高
    ;; 的版本，然后找不到它要的依赖（例如 image 0.25.9 需要 zune-jpeg ^0.5.5，
    ;; 而 niri 那边根本没有 image/zune-jpeg）。保留 rust-smithay 原有的非 crate 输入。
    (inputs (append %smithay-git-crate-inputs
                    (filter (lambda (i) (not (string-prefix? "rust-" (car i))))
                            (package-inputs rust-smithay-0.7.0.ff5fa7d))))))

(define-public niri-git
  (package
    (inherit niri)
    (name "niri-git")
    (version "26.04-0.7256ccf")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/niri-wm/niri")
                    (commit %niri-git-commit)))
              (sha256
               (base32 "1x5rjlhz2lb114ps5hz10a0b7hgjrr1hfykallsmhiphb7n63apx"))
              (file-name (git-file-name name version))))
    (inputs (append (list (list "rust-smithay" smithay-git))
                    %niri-git-crate-inputs
                    (filter (lambda (i) (not (string-prefix? "rust-" (car i))))
                            (package-inputs niri))))
    (synopsis "niri from git main (pre-release, SHM screencast fallback)")))
