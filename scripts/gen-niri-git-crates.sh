#!/bin/bash
# 生成 niri-git 的 crate 输入表。
#
#   $1 = niri main 的 crate 哈希文件（"name version hash"，由 guix hash -S none 得到）
#   $2 = smithay 额外 crate 的哈希文件（smithay 自己的可选/开发依赖，不在 niri 的
#        Cargo.lock 里，但 cargo package --package smithay 需要它们）
#
# 输出到 stdout，重定向到 <channel>/ch0r0ng/packages/niri-git-crates.scm。
set -eu

emit_list () {
  local hashes="$1" name="$2"
  echo "(define $name"
  echo "  (list"
  awk 'NF>=3 {
    n=$1; v=$2; h=$3; label=n; gsub(/_/,"-",label);
    fn="rust-" label "-" v ".tar.gz";
    printf "   (list \"%s\"\n         (origin\n          (method url-fetch)\n          (uri \"https://crates.io/api/v1/crates/%s/%s/download\")\n          (file-name \"%s\")\n          (sha256 (base32 \"%s\"))))\n", fn, n, v, fn, h
  }' "$hashes"
  echo "))"
  echo
}

cat <<'HDR'
;;; 本文件由 scripts/gen-niri-git-crates.sh 自动生成，请勿手改。
;;;
;;; 两个表：
;;;   %niri-git-crate-inputs       niri main 的 Cargo.lock 里全部 registry crate
;;;   %smithay-git-crate-inputs    smithay 自己的可选/开发依赖（不在 niri 的 lock 里）
;;;
;;; 生成方式：
;;;   1. cargo vendor --locked <niri 源码目录>   ; 把 .crate 下到 $CARGO_HOME/registry/cache
;;;   2. 逐个 guix hash -S none <name>-<version>.crate     ; 注意默认格式是 nix-base32
;;;   3. smithay 的额外依赖：在 smithay 源码目录跑 cargo generate-lockfile 得到完整依赖，
;;;      减去第 1 步已有的部分，再从 crates.io 下载并同样哈希
;;;   4. 本脚本汇总
;;;
;;; 必须遵守的两个约定（照抄上游 gnu/packages/rust-sources.scm）：
;;;   * input 的 label 以 "rust-" 开头（cargo-build-system 的 rust-package? 只看这个前缀）；
;;;   * origin 的 file-name 与 label 相同 —— unpack-rust-crates 用
;;;     (strip-store-file-name path) 当 vendor 子目录名，不设 file-name 的话每个 crate
;;;     的 store 名都是 "download"，只有一个能解出来、其余被当重复输入跳过。
;;;
;;; 为什么这么写：本 Guix（rosenthal fork）的 niri 包不用 rust-* 包，而是把每个 crate
;;; 作为 fixed-output origin 放进 inputs，由 cargo-build-system 摊成 vendor 目录；
;;; configure 会删掉 Cargo.lock，niri 的 use-guix-vendored-dependencies 阶段把
;;; Cargo.toml 的版本要求放宽成 "*"，于是 cargo 用这里提供的版本重新解析。
;;; 注意额外 crate 只给 smithay-git 用：niri-git 的依赖被放宽成 "*"，多给高版本会
;;; 让 cargo 解析到别的版本。

(define-module (ch0r0ng packages niri-git-crates)
  #:use-module (guix base32)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:export (%niri-git-crate-inputs
            %smithay-git-crate-inputs))

HDR

emit_list "$1" "%niri-git-crate-inputs"
emit_list "$2" "%smithay-git-crate-inputs"
