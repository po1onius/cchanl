;;; SPDX-License-Identifier: GPL-3.0-or-later
(define-module (ch0r0ng packages rustup)
  #:use-module (ch0r0ng rustup))

;; The manifest is pinned in the channel: package discovery never uses network.
(define-public rust-toolchain
  (rustup-from-manifest
   (search-path %load-path "ch0r0ng/rustup/stable.toml")))
