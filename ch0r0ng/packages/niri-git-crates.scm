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

(define %niri-git-crate-inputs
  (list
   (list "rust-accesskit-0.25.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/accesskit/0.25.0/download")
          (file-name "rust-accesskit-0.25.0.tar.gz")
          (sha256 (base32 "0f6v4gc4jsgw4dibsj7lfp9dmicvxx7ilnanvdlcd5avls0p12j3"))))
   (list "rust-adler2-2.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/adler2/2.0.1/download")
          (file-name "rust-adler2-2.0.1.tar.gz")
          (sha256 (base32 "1ymy18s9hs7ya1pjc9864l30wk8p2qfqdi7mhhcc5nfakxbij09j"))))
   (list "rust-accesskit-consumer-0.39.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/accesskit_consumer/0.39.0/download")
          (file-name "rust-accesskit-consumer-0.39.0.tar.gz")
          (sha256 (base32 "09ybn1h22s7gyi7ybxx8m7n3dks622si2qr5krj56k62r6h2z26c"))))
   (list "rust-ahash-0.8.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ahash/0.8.12/download")
          (file-name "rust-ahash-0.8.12.tar.gz")
          (sha256 (base32 "0xbsp9rlm5ki017c0w6ay8kjwinwm8knjncci95mii30rmwz25as"))))
   (list "rust-accesskit-atspi-common-0.20.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/accesskit_atspi_common/0.20.0/download")
          (file-name "rust-accesskit-atspi-common-0.20.0.tar.gz")
          (sha256 (base32 "0mrjp6nllbdpgc2q2a3pm60q5ivwpl6wm99jwjvnqvwi8kb7mm69"))))
   (list "rust-aho-corasick-1.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/aho-corasick/1.1.5/download")
          (file-name "rust-aho-corasick-1.1.5.tar.gz")
          (sha256 (base32 "1fhjkp2nbs7gg4y1b68hpc8028rpax8aiscfh9b60q78m4pn90n9"))))
   (list "rust-aliasable-0.1.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/aliasable/0.1.3/download")
          (file-name "rust-aliasable-0.1.3.tar.gz")
          (sha256 (base32 "1z8548zdjlm4ps1k0d7x68lfdyji02crwcc9rw3q3bb106f643r5"))))
   (list "rust-accesskit-unix-0.23.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/accesskit_unix/0.23.0/download")
          (file-name "rust-accesskit-unix-0.23.0.tar.gz")
          (sha256 (base32 "1zlnm6nvlap3sx9fvy2sl0clp96xfahkfd3rlrl82nijnxwr0p36"))))
   (list "rust-android-properties-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/android-properties/0.2.2/download")
          (file-name "rust-android-properties-0.2.2.tar.gz")
          (sha256 (base32 "016slvg269c0y120p9qd8vdfqa2jbw4j0g18gfw6p3ain44v4zpw"))))
   (list "rust-annotate-snippets-0.11.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/annotate-snippets/0.11.5/download")
          (file-name "rust-annotate-snippets-0.11.5.tar.gz")
          (sha256 (base32 "1i1bmr5vy957l8fvivj9x1xs24np0k56rdgwj0bxqk45b2p8w3ki"))))
   (list "rust-allocator-api2-0.2.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/allocator-api2/0.2.21/download")
          (file-name "rust-allocator-api2-0.2.21.tar.gz")
          (sha256 (base32 "08zrzs022xwndihvzdn78yqarv2b9696y67i6h78nla3ww87jgb8"))))
   (list "rust-android-activity-0.6.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/android-activity/0.6.1/download")
          (file-name "rust-android-activity-0.6.1.tar.gz")
          (sha256 (base32 "1k8v4mw8kijvmjmqwr05cjvk2arklx2968bjjpa5szc5aaq1nahg"))))
   (list "rust-anstream-1.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstream/1.0.0/download")
          (file-name "rust-anstream-1.0.0.tar.gz")
          (sha256 (base32 "13d2bj0xfg012s4rmq44zc8zgy1q8k9yp7yhvfnarscnmwpj2jl2"))))
   (list "rust-anstyle-1.0.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle/1.0.14/download")
          (file-name "rust-anstyle-1.0.14.tar.gz")
          (sha256 (base32 "0030szmgj51fxkic1hpakxxgappxzwm6m154a3gfml83lq63l2wl"))))
   (list "rust-anstyle-query-1.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle-query/1.1.5/download")
          (file-name "rust-anstyle-query-1.1.5.tar.gz")
          (sha256 (base32 "1p6shfpnbghs6jsa0vnqd8bb8gd7pjd0jr7w0j8jikakzmr8zi20"))))
   (list "rust-anyhow-1.0.104.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anyhow/1.0.104/download")
          (file-name "rust-anyhow-1.0.104.tar.gz")
          (sha256 (base32 "0w34jjcm02p5g9kvsjr1dvpw0zs2fi7igi6nr414fkm5gz85w2ik"))))
   (list "rust-anstyle-wincon-3.0.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle-wincon/3.0.11/download")
          (file-name "rust-anstyle-wincon-3.0.11.tar.gz")
          (sha256 (base32 "0zblannm70sk3xny337mz7c6d8q8i24vhbqi42ld8v7q1wjnl7i9"))))
   (list "rust-anstyle-parse-1.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle-parse/1.0.0/download")
          (file-name "rust-anstyle-parse-1.0.0.tar.gz")
          (sha256 (base32 "03hkv2690s0crssbnmfkr76kw1k7ah2i6s5amdy9yca2n8w7zkjj"))))
   (list "rust-appendlist-1.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/appendlist/1.4.0/download")
          (file-name "rust-appendlist-1.4.0.tar.gz")
          (sha256 (base32 "1lnbl7mc7capcqj1z1ylxvm4h492sb9sr8pzww3q6lrhrmrxqjg1"))))
   (list "rust-approx-0.5.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/approx/0.5.1/download")
          (file-name "rust-approx-0.5.1.tar.gz")
          (sha256 (base32 "1ilpv3dgd58rasslss0labarq7jawxmivk17wsh8wmkdm3q15cfa"))))
   (list "rust-arrayvec-0.7.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/arrayvec/0.7.8/download")
          (file-name "rust-arrayvec-0.7.8.tar.gz")
          (sha256 (base32 "0mmd8lrijbvg1qp4c5zis5dq41a3mjv2rb6bxkyj9kwaw2k6gyyk"))))
   (list "rust-as-raw-xcb-connection-1.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/as-raw-xcb-connection/1.0.1/download")
          (file-name "rust-as-raw-xcb-connection-1.0.1.tar.gz")
          (sha256 (base32 "0sqgpz2ymv5yx76r5j2npjq2x5qvvqnw0vrs35cyv30p3pfp2m8p"))))
   (list "rust-async-channel-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-channel/2.5.0/download")
          (file-name "rust-async-channel-2.5.0.tar.gz")
          (sha256 (base32 "1ljq24ig8lgs2555myrrjighycpx2mbjgrm3q7lpa6rdsmnxjklj"))))
   (list "rust-async-broadcast-0.7.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-broadcast/0.7.2/download")
          (file-name "rust-async-broadcast-0.7.2.tar.gz")
          (sha256 (base32 "0ckmqcwyqwbl2cijk1y4r0vy60i89gqc86ijrxzz5f2m4yjqfnj3"))))
   (list "rust-async-executor-1.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-executor/1.14.0/download")
          (file-name "rust-async-executor-1.14.0.tar.gz")
          (sha256 (base32 "0al1rmxjy7p7r6h50z698q5lwssqs5a2vzmqbazm1z2sv1rgjsy9"))))
   (list "rust-async-io-2.6.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-io/2.6.0/download")
          (file-name "rust-async-io-2.6.0.tar.gz")
          (sha256 (base32 "1z16s18bm4jxlmp6rif38mvn55442yd3wjvdfhvx4hkgxf7qlss5"))))
   (list "rust-async-lock-3.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-lock/3.4.2/download")
          (file-name "rust-async-lock-3.4.2.tar.gz")
          (sha256 (base32 "04c3xrrdrfrvh9v0ajxrangpy38qi76qq268zslphnxxjqjpy3r9"))))
   (list "rust-async-process-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-process/2.5.0/download")
          (file-name "rust-async-process-2.5.0.tar.gz")
          (sha256 (base32 "0xfswxmng6835hjlfhv7k0jrfp7czqxpfj6y2s5dsp05q0g94l7w"))))
   (list "rust-async-recursion-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-recursion/1.1.1/download")
          (file-name "rust-async-recursion-1.1.1.tar.gz")
          (sha256 (base32 "04ac4zh8qz2xjc79lmfi4jlqj5f92xjvfaqvbzwkizyqd4pl4hrv"))))
   (list "rust-async-signal-0.2.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-signal/0.2.14/download")
          (file-name "rust-async-signal-0.2.14.tar.gz")
          (sha256 (base32 "11dlpb15la279r5cazppy18gbk2xzzl60ahzl19m1kr0l2psmdaj"))))
   (list "rust-async-task-4.7.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-task/4.7.1/download")
          (file-name "rust-async-task-4.7.1.tar.gz")
          (sha256 (base32 "1pp3avr4ri2nbh7s6y9ws0397nkx1zymmcr14sq761ljarh3axcb"))))
   (list "rust-async-trait-0.1.92.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/async-trait/0.1.92/download")
          (file-name "rust-async-trait-0.1.92.tar.gz")
          (sha256 (base32 "0rqn5iga1hlv2lm8xzav1zhar46jb4dvx89i6kfv93kb53maxxl2"))))
   (list "rust-atomic-0.6.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/atomic/0.6.1/download")
          (file-name "rust-atomic-0.6.1.tar.gz")
          (sha256 (base32 "0h43ljcgbl6vk62hs6yk7zg7qn3myzvpw8k7isb9nzhkbdvvz758"))))
   (list "rust-atomic-waker-1.1.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/atomic-waker/1.1.2/download")
          (file-name "rust-atomic-waker-1.1.2.tar.gz")
          (sha256 (base32 "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))))
   (list "rust-atspi-0.29.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/atspi/0.29.0/download")
          (file-name "rust-atspi-0.29.0.tar.gz")
          (sha256 (base32 "0ggvxv82n18kg497kfwrlzyfxw66c14fdrsakbc9q772gcjqcy67"))))
   (list "rust-atspi-proxies-0.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/atspi-proxies/0.13.0/download")
          (file-name "rust-atspi-proxies-0.13.0.tar.gz")
          (sha256 (base32 "1z690hglzw3rzv6xckxxgfvc086a69mbdslni44b8gpdhy3y8c12"))))
   (list "rust-atspi-common-0.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/atspi-common/0.13.0/download")
          (file-name "rust-atspi-common-0.13.0.tar.gz")
          (sha256 (base32 "0ggn55dgk2wz18spjx00gfkyfg747z8rlhhn6009h33lamqn3i90"))))
   (list "rust-autocfg-1.5.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/autocfg/1.5.1/download")
          (file-name "rust-autocfg-1.5.1.tar.gz")
          (sha256 (base32 "0lqasy5i30flcgih1b50kvsk6z32g09r1q4ql7q81pj6228jy0zj"))))
   (list "rust-base64-0.21.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/base64/0.21.7/download")
          (file-name "rust-base64-0.21.7.tar.gz")
          (sha256 (base32 "0rw52yvsk75kar9wgqfwgb414kvil1gn7mqkrhn9zf1537mpsacx"))))
   (list "rust-bindgen-0.72.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bindgen/0.72.1/download")
          (file-name "rust-bindgen-0.72.1.tar.gz")
          (sha256 (base32 "15bq73y3wd3x3vxh3z3g72hy08zs8rxg1f0i1xsrrd6g16spcdwr"))))
   (list "rust-bitflags-2.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bitflags/2.13.2/download")
          (file-name "rust-bitflags-2.13.2.tar.gz")
          (sha256 (base32 "01hbgjwvid66850fzi76mvn5f2bqycx6sf165ng1kfjqq9bl1v9x"))))
   (list "rust-bit-set-0.8.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bit-set/0.8.0/download")
          (file-name "rust-bit-set-0.8.0.tar.gz")
          (sha256 (base32 "18riaa10s6n59n39vix0cr7l2dgwdhcpbcm97x1xbyfp1q47x008"))))
   (list "rust-block-buffer-0.10.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/block-buffer/0.10.4/download")
          (file-name "rust-block-buffer-0.10.4.tar.gz")
          (sha256 (base32 "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))))
   (list "rust-block2-0.6.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/block2/0.6.2/download")
          (file-name "rust-block2-0.6.2.tar.gz")
          (sha256 (base32 "1xcfllzx6c3jc554nmb5qy6xmlkl6l6j5ib4wd11800n0n3rvsyd"))))
   (list "rust-bit-vec-0.8.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bit-vec/0.8.0/download")
          (file-name "rust-bit-vec-0.8.0.tar.gz")
          (sha256 (base32 "1xxa1s2cj291r7k1whbxq840jxvmdsq9xgh7bvrxl46m80fllxjy"))))
   (list "rust-blocking-1.7.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/blocking/1.7.0/download")
          (file-name "rust-blocking-1.7.0.tar.gz")
          (sha256 (base32 "1ykd0gj18r4v4b8r692hds5dsg2w6y9fq4nlxs2l7fbcvwll63m7"))))
   (list "rust-borsh-1.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/borsh/1.8.1/download")
          (file-name "rust-borsh-1.8.1.tar.gz")
          (sha256 (base32 "02p2lhz49944wc6j5dzr42y1mkrv0znbicg3cl61b9bbda25sg2m"))))
   (list "rust-bumpalo-3.20.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bumpalo/3.20.3/download")
          (file-name "rust-bumpalo-3.20.3.tar.gz")
          (sha256 (base32 "0jc6va3nwcqikm7chnpdv1s87my3gs2j7g1sc7g3k91brg3arxbj"))))
   (list "rust-bytemuck-1.25.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bytemuck/1.25.2/download")
          (file-name "rust-bytemuck-1.25.2.tar.gz")
          (sha256 (base32 "15rp2m7j7kq22s76cbjwmrkd5r8lvacnm0mnrj013cnzka22x0wm"))))
   (list "rust-bytemuck-derive-1.12.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bytemuck_derive/1.12.0/download")
          (file-name "rust-bytemuck-derive-1.12.0.tar.gz")
          (sha256 (base32 "07rd3m03pb51laj70pz6rb0wsgsajhfarggldgzk5qgi2skmc3pw"))))
   (list "rust-bytes-1.12.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bytes/1.12.1/download")
          (file-name "rust-bytes-1.12.1.tar.gz")
          (sha256 (base32 "017z19dpg4f942h051m7bpnzcgng042hhcpd7bmg7bjjqd42lrgw"))))
   (list "rust-cairo-rs-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cairo-rs/0.21.5/download")
          (file-name "rust-cairo-rs-0.21.5.tar.gz")
          (sha256 (base32 "1r679k0wbrxa773cw207wmnhx8sypm4s7pmncbiay5mxq0sy27xh"))))
   (list "rust-cairo-sys-rs-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cairo-sys-rs/0.21.5/download")
          (file-name "rust-cairo-sys-rs-0.21.5.tar.gz")
          (sha256 (base32 "0p14dpy8ar6gqi493nn04w5n7rp438km8icywfsma85iqs085hh6"))))
   (list "rust-calloop-0.14.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/calloop/0.14.4/download")
          (file-name "rust-calloop-0.14.4.tar.gz")
          (sha256 (base32 "1xsd8xk53v9zbvhjy7ynf4gya9s4rvvh8jqx9psi1b2v6rw9kgsd"))))
   (list "rust-calloop-wayland-source-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/calloop-wayland-source/0.4.1/download")
          (file-name "rust-calloop-wayland-source-0.4.1.tar.gz")
          (sha256 (base32 "1yi1c23naqhd8m94q3v366s4cak8l50zy7ldrkqfn0hajkqgr3hk"))))
   (list "rust-cc-1.4.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cc/1.4.5/download")
          (file-name "rust-cc-1.4.5.tar.gz")
          (sha256 (base32 "102dznr5n781pj0shcjncv6pdi9fanai38gpiphzlm551ivc4ph0"))))
   (list "rust-cexpr-0.6.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cexpr/0.6.0/download")
          (file-name "rust-cexpr-0.6.0.tar.gz")
          (sha256 (base32 "0rl77bwhs5p979ih4r0202cn5jrfsrbgrksp40lkfz5vk1x3ib3g"))))
   (list "rust-cfg-aliases-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cfg_aliases/0.2.2/download")
          (file-name "rust-cfg-aliases-0.2.2.tar.gz")
          (sha256 (base32 "09rm3dv28gbsal7w6q76lg2nfyn8wp789ska9b8vr1w750xfhygh"))))
   (list "rust-cfg-expr-0.20.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cfg-expr/0.20.9/download")
          (file-name "rust-cfg-expr-0.20.9.tar.gz")
          (sha256 (base32 "05z97ah29viw66l3c46y391nfsri9dxpwr166k36dxxmfj2cwkpy"))))
   (list "rust-chacha20-0.10.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/chacha20/0.10.2/download")
          (file-name "rust-chacha20-0.10.2.tar.gz")
          (sha256 (base32 "01hvvbgdmqkcgs2s4f12s9wa5h2gbq05rqvypv61azlwd55mxhv5"))))
   (list "rust-cfg-if-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cfg-if/1.0.4/download")
          (file-name "rust-cfg-if-1.0.4.tar.gz")
          (sha256 (base32 "008q28ajc546z5p2hcwdnckmg0hia7rnx52fni04bwqkzyrghc4k"))))
   (list "rust-chumsky-0.9.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/chumsky/0.9.3/download")
          (file-name "rust-chumsky-0.9.3.tar.gz")
          (sha256 (base32 "1jcnafc8rjfs1al08gqzyn0kpbaizgdwrd0ajqafspd18ikxdswf"))))
   (list "rust-clang-sys-1.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clang-sys/1.9.1/download")
          (file-name "rust-clang-sys-1.9.1.tar.gz")
          (sha256 (base32 "12kqa3wywpxw3jk7n2dqz9fjm8p0qczx37y0yib3nwc0njkqnyhm"))))
   (list "rust-clap-builder-4.6.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_builder/4.6.6/download")
          (file-name "rust-clap-builder-4.6.6.tar.gz")
          (sha256 (base32 "12cqg25zpjc3k82cpqa2v9h7s3vk1vydpgnwl8lfg6lfm2jzwj3v"))))
   (list "rust-clap-4.6.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap/4.6.6/download")
          (file-name "rust-clap-4.6.6.tar.gz")
          (sha256 (base32 "1jmx5z8d6jbvxdz6dybh599s4rd7ns6sl90p2rrdga09yh3pwg27"))))
   (list "rust-clap-complete-4.6.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_complete/4.6.9/download")
          (file-name "rust-clap-complete-4.6.9.tar.gz")
          (sha256 (base32 "06bagfajlrnrwjcbrqcm99np0n9mdxwxv6n8bgib1fxx4c2avqiv"))))
   (list "rust-clap-complete-nushell-4.6.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_complete_nushell/4.6.2/download")
          (file-name "rust-clap-complete-nushell-4.6.2.tar.gz")
          (sha256 (base32 "0jayjmqzm924qp2mn626rzkjmwldhv2y42ii4wbjpjdr5v46pdpz"))))
   (list "rust-clap-derive-4.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_derive/4.6.4/download")
          (file-name "rust-clap-derive-4.6.4.tar.gz")
          (sha256 (base32 "0qd0v7pa2arwxjjinmjim6xrjy61bc28m1yryhc7zjjssswx44nh"))))
   (list "rust-colorchoice-1.0.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/colorchoice/1.0.5/download")
          (file-name "rust-colorchoice-1.0.5.tar.gz")
          (sha256 (base32 "0w75k89hw39p0mnnhlrwr23q50rza1yjki44qvh2mgrnj065a1qx"))))
   (list "rust-clap-lex-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_lex/1.1.0/download")
          (file-name "rust-clap-lex-1.1.0.tar.gz")
          (sha256 (base32 "1ycqkpygnlqnndghhcxjb44lzl0nmgsia64x9581030yifxs7m68"))))
   (list "rust-combine-4.6.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/combine/4.6.8/download")
          (file-name "rust-combine-4.6.8.tar.gz")
          (sha256 (base32 "0ppwzwdmszpan9ybx1myc6ldg5zih2sazf9idckdxrh9gn9j1hyg"))))
   (list "rust-concurrent-queue-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/concurrent-queue/2.5.0/download")
          (file-name "rust-concurrent-queue-2.5.0.tar.gz")
          (sha256 (base32 "0wrr3mzq2ijdkxwndhf79k952cp4zkz35ray8hvsxl96xrx1k82c"))))
   (list "rust-console-0.16.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/console/0.16.6/download")
          (file-name "rust-console-0.16.6.tar.gz")
          (sha256 (base32 "1qv4mgi3kyvasw15mj9lcn14skrqg6m4vbxmm0kc24scfxb4jsp9"))))
   (list "rust-cookie-factory-0.3.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cookie-factory/0.3.3/download")
          (file-name "rust-cookie-factory-0.3.3.tar.gz")
          (sha256 (base32 "18mka6fk3843qq3jw1fdfvzyv05kx7kcmirfbs2vg2kbw9qzm1cq"))))
   (list "rust-cpufeatures-0.2.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cpufeatures/0.2.17/download")
          (file-name "rust-cpufeatures-0.2.17.tar.gz")
          (sha256 (base32 "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))))
   (list "rust-cpufeatures-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cpufeatures/0.3.1/download")
          (file-name "rust-cpufeatures-0.3.1.tar.gz")
          (sha256 (base32 "0rkm1l35jy1z1yfg723fddsxc7vr0gc1hhfvc138hnqiwc58p8jw"))))
   (list "rust-crc32fast-1.5.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crc32fast/1.5.1/download")
          (file-name "rust-crc32fast-1.5.1.tar.gz")
          (sha256 (base32 "0l75bfakpwr86wz45gm38lylrpgbssr529fmm6m445qy2rqwi644"))))
   (list "rust-crossbeam-epoch-0.9.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-epoch/0.9.21/download")
          (file-name "rust-crossbeam-epoch-0.9.21.tar.gz")
          (sha256 (base32 "17bdp2linl0milbmx00s3bda3fphgc85im1gqwa3p6hhhw39hx6w"))))
   (list "rust-crossbeam-utils-0.8.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-utils/0.8.23/download")
          (file-name "rust-crossbeam-utils-0.8.23.tar.gz")
          (sha256 (base32 "1ilan2nw7fvka8hki80fr57a5dgd4mvcsvwq60437j6yvlwyw7m3"))))
   (list "rust-crossbeam-deque-0.8.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-deque/0.8.8/download")
          (file-name "rust-crossbeam-deque-0.8.8.tar.gz")
          (sha256 (base32 "06kip6ay8wcx5y4flg6wxbnyd44ay8308c8lf8y3iglh6v3kybv2"))))
   (list "rust-crypto-common-0.1.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crypto-common/0.1.7/download")
          (file-name "rust-crypto-common-0.1.7.tar.gz")
          (sha256 (base32 "02nn2rhfy7kvdkdjl457q2z0mklcvj9h662xrq6dzhfialh2kj3q"))))
   (list "rust-csscolorparser-0.8.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/csscolorparser/0.8.4/download")
          (file-name "rust-csscolorparser-0.8.4.tar.gz")
          (sha256 (base32 "1n0d2h9z2hi18930wbdvf2fv8ll4b6091b268bx5g3zdvksbv38n"))))
   (list "rust-cursor-icon-1.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cursor-icon/1.2.0/download")
          (file-name "rust-cursor-icon-1.2.0.tar.gz")
          (sha256 (base32 "0bvkw7ak1mqwcpkgd9lh7n00hcvlh87jfl7188f231nz6zfy2ypj"))))
   (list "rust-diff-0.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/diff/0.1.13/download")
          (file-name "rust-diff-0.1.13.tar.gz")
          (sha256 (base32 "1j0nzjxci2zqx63hdcihkp0a4dkdmzxd7my4m7zk6cjyfy34j9an"))))
   (list "rust-digest-0.10.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/digest/0.10.7/download")
          (file-name "rust-digest-0.10.7.tar.gz")
          (sha256 (base32 "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))))
   (list "rust-directories-6.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/directories/6.0.0/download")
          (file-name "rust-directories-6.0.0.tar.gz")
          (sha256 (base32 "0zgy2w088v8w865c11dmc3dih899fgrhvrfp7g83h6v6ai60kx8n"))))
   (list "rust-dirs-sys-0.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dirs-sys/0.5.0/download")
          (file-name "rust-dirs-sys-0.5.0.tar.gz")
          (sha256 (base32 "1aqzpgq6ampza6v012gm2dppx9k35cdycbj54808ksbys9k366p0"))))
   (list "rust-dispatch2-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dispatch2/0.3.1/download")
          (file-name "rust-dispatch2-0.3.1.tar.gz")
          (sha256 (base32 "0f5xmnbzpaz1g80m27kd804p75nswh0ikb6wvqh4ba3x9rz3c3hy"))))
   (list "rust-displaydoc-0.2.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/displaydoc/0.2.7/download")
          (file-name "rust-displaydoc-0.2.7.tar.gz")
          (sha256 (base32 "1a42mwpgpwcqq2qqgkcc630wvsc2p2dkmgacjnclginwfz9js8y6"))))
   (list "rust-dlib-0.5.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dlib/0.5.3/download")
          (file-name "rust-dlib-0.5.3.tar.gz")
          (sha256 (base32 "0jpr4smrwrv8xj70mz4ixnbc6ljm82f12z2mz1hv89056y3wv3mb"))))
   (list "rust-downcast-rs-1.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/downcast-rs/1.2.1/download")
          (file-name "rust-downcast-rs-1.2.1.tar.gz")
          (sha256 (base32 "1lmrq383d1yszp7mg5i7i56b17x2lnn3kb91jwsq0zykvg2jbcvm"))))
   (list "rust-drm-0.14.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm/0.14.1/download")
          (file-name "rust-drm-0.14.1.tar.gz")
          (sha256 (base32 "0vvmj9n0wslrbw3rinpzlfyhwwgr02gqspy1al5gfh99dif8rg40"))))
   (list "rust-dpi-0.1.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dpi/0.1.2/download")
          (file-name "rust-dpi-0.1.2.tar.gz")
          (sha256 (base32 "0xhsvzgjvdch2fwmfc9vkb708b0q59b6imypyjlgbiigyb74rcfq"))))
   (list "rust-drm-fourcc-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm-fourcc/2.2.0/download")
          (file-name "rust-drm-fourcc-2.2.0.tar.gz")
          (sha256 (base32 "1x76v9a0pkgym4n6cah4barnai9gsssm7gjzxskw2agwibdvrbqa"))))
   (list "rust-drm-ffi-0.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm-ffi/0.9.1/download")
          (file-name "rust-drm-ffi-0.9.1.tar.gz")
          (sha256 (base32 "147n13dnkr4kzdj4662dqgbjfvnnw14yhmf2vq2q2kmc6adiraai"))))
   (list "rust-drm-sys-0.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm-sys/0.8.1/download")
          (file-name "rust-drm-sys-0.8.1.tar.gz")
          (sha256 (base32 "1y59h9x5yn9p36f9bqjvw76kx75yqfin1w6gzigiznb620vf3j7c"))))
   (list "rust-dyn-clone-1.0.20.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dyn-clone/1.0.20/download")
          (file-name "rust-dyn-clone-1.0.20.tar.gz")
          (sha256 (base32 "0m956cxcg8v2n8kmz6xs5zl13k2fak3zkapzfzzp7pxih6hix26h"))))
   (list "rust-either-1.18.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/either/1.18.0/download")
          (file-name "rust-either-1.18.0.tar.gz")
          (sha256 (base32 "0d7dx31sf8rakcgp63070ngb2vkjynrni866pnx879pawndgnai5"))))
   (list "rust-encode-unicode-1.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/encode_unicode/1.0.0/download")
          (file-name "rust-encode-unicode-1.0.0.tar.gz")
          (sha256 (base32 "1h5j7j7byi289by63s3w4a8b3g6l5ccdrws7a67nn07vdxj77ail"))))
   (list "rust-endi-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/endi/1.1.1/download")
          (file-name "rust-endi-1.1.1.tar.gz")
          (sha256 (base32 "16a0076dx41vgrzzimm9clcym77h732czqjiajanmzvd1i1y5dv6"))))
   (list "rust-enumflags2-0.7.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/enumflags2/0.7.12/download")
          (file-name "rust-enumflags2-0.7.12.tar.gz")
          (sha256 (base32 "1vzcskg4dca2jiflsfx1p9yw1fvgzcakcs7cpip0agl51ilgf9qh"))))
   (list "rust-enumflags2-derive-0.7.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/enumflags2_derive/0.7.12/download")
          (file-name "rust-enumflags2-derive-0.7.12.tar.gz")
          (sha256 (base32 "09rqffacafl1b83ir55hrah9gza0x7pzjn6lr6jm76fzix6qmiv7"))))
   (list "rust-equivalent-1.0.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/equivalent/1.0.2/download")
          (file-name "rust-equivalent-1.0.2.tar.gz")
          (sha256 (base32 "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))))
   (list "rust-errno-0.3.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/errno/0.3.14/download")
          (file-name "rust-errno-0.3.14.tar.gz")
          (sha256 (base32 "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))))
   (list "rust-event-listener-5.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/event-listener/5.4.2/download")
          (file-name "rust-event-listener-5.4.2.tar.gz")
          (sha256 (base32 "1lk9sv7r07l58jk263s18896l55mx9jv0g1rm4hj2mpi3paas8ss"))))
   (list "rust-event-listener-strategy-0.5.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/event-listener-strategy/0.5.4/download")
          (file-name "rust-event-listener-strategy-0.5.4.tar.gz")
          (sha256 (base32 "14rv18av8s7n8yixg38bxp5vg2qs394rl1w052by5npzmbgz7scb"))))
   (list "rust-fastrand-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fastrand/2.5.0/download")
          (file-name "rust-fastrand-2.5.0.tar.gz")
          (sha256 (base32 "08q2r30y62winysimnlpbvw9kiwn0rmdlidqlmzd6z90mv764z6s"))))
   (list "rust-fdeflate-0.3.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fdeflate/0.3.7/download")
          (file-name "rust-fdeflate-0.3.7.tar.gz")
          (sha256 (base32 "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))))
   (list "rust-field-offset-0.3.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/field-offset/0.3.6/download")
          (file-name "rust-field-offset-0.3.6.tar.gz")
          (sha256 (base32 "0zq5sssaa2ckmcmxxbly8qgz3sxpb8g1lwv90sdh1z74qif2gqiq"))))
   (list "rust-find-msvc-tools-0.1.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/find-msvc-tools/0.1.12/download")
          (file-name "rust-find-msvc-tools-0.1.12.tar.gz")
          (sha256 (base32 "0bcxgbc8g33fkpzx71ws9307ad2jyxsm35my1bc6zikj79y1q3ry"))))
   (list "rust-flate2-1.1.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/flate2/1.1.10/download")
          (file-name "rust-flate2-1.1.10.tar.gz")
          (sha256 (base32 "1jvd2cl8j5hyf8imi62y1x7gwzz1hajirni0801yxhds1qp4wqvf"))))
   (list "rust-fnv-1.0.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fnv/1.0.7/download")
          (file-name "rust-fnv-1.0.7.tar.gz")
          (sha256 (base32 "1hc2mcqha06aibcaza94vbi81j6pr9a1bbxrxjfhc91zin8yr7iz"))))
   (list "rust-foldhash-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/foldhash/0.2.0/download")
          (file-name "rust-foldhash-0.2.0.tar.gz")
          (sha256 (base32 "1nvgylb099s11xpfm1kn2wcsql080nqmnhj1l25bp3r2b35j9kkp"))))
   (list "rust-form-urlencoded-1.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/form_urlencoded/1.2.2/download")
          (file-name "rust-form-urlencoded-1.2.2.tar.gz")
          (sha256 (base32 "1kqzb2qn608rxl3dws04zahcklpplkd5r1vpabwga5l50d2v4k6b"))))
   (list "rust-futures-channel-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-channel/0.3.34/download")
          (file-name "rust-futures-channel-0.3.34.tar.gz")
          (sha256 (base32 "1i4kwcanpaphn1ax62ci3nx176kglxqx0gnhzqpqdr1rkpbf7ydi"))))
   (list "rust-futures-core-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-core/0.3.34/download")
          (file-name "rust-futures-core-0.3.34.tar.gz")
          (sha256 (base32 "0pjgv4fx0np6hrs5sz5a2phabwv0z70yr51v03injbi44bjrkmlj"))))
   (list "rust-futures-executor-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-executor/0.3.34/download")
          (file-name "rust-futures-executor-0.3.34.tar.gz")
          (sha256 (base32 "0cjl3y7jgg60wwb96ikxj23r6q91ylvx8v675yychv1w3b7lf6q3"))))
   (list "rust-futures-io-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-io/0.3.34/download")
          (file-name "rust-futures-io-0.3.34.tar.gz")
          (sha256 (base32 "1v9z6wj92ra18kpv0xig21hgpzrvcwmcr8fszyzh64yyay0zmh2k"))))
   (list "rust-futures-macro-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-macro/0.3.34/download")
          (file-name "rust-futures-macro-0.3.34.tar.gz")
          (sha256 (base32 "0i0czvcvsqq4hrccibq2f23004si5z34zjwdxfmqhlrmm15nbfcz"))))
   (list "rust-futures-lite-2.6.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-lite/2.6.1/download")
          (file-name "rust-futures-lite-2.6.1.tar.gz")
          (sha256 (base32 "1ba4dg26sc168vf60b1a23dv1d8rcf3v3ykz2psb7q70kxh113pp"))))
   (list "rust-futures-task-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-task/0.3.34/download")
          (file-name "rust-futures-task-0.3.34.tar.gz")
          (sha256 (base32 "1zfilqs8nwlfqz4prk7ihvpp5avvzins87ibzlxzq5fhs7ipshfd"))))
   (list "rust-futures-util-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-util/0.3.34/download")
          (file-name "rust-futures-util-0.3.34.tar.gz")
          (sha256 (base32 "1g3r9ghzq7c2fh34lis43i72xavk9p84npgfwgb5vfpqcwjajl0d"))))
   (list "rust-gbm-0.18.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gbm/0.18.0/download")
          (file-name "rust-gbm-0.18.0.tar.gz")
          (sha256 (base32 "0skyaj51xlazaa24jdkxxi2g6pnw834k3yqlf2ly999wincjx1ff"))))
   (list "rust-gbm-sys-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gbm-sys/0.4.0/download")
          (file-name "rust-gbm-sys-0.4.0.tar.gz")
          (sha256 (base32 "0vzp28ip4w74p05ygs4p9m7sspggn2zvcykbpyv8ypbqrhm5yfn1"))))
   (list "rust-gdk4-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gdk4/0.10.3/download")
          (file-name "rust-gdk4-0.10.3.tar.gz")
          (sha256 (base32 "1gxzhk55r0nh48ld7l1j700cc6jqh8jvvzw8bph4qjmy5chn8rbm"))))
   (list "rust-gdk-pixbuf-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gdk-pixbuf/0.21.5/download")
          (file-name "rust-gdk-pixbuf-0.21.5.tar.gz")
          (sha256 (base32 "0350zm38d7sf3ilnwy9fxyhajbdslvjdcm7xxlk4dn6dwcwhvfyy"))))
   (list "rust-gdk4-sys-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gdk4-sys/0.10.3/download")
          (file-name "rust-gdk4-sys-0.10.3.tar.gz")
          (sha256 (base32 "0d5hk2agfifnn0hgcjyb4lcrvrdlaxgkzj6w99m854gmrjrybm56"))))
   (list "rust-gdk-pixbuf-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gdk-pixbuf-sys/0.21.5/download")
          (file-name "rust-gdk-pixbuf-sys-0.21.5.tar.gz")
          (sha256 (base32 "1rqc1bv3ln6hx4a4bn3jagz75dzhmy96hkyx4lg5blm3p58av5dx"))))
   (list "rust-generator-0.8.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/generator/0.8.9/download")
          (file-name "rust-generator-0.8.9.tar.gz")
          (sha256 (base32 "1bhk2m8alf9nfmmq2y2whyriigppgjnzrchq7yix3sl4wnq59f5k"))))
   (list "rust-generic-array-0.14.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/generic-array/0.14.7/download")
          (file-name "rust-generic-array-0.14.7.tar.gz")
          (sha256 (base32 "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))))
   (list "rust-gethostname-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gethostname/1.1.0/download")
          (file-name "rust-gethostname-1.1.0.tar.gz")
          (sha256 (base32 "1n6bj9gh503ggjblfjcai96gmxynxsrykaynljlrfdra34q95m0v"))))
   (list "rust-getrandom-0.4.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/getrandom/0.4.3/download")
          (file-name "rust-getrandom-0.4.3.tar.gz")
          (sha256 (base32 "16b0202fkdwz3p2cyll82dv24ljbn0wiyy829v4lwbkbflyqh3ih"))))
   (list "rust-getrandom-0.2.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/getrandom/0.2.17/download")
          (file-name "rust-getrandom-0.2.17.tar.gz")
          (sha256 (base32 "1l2ac6jfj9xhpjjgmcx6s1x89bbnw9x6j9258yy6xjkzpq0bqapz"))))
   (list "rust-getrandom-0.3.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/getrandom/0.3.4/download")
          (file-name "rust-getrandom-0.3.4.tar.gz")
          (sha256 (base32 "1zbpvpicry9lrbjmkd4msgj3ihff1q92i334chk7pzf46xffz7c9"))))
   (list "rust-gio-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gio-sys/0.21.5/download")
          (file-name "rust-gio-sys-0.21.5.tar.gz")
          (sha256 (base32 "08hgv0lqm94hyhdisjrl52bg9699c9ibp6zzr2301r58vf4gww80"))))
   (list "rust-gio-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gio/0.21.5/download")
          (file-name "rust-gio-0.21.5.tar.gz")
          (sha256 (base32 "06l1nlq5r0dvm0xmhrpgvs8ypx7jcb3vgihxwrvb8s0cc2zlizy5"))))
   (list "rust-git-version-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/git-version/0.3.9/download")
          (file-name "rust-git-version-0.3.9.tar.gz")
          (sha256 (base32 "06ddi3px6l2ip0srn8512bsh8wrx4rzi65piya0vrz5h7nm6im8s"))))
   (list "rust-glam-0.33.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glam/0.33.7/download")
          (file-name "rust-glam-0.33.7.tar.gz")
          (sha256 (base32 "09a7gwhrymbgsh2qvl9ishzw8lnklcpbcm7csh4cakv3i2qvjqp7"))))
   (list "rust-git-version-macro-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/git-version-macro/0.3.9/download")
          (file-name "rust-git-version-macro-0.3.9.tar.gz")
          (sha256 (base32 "1h1s08fgh9bkwnc2hmjxcldv69hlxpq7a09cqdxsd5hb235hq0ak"))))
   (list "rust-gl-generator-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gl_generator/0.14.0/download")
          (file-name "rust-gl-generator-0.14.0.tar.gz")
          (sha256 (base32 "0k8j1hmfnff312gy7x1aqjzcm8zxid7ij7dlb8prljib7b1dz58s"))))
   (list "rust-glib-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glib/0.21.5/download")
          (file-name "rust-glib-0.21.5.tar.gz")
          (sha256 (base32 "12xxy5js4bfpjz9k6831xj090r5y37g30wrvawxwx43c5qy15phn"))))
   (list "rust-glib-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glib-sys/0.21.5/download")
          (file-name "rust-glib-sys-0.21.5.tar.gz")
          (sha256 (base32 "0v1ymxb51sbwv242slq21kbn8g38j2day53f52kn9r4sl6iy359d"))))
   (list "rust-glib-macros-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glib-macros/0.21.5/download")
          (file-name "rust-glib-macros-0.21.5.tar.gz")
          (sha256 (base32 "05vzv1m4dg1cpkakxk3n1846acv4fhwhghq1zsbaca0j61svcnfg"))))
   (list "rust-glob-0.3.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glob/0.3.4/download")
          (file-name "rust-glob-0.3.4.tar.gz")
          (sha256 (base32 "02zby4rsidb2ksrnysyrsaap7rk6wpp7vl5chflndafhl5gaisz4"))))
   (list "rust-gobject-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gobject-sys/0.21.5/download")
          (file-name "rust-gobject-sys-0.21.5.tar.gz")
          (sha256 (base32 "157jv8ga4f7p4vrn4mmg84lrl0ly3kz9kjzkfm2qz88r1pd3bjid"))))
   (list "rust-graphene-rs-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/graphene-rs/0.21.5/download")
          (file-name "rust-graphene-rs-0.21.5.tar.gz")
          (sha256 (base32 "1yg23ws354622ya5qccwvf9gpjn188vhkrz1pzc3yrnvr4506c17"))))
   (list "rust-graphene-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/graphene-sys/0.21.5/download")
          (file-name "rust-graphene-sys-0.21.5.tar.gz")
          (sha256 (base32 "14zxhk20yypksyh8kx14xf5ddhjifcmzcjh49cg29bd93q4k4pli"))))
   (list "rust-gsk4-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gsk4/0.10.3/download")
          (file-name "rust-gsk4-0.10.3.tar.gz")
          (sha256 (base32 "0lx17acgawg9xn216lgikcdpy1lxjvhqk2q2mazcb5jqijfxwmg7"))))
   (list "rust-gsk4-sys-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gsk4-sys/0.10.3/download")
          (file-name "rust-gsk4-sys-0.10.3.tar.gz")
          (sha256 (base32 "1xzlf8yidajc86cm7fcmn5br11lgdn3l242z0s1g8ihi75r19sbw"))))
   (list "rust-gtk4-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gtk4/0.10.3/download")
          (file-name "rust-gtk4-0.10.3.tar.gz")
          (sha256 (base32 "1971514d9kadzj61rn28fgc4gjk77g2335sl8fpvzxy6rx9ivcmc"))))
   (list "rust-gtk4-macros-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gtk4-macros/0.10.3/download")
          (file-name "rust-gtk4-macros-0.10.3.tar.gz")
          (sha256 (base32 "0hiy02q0gnfqg1bj8iycb5xmgm0jz80q2psxh521551x9ahvbkrw"))))
   (list "rust-gtk4-sys-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gtk4-sys/0.10.3/download")
          (file-name "rust-gtk4-sys-0.10.3.tar.gz")
          (sha256 (base32 "1pc803r3921h44pa773qpirn3aqcrq2fibykdhb5vq8ybbz7f9c4"))))
   (list "rust-hashbrown-0.14.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hashbrown/0.14.5/download")
          (file-name "rust-hashbrown-0.14.5.tar.gz")
          (sha256 (base32 "1wa1vy1xs3mp11bn3z9dv0jricgr6a2j0zkf1g19yz3vw4il89z5"))))
   (list "rust-heck-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/heck/0.4.1/download")
          (file-name "rust-heck-0.4.1.tar.gz")
          (sha256 (base32 "1a7mqsnycv5z4z5vnv1k34548jzmc0ajic7c1j8jsaspnhw5ql4m"))))
   (list "rust-hashbrown-0.17.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hashbrown/0.17.1/download")
          (file-name "rust-hashbrown-0.17.1.tar.gz")
          (sha256 (base32 "0jmqz7i4yl6cm7rbn0i2ffkfrmwi6xkmzkaldr2v8bcsx2v0jngd"))))
   (list "rust-heck-0.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/heck/0.5.0/download")
          (file-name "rust-heck-0.5.0.tar.gz")
          (sha256 (base32 "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))))
   (list "rust-hermit-abi-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hermit-abi/0.3.9/download")
          (file-name "rust-hermit-abi-0.3.9.tar.gz")
          (sha256 (base32 "092hxjbjnq5fmz66grd9plxd0sh6ssg5fhgwwwqbrzgzkjwdycfj"))))
   (list "rust-hermit-abi-0.5.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hermit-abi/0.5.3/download")
          (file-name "rust-hermit-abi-0.5.3.tar.gz")
          (sha256 (base32 "115jzi6ixx2nhkzbr2ijj36634agz32n6ilz2rg7vk5s1vb94xg1"))))
   (list "rust-hex-0.4.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hex/0.4.3/download")
          (file-name "rust-hex-0.4.3.tar.gz")
          (sha256 (base32 "0w1a4davm1lgzpamwnba907aysmlrnygbqmfis2mqjx5m552a93z"))))
   (list "rust-icu-normalizer-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_normalizer/2.2.0/download")
          (file-name "rust-icu-normalizer-2.2.0.tar.gz")
          (sha256 (base32 "1d7krxr0xpc4x9635k1100a24nh0nrc59n65j6yk6gbfkplmwvn5"))))
   (list "rust-icu-collections-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_collections/2.2.0/download")
          (file-name "rust-icu-collections-2.2.0.tar.gz")
          (sha256 (base32 "070r7xd0pynm0hnc1v2jzlbxka6wf50f81wybf9xg0y82v6x3119"))))
   (list "rust-icu-locale-core-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_locale_core/2.2.0/download")
          (file-name "rust-icu-locale-core-2.2.0.tar.gz")
          (sha256 (base32 "0a9cmin5w1x3bg941dlmgszn33qgq428k7qiqn5did72ndi9n8cj"))))
   (list "rust-icu-normalizer-data-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_normalizer_data/2.2.0/download")
          (file-name "rust-icu-normalizer-data-2.2.0.tar.gz")
          (sha256 (base32 "0f5d5d5fhhr9937m2z6z38fzh6agf14z24kwlr6lyczafypf0fys"))))
   (list "rust-icu-properties-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_properties/2.2.0/download")
          (file-name "rust-icu-properties-2.2.0.tar.gz")
          (sha256 (base32 "1pkh3s837808cbwxvfagwc28cvwrz2d9h5rl02jwrhm51ryvdqxy"))))
   (list "rust-icu-provider-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_provider/2.2.0/download")
          (file-name "rust-icu-provider-2.2.0.tar.gz")
          (sha256 (base32 "08dl8pxbwr8zsz4c5vphqb7xw0hykkznwi4rw7bk6pwb3krlr70k"))))
   (list "rust-icu-properties-data-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_properties_data/2.2.0/download")
          (file-name "rust-icu-properties-data-2.2.0.tar.gz")
          (sha256 (base32 "052awny0qwkbcbpd5jg2cd7vl5ry26pq4hz1nfsgf10c3qhbnawf"))))
   (list "rust-idna-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/idna/1.1.0/download")
          (file-name "rust-idna-1.1.0.tar.gz")
          (sha256 (base32 "1pp4n7hppm480zcx411dsv9wfibai00wbpgnjj4qj0xa7kr7a21v"))))
   (list "rust-idna-adapter-1.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/idna_adapter/1.2.2/download")
          (file-name "rust-idna-adapter-1.2.2.tar.gz")
          (sha256 (base32 "0557p76l8hj35r9zn1yv7c6x1c0qbrsffmg80n0yy8361ly3fs6b"))))
   (list "rust-indexmap-2.14.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/indexmap/2.14.2/download")
          (file-name "rust-indexmap-2.14.2.tar.gz")
          (sha256 (base32 "0mf86hbjkkcd82cpq683bblbs0zwa8ndla96ci8p1ji6bl7ijknc"))))
   (list "rust-input-0.10.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/input/0.10.0/download")
          (file-name "rust-input-0.10.0.tar.gz")
          (sha256 (base32 "17cmlwa5z6z3x47r7m78vmh8f7rmv2sncc53cdvk2waxlr2k6ygr"))))
   (list "rust-input-sys-1.19.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/input-sys/1.19.0/download")
          (file-name "rust-input-sys-1.19.0.tar.gz")
          (sha256 (base32 "1rqrrglhgyyiy7xh8jvf9jwh2dyk2g7l5rmjaazrbg82iryy1vin"))))
   (list "rust-insta-1.48.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/insta/1.48.0/download")
          (file-name "rust-insta-1.48.0.tar.gz")
          (sha256 (base32 "10kbxza7vzj4nvkga8r3rfn6z8i3hnh47bnnb1f429n9x3zgiw46"))))
   (list "rust-is-ci-1.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/is_ci/1.2.0/download")
          (file-name "rust-is-ci-1.2.0.tar.gz")
          (sha256 (base32 "0ifwvxmrsj4r29agfzr71bjq6y1bihkx38fbzafq5vl0jn1wjmbn"))))
   (list "rust-io-lifetimes-1.0.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/io-lifetimes/1.0.11/download")
          (file-name "rust-io-lifetimes-1.0.11.tar.gz")
          (sha256 (base32 "1hph5lz4wd3drnn6saakwxr497liznpfnv70via6s0v8x6pbkrza"))))
   (list "rust-is-terminal-0.4.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/is-terminal/0.4.17/download")
          (file-name "rust-is-terminal-0.4.17.tar.gz")
          (sha256 (base32 "0ilfr9n31m0k6fsm3gvfrqaa62kbzkjqpwcd9mc46klfig1w2h1n"))))
   (list "rust-is-terminal-polyfill-1.70.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/is_terminal_polyfill/1.70.2/download")
          (file-name "rust-is-terminal-polyfill-1.70.2.tar.gz")
          (sha256 (base32 "15anlc47sbz0jfs9q8fhwf0h3vs2w4imc030shdnq54sny5i7jx6"))))
   (list "rust-itertools-0.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itertools/0.13.0/download")
          (file-name "rust-itertools-0.13.0.tar.gz")
          (sha256 (base32 "11hiy3qzl643zcigknclh446qb9zlg4dpdzfkjaa9q9fqpgyfgj1"))))
   (list "rust-itoa-1.0.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itoa/1.0.18/download")
          (file-name "rust-itoa-1.0.18.tar.gz")
          (sha256 (base32 "10jnd1vpfkb8kj38rlkn2a6k02afvj3qmw054dfpzagrpl6achlg"))))
   (list "rust-jni-0.22.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni/0.22.4/download")
          (file-name "rust-jni-0.22.4.tar.gz")
          (sha256 (base32 "161lza8gz071h22pgyqyx4n91ixd691z2dbb1pq2g97k5i49mzay"))))
   (list "rust-jni-macros-0.22.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-macros/0.22.4/download")
          (file-name "rust-jni-macros-0.22.4.tar.gz")
          (sha256 (base32 "18v02mcn5c7mb2yw6r930xg6ynsn7hwkxv8z2kdhn3qprjn0j0d0"))))
   (list "rust-jni-sys-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-sys/0.3.1/download")
          (file-name "rust-jni-sys-0.3.1.tar.gz")
          (sha256 (base32 "0n1j8fbz081w1igfrpc79n6vgm7h3ik34nziy5fjgq5nz7hm59j1"))))
   (list "rust-jni-sys-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-sys/0.4.1/download")
          (file-name "rust-jni-sys-0.4.1.tar.gz")
          (sha256 (base32 "1wlahx6f2zhczdjqyn8mk7kshb8x5vsd927sn3lvw41rrf47ldy6"))))
   (list "rust-jni-sys-macros-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-sys-macros/0.4.1/download")
          (file-name "rust-jni-sys-macros-0.4.1.tar.gz")
          (sha256 (base32 "0r32gbabrak15a7p487765b5wc0jcna2yv88mk6m1zjqyi1bkh1q"))))
   (list "rust-jobserver-0.1.35.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jobserver/0.1.35/download")
          (file-name "rust-jobserver-0.1.35.tar.gz")
          (sha256 (base32 "1crwgbb0wjph42ni4hqryjxlv4vlr0hyk81g76id9fpa56ysq00w"))))
   (list "rust-js-sys-0.3.105.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/js-sys/0.3.105/download")
          (file-name "rust-js-sys-0.3.105.tar.gz")
          (sha256 (base32 "17pr58p55pxbflkjl2wz6pyz854j80nlgavjq4mcwr583q6x4myf"))))
   (list "rust-keyboard-types-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/keyboard-types/0.8.3/download")
          (file-name "rust-keyboard-types-0.8.3.tar.gz")
          (sha256 (base32 "13dj6jsk4rr4kqghlxyr3ql7ajfrg65awc1h4c21mris80xqbghg"))))
   (list "rust-keyframe-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/keyframe/1.1.1/download")
          (file-name "rust-keyframe-1.1.1.tar.gz")
          (sha256 (base32 "1afr5ffns3k79xaqnw6rw3qn8sngwly6gxfnjn8d060mk3vqnw30"))))
   (list "rust-khronos-api-3.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/khronos_api/3.1.0/download")
          (file-name "rust-khronos-api-3.1.0.tar.gz")
          (sha256 (base32 "1p0xj5mlbagqyvvnv8wmv3cr7l9y1m153888pxqwg3vk3mg5inz2"))))
   (list "rust-knuffel-3.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/knuffel/3.2.0/download")
          (file-name "rust-knuffel-3.2.0.tar.gz")
          (sha256 (base32 "04vl2xmdn280rcigv96v06a00v7gbxqggr0w9cqi2407qvfydgh4"))))
   (list "rust-knuffel-derive-3.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/knuffel-derive/3.2.0/download")
          (file-name "rust-knuffel-derive-3.2.0.tar.gz")
          (sha256 (base32 "0g98909l5wb1d1hcz61q53kvsmjadry2w3l47lg9dywwqib7z5wi"))))
   (list "rust-lazy-static-1.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/lazy_static/1.5.0/download")
          (file-name "rust-lazy-static-1.5.0.tar.gz")
          (sha256 (base32 "1zk6dqqni0193xg6iijh7i3i44sryglwgvx20spdvwk3r6sbrlmv"))))
   (list "rust-libadwaita-0.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libadwaita/0.8.1/download")
          (file-name "rust-libadwaita-0.8.1.tar.gz")
          (sha256 (base32 "0js8slasp2y4zr4hqjbqpp70rk38fq59v0sw66rl4czpz0my22gv"))))
   (list "rust-libadwaita-sys-0.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libadwaita-sys/0.8.1/download")
          (file-name "rust-libadwaita-sys-0.8.1.tar.gz")
          (sha256 (base32 "0c9y9azfdnbnpxvjy514fd87sdafy28j9nnazsbbazm8gci98zvd"))))
   (list "rust-libc-0.2.189.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libc/0.2.189/download")
          (file-name "rust-libc-0.2.189.tar.gz")
          (sha256 (base32 "1whjfs375vlng2q6yrbzs73cvp5lm3w1n2gfqajb2vgf7zg3xbry"))))
   (list "rust-libdisplay-info-sys-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libdisplay-info-sys/0.3.0/download")
          (file-name "rust-libdisplay-info-sys-0.3.0.tar.gz")
          (sha256 (base32 "07xmkc2aqcdn6d58321y87rd3gzdr4nx3ncm1mmrr7w1p1ahsn96"))))
   (list "rust-libdisplay-info-derive-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libdisplay-info-derive/0.1.1/download")
          (file-name "rust-libdisplay-info-derive-0.1.1.tar.gz")
          (sha256 (base32 "162ahw5kry0d7yf50b62dhw18s6c9bkdjim4409fj6aqrw8cghld"))))
   (list "rust-libdisplay-info-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libdisplay-info/0.3.0/download")
          (file-name "rust-libdisplay-info-0.3.0.tar.gz")
          (sha256 (base32 "0nf3c4rpdhgpr8g7dn2wrjyzwl45vz5sq1sg64gz67rqnbdrdzar"))))
   (list "rust-libloading-0.8.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libloading/0.8.9/download")
          (file-name "rust-libloading-0.8.9.tar.gz")
          (sha256 (base32 "0mfwxwjwi2cf0plxcd685yxzavlslz7xirss3b9cbrzyk4hv1i6p"))))
   (list "rust-libm-0.2.16.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libm/0.2.16/download")
          (file-name "rust-libm-0.2.16.tar.gz")
          (sha256 (base32 "10brh0a3qjmbzkr5mf5xqi887nhs5y9layvnki89ykz9xb1wxlmn"))))
   (list "rust-libseat-sys-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libseat-sys/0.2.0/download")
          (file-name "rust-libseat-sys-0.2.0.tar.gz")
          (sha256 (base32 "1yvx15lx8qj3xycdx4ddzs681ayhg5vpdvgzsfl64pxy93x89978"))))
   (list "rust-libredox-0.1.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libredox/0.1.23/download")
          (file-name "rust-libredox-0.1.23.tar.gz")
          (sha256 (base32 "1v885rvnqvazkjikw1yr4b2azy8acg0vbjgnr9fl1lqzyaiix3wd"))))
   (list "rust-libseat-0.2.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libseat/0.2.4/download")
          (file-name "rust-libseat-0.2.4.tar.gz")
          (sha256 (base32 "0cggn682xklm5h7i8bbjc48wjpys9wz2y8xa7ywgyrh3dsdwcmk6"))))
   (list "rust-libspa-0.10.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libspa/0.10.1/download")
          (file-name "rust-libspa-0.10.1.tar.gz")
          (sha256 (base32 "0h2c1f7s99ylki3gm7vgd7bs3403cg20azwb72fwr7cqwwkp8bw8"))))
   (list "rust-libspa-sys-0.10.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libspa-sys/0.10.1/download")
          (file-name "rust-libspa-sys-0.10.1.tar.gz")
          (sha256 (base32 "090r57qrpz16mis8qbhi6fbzsh9b0cj2c0j485g0vvb3myyifviv"))))
   (list "rust-libudev-sys-0.1.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libudev-sys/0.1.4/download")
          (file-name "rust-libudev-sys-0.1.4.tar.gz")
          (sha256 (base32 "09236fdzlx9l0dlrsc6xx21v5x8flpfm3d5rjq9jr5ivlas6k11w"))))
   (list "rust-linux-raw-sys-0.4.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/linux-raw-sys/0.4.15/download")
          (file-name "rust-linux-raw-sys-0.4.15.tar.gz")
          (sha256 (base32 "1aq7r2g7786hyxhv40spzf2nhag5xbw2axxc1k8z5k1dsgdm4v6j"))))
   (list "rust-linux-raw-sys-0.12.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/linux-raw-sys/0.12.1/download")
          (file-name "rust-linux-raw-sys-0.12.1.tar.gz")
          (sha256 (base32 "0lwasljrqxjjfk9l2j8lyib1babh2qjlnhylqzl01nihw14nk9ij"))))
   (list "rust-litemap-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/litemap/0.8.3/download")
          (file-name "rust-litemap-0.8.3.tar.gz")
          (sha256 (base32 "1bpgpj87560hmckh3875fbahpmfxbk4g8pzns84h3ykf3nfx3na7"))))
   (list "rust-linux-raw-sys-0.9.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/linux-raw-sys/0.9.4/download")
          (file-name "rust-linux-raw-sys-0.9.4.tar.gz")
          (sha256 (base32 "04kyjdrq79lz9ibrf7czk6cv9d3jl597pb9738vzbsbzy1j5i56d"))))
   (list "rust-log-0.4.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/log/0.4.34/download")
          (file-name "rust-log-0.4.34.tar.gz")
          (sha256 (base32 "1ihkzn0m33ab79fcl4mkb04n5iwqzbxzyw7l7hazqkffaqzbvy7r"))))
   (list "rust-loom-0.7.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/loom/0.7.2/download")
          (file-name "rust-loom-0.7.2.tar.gz")
          (sha256 (base32 "1jpszf9qxv8ydpsm2h9vcyvxvyxcfkhmmfbylzd4gfbc0k40v7j1"))))
   (list "rust-matchers-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/matchers/0.2.0/download")
          (file-name "rust-matchers-0.2.0.tar.gz")
          (sha256 (base32 "1sasssspdj2vwcwmbq3ra18d3qniapkimfcbr47zmx6750m5llni"))))
   (list "rust-memchr-2.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memchr/2.8.3/download")
          (file-name "rust-memchr-2.8.3.tar.gz")
          (sha256 (base32 "161xa63ipfanf8v3nb82xd5hqgydv55nzw59wyngqbz6alfaz2yg"))))
   (list "rust-memmap2-0.9.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memmap2/0.9.11/download")
          (file-name "rust-memmap2-0.9.11.tar.gz")
          (sha256 (base32 "1h4qnzgarnn488ljjpg9ns5y4bw0sq0xv0fj0iqywagjnz8rw8fi"))))
   (list "rust-memoffset-0.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memoffset/0.9.1/download")
          (file-name "rust-memoffset-0.9.1.tar.gz")
          (sha256 (base32 "12i17wh9a9plx869g7j4whf62xw68k5zd4k0k5nh6ys5mszid028"))))
   (list "rust-miette-5.10.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/miette/5.10.0/download")
          (file-name "rust-miette-5.10.0.tar.gz")
          (sha256 (base32 "0vl5qvl3bgha6nnkdl7kiha6v4ypd6d51wyc4q1bvdpamr75ifsr"))))
   (list "rust-miette-derive-5.10.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/miette-derive/5.10.0/download")
          (file-name "rust-miette-derive-5.10.0.tar.gz")
          (sha256 (base32 "0p33msrngkxlp5ajm8nijamii9vcwwpy8gfh4m53qnmrc0avrrs9"))))
   (list "rust-miniz-oxide-0.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/miniz_oxide/0.9.1/download")
          (file-name "rust-miniz-oxide-0.9.1.tar.gz")
          (sha256 (base32 "0k2bgjzk2sbsynpsv4wizwxbqp6vs7g08y5anbkrh3l6a15bqgxn"))))
   (list "rust-miniz-oxide-0.8.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/miniz_oxide/0.8.9/download")
          (file-name "rust-miniz-oxide-0.8.9.tar.gz")
          (sha256 (base32 "05k3pdg8bjjzayq3rf0qhpirq9k37pxnasfn4arbs17phqn6m9qz"))))
   (list "rust-minimal-lexical-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/minimal-lexical/0.2.1/download")
          (file-name "rust-minimal-lexical-0.2.1.tar.gz")
          (sha256 (base32 "16ppc5g84aijpri4jzv14rvcnslvlpphbszc7zzp6vfkddf4qdb8"))))
   (list "rust-ndk-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ndk/0.9.0/download")
          (file-name "rust-ndk-0.9.0.tar.gz")
          (sha256 (base32 "1m32zpmi5w1pf3j47k6k5fw395dc7aj8d0mdpsv53lqkprxjxx63"))))
   (list "rust-ndk-context-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ndk-context/0.1.1/download")
          (file-name "rust-ndk-context-0.1.1.tar.gz")
          (sha256 (base32 "12sai3dqsblsvfd1l1zab0z6xsnlha3xsfl7kagdnmj3an3jvc17"))))
   (list "rust-nix-0.31.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nix/0.31.3/download")
          (file-name "rust-nix-0.31.3.tar.gz")
          (sha256 (base32 "0gbwnjfny9rq9hl5bz4ry520n9rnfknna4bg88n66f7zx3yx486g"))))
   (list "rust-ndk-sys-0.6.0+11769913.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ndk-sys/0.6.0+11769913/download")
          (file-name "rust-ndk-sys-0.6.0+11769913.tar.gz")
          (sha256 (base32 "0wx8r6pji20if4xs04g73gxl98nmjrfc73z0v6w1ypv6a4qdlv7f"))))
   (list "rust-nom-7.1.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nom/7.1.3/download")
          (file-name "rust-nom-7.1.3.tar.gz")
          (sha256 (base32 "0jha9901wxam390jcf5pfa0qqfrgh8li787jx2ip0yk5b8y9hwyj"))))
   (list "rust-nom-8.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nom/8.0.0/download")
          (file-name "rust-nom-8.0.0.tar.gz")
          (sha256 (base32 "01cl5xng9d0gxf26h39m0l8lprgpa00fcc75ps1yzgbib1vn35yz"))))
   (list "rust-nu-ansi-term-0.50.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nu-ansi-term/0.50.3/download")
          (file-name "rust-nu-ansi-term-0.50.3.tar.gz")
          (sha256 (base32 "1ra088d885lbd21q1bxgpqdlk1zlndblmarn948jz2a40xsbjmvr"))))
   (list "rust-num-enum-0.7.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num_enum/0.7.6/download")
          (file-name "rust-num-enum-0.7.6.tar.gz")
          (sha256 (base32 "09kg0c2y08npdv0c9dbm4m9a9wz8w2qaiqqxl4gj3v22hj1wl2sx"))))
   (list "rust-num-enum-derive-0.7.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num_enum_derive/0.7.6/download")
          (file-name "rust-num-enum-derive-0.7.6.tar.gz")
          (sha256 (base32 "1y0x9z49s27vdas6mglqbv02sgkdmbr8ns2kwspzrp2ra81rh2b8"))))
   (list "rust-objc2-app-kit-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-app-kit/0.3.2/download")
          (file-name "rust-objc2-app-kit-0.3.2.tar.gz")
          (sha256 (base32 "132ijwni8lsi8phq7wnmialkxp46zx998fns3zq5np0ya1mr77nl"))))
   (list "rust-objc2-0.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2/0.6.4/download")
          (file-name "rust-objc2-0.6.4.tar.gz")
          (sha256 (base32 "17x8qpl512frscfqbmgjr20kg3y4r0xdqxphja17dz5f0znsh4is"))))
   (list "rust-num-traits-0.2.19.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-traits/0.2.19/download")
          (file-name "rust-num-traits-0.2.19.tar.gz")
          (sha256 (base32 "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))))
   (list "rust-objc2-core-foundation-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-core-foundation/0.3.2/download")
          (file-name "rust-objc2-core-foundation-0.3.2.tar.gz")
          (sha256 (base32 "0dnmg7606n4zifyjw4ff554xvjmi256cs8fpgpdmr91gckc0s61a"))))
   (list "rust-objc2-core-graphics-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-core-graphics/0.3.2/download")
          (file-name "rust-objc2-core-graphics-0.3.2.tar.gz")
          (sha256 (base32 "01x8413pxq0m5rwidlaczni8v5cz9dc3xqzq8l9zlpl9cv8cj8p0"))))
   (list "rust-objc2-core-video-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-core-video/0.3.2/download")
          (file-name "rust-objc2-core-video-0.3.2.tar.gz")
          (sha256 (base32 "19j1a7f863gh30nq03w70x1js3f3vdg3wp4azllky8vkvzqwl9fl"))))
   (list "rust-objc2-encode-4.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-encode/4.1.0/download")
          (file-name "rust-objc2-encode-4.1.0.tar.gz")
          (sha256 (base32 "0cqckp4cpf68mxyc2zgnazj8klv0z395nsgbafa61cjgsyyan9gg"))))
   (list "rust-once-cell-1.21.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/once_cell/1.21.4/download")
          (file-name "rust-once-cell-1.21.4.tar.gz")
          (sha256 (base32 "0l1v676wf71kjg2khch4dphwh1jp3291ffiymr2mvy1kxd5kwz4z"))))
   (list "rust-objc2-foundation-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-foundation/0.3.2/download")
          (file-name "rust-objc2-foundation-0.3.2.tar.gz")
          (sha256 (base32 "0wijkxzzvw2xkzssds3fj8279cbykz2rz9agxf6qh7y2agpsvq73"))))
   (list "rust-objc2-ui-kit-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-ui-kit/0.3.2/download")
          (file-name "rust-objc2-ui-kit-0.3.2.tar.gz")
          (sha256 (base32 "08mbgqg8pffclyxpz2lr8r1fv8wn2i4m1k6bk1s5fvy06f766zfq"))))
   (list "rust-once-cell-polyfill-1.70.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/once_cell_polyfill/1.70.2/download")
          (file-name "rust-once-cell-polyfill-1.70.2.tar.gz")
          (sha256 (base32 "1zmla628f0sk3fhjdjqzgxhalr2xrfna958s632z65bjsfv8ljrq"))))
   (list "rust-option-ext-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/option-ext/0.2.0/download")
          (file-name "rust-option-ext-0.2.0.tar.gz")
          (sha256 (base32 "0zbf7cx8ib99frnlanpyikm1bx8qn8x602sw1n7bg6p9x94lyx04"))))
   (list "rust-orbclient-0.4.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/orbclient/0.4.6/download")
          (file-name "rust-orbclient-0.4.6.tar.gz")
          (sha256 (base32 "0sry8hmkxv87l056qhkgmnq2zzvgjdlx7pqjg4yj107i72kl1w81"))))
   (list "rust-ordered-float-5.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ordered-float/5.4.0/download")
          (file-name "rust-ordered-float-5.4.0.tar.gz")
          (sha256 (base32 "15ifnrmxb135xvw3h1b19ggwq0izp86d4b1f0g6c6jna4wrgsq68"))))
   (list "rust-pango-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pango/0.21.5/download")
          (file-name "rust-pango-0.21.5.tar.gz")
          (sha256 (base32 "0sgb6xls3l07f7b257rp3gjx9g6mhckhgz5pbc37l1vq41gdilaj"))))
   (list "rust-pangocairo-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pangocairo/0.21.5/download")
          (file-name "rust-pangocairo-0.21.5.tar.gz")
          (sha256 (base32 "1j589pc743ndih5y45bjdyyx75x7layxk585hsfr6wj06225qv5k"))))
   (list "rust-ordered-stream-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ordered-stream/0.2.0/download")
          (file-name "rust-ordered-stream-0.2.0.tar.gz")
          (sha256 (base32 "0l0xxp697q7wiix1gnfn66xsss7fdhfivl2k7bvpjs4i3lgb18ls"))))
   (list "rust-owo-colors-3.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/owo-colors/3.5.0/download")
          (file-name "rust-owo-colors-3.5.0.tar.gz")
          (sha256 (base32 "0vyvry6ba1xmpd45hpi6savd8mbx09jpmvnnwkf6z62pk6s4zc61"))))
   (list "rust-pango-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pango-sys/0.21.5/download")
          (file-name "rust-pango-sys-0.21.5.tar.gz")
          (sha256 (base32 "1zbcw3b2i5ixzy0ds65z2xdvllifzh8m5xid7lqgzmbfsckndw5l"))))
   (list "rust-pangocairo-sys-0.21.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pangocairo-sys/0.21.5/download")
          (file-name "rust-pangocairo-sys-0.21.5.tar.gz")
          (sha256 (base32 "01llh57z386p059b113v3lkfzygkl05x8ag36w6nxrwbscdb1nza"))))
   (list "rust-parking-2.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/parking/2.2.1/download")
          (file-name "rust-parking-2.2.1.tar.gz")
          (sha256 (base32 "1fnfgmzkfpjd69v4j9x737b1k8pnn054bvzcn5dm3pkgq595d3gk"))))
   (list "rust-paste-1.0.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/paste/1.0.15/download")
          (file-name "rust-paste-1.0.15.tar.gz")
          (sha256 (base32 "02pxffpdqkapy292harq6asfjvadgp1s005fip9ljfsn9fvxgh2p"))))
   (list "rust-percent-encoding-2.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/percent-encoding/2.3.2/download")
          (file-name "rust-percent-encoding-2.3.2.tar.gz")
          (sha256 (base32 "083jv1ai930azvawz2khv7w73xh8mnylk7i578cifndjn5y64kwv"))))
   (list "rust-phf-0.13.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf/0.13.1/download")
          (file-name "rust-phf-0.13.1.tar.gz")
          (sha256 (base32 "1pzswx5gdglgjgp4azyzwyr4gh031r0kcnpqq6jblga72z3jsmn1"))))
   (list "rust-phf-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf/0.14.0/download")
          (file-name "rust-phf-0.14.0.tar.gz")
          (sha256 (base32 "1xm2nbg5c59b5wvvv4v3sd3sknrlg2z17bkzk440p2090dw7h0q1"))))
   (list "rust-phf-generator-0.13.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf_generator/0.13.1/download")
          (file-name "rust-phf-generator-0.13.1.tar.gz")
          (sha256 (base32 "0dwpp11l41dy9mag4phkyyvhpf66lwbp79q3ik44wmhyfqxcwnhk"))))
   (list "rust-phf-generator-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf_generator/0.14.0/download")
          (file-name "rust-phf-generator-0.14.0.tar.gz")
          (sha256 (base32 "003i8qw6ghkcvs6bmxdhnq1a1kmpwbciakazjsybx8fmb44jxdmf"))))
   (list "rust-phf-macros-0.13.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf_macros/0.13.1/download")
          (file-name "rust-phf-macros-0.13.1.tar.gz")
          (sha256 (base32 "1vv9h8pr7xh18sigpvq1hxc8q9nmjmv6gdpqsp65krxiahmh6bw1"))))
   (list "rust-phf-macros-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf_macros/0.14.0/download")
          (file-name "rust-phf-macros-0.14.0.tar.gz")
          (sha256 (base32 "11g0wm4xric3nf9b9czpign7svk94ik0qq6s61vd496l4v5d1a2z"))))
   (list "rust-phf-shared-0.13.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf_shared/0.13.1/download")
          (file-name "rust-phf-shared-0.13.1.tar.gz")
          (sha256 (base32 "0rpjchnswm0x5l4mz9xqfpw0j4w68sjvyqrdrv13h7lqqmmyyzz5"))))
   (list "rust-phf-shared-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/phf_shared/0.14.0/download")
          (file-name "rust-phf-shared-0.14.0.tar.gz")
          (sha256 (base32 "12dalcsaq83pfydhq81195aal0ld9vdx3swz6kk9ncfrw8kr1zf6"))))
   (list "rust-pin-project-1.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pin-project/1.1.13/download")
          (file-name "rust-pin-project-1.1.13.tar.gz")
          (sha256 (base32 "09091qp946lpmjz4yp0xil1r5v4hgc91fi19dg5csayhdqrv4ri4"))))
   (list "rust-pin-project-internal-1.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pin-project-internal/1.1.13/download")
          (file-name "rust-pin-project-internal-1.1.13.tar.gz")
          (sha256 (base32 "12rzlh07i1sdgrvzj6wgkka5bjqyvbfsl8knq6qi7g16m7q9aqy9"))))
   (list "rust-pin-project-lite-0.2.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pin-project-lite/0.2.17/download")
          (file-name "rust-pin-project-lite-0.2.17.tar.gz")
          (sha256 (base32 "1kfmwvs271si96zay4mm8887v5khw0c27jc9srw1a75ykvgj54x8"))))
   (list "rust-piper-0.2.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/piper/0.2.5/download")
          (file-name "rust-piper-0.2.5.tar.gz")
          (sha256 (base32 "1hd3j94mw5dwc457gs9ssb2r5b9iipywndf5srqx7pj38jd4fdf8"))))
   (list "rust-pipewire-0.10.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pipewire/0.10.1/download")
          (file-name "rust-pipewire-0.10.1.tar.gz")
          (sha256 (base32 "0p1dlfx7jfql21ahpbswiqrxpv75fnm4v98yizb5jng2qj211rxx"))))
   (list "rust-pipewire-sys-0.10.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pipewire-sys/0.10.1/download")
          (file-name "rust-pipewire-sys-0.10.1.tar.gz")
          (sha256 (base32 "1q1wsrfra5k3n8fkyby9hb8aa1l9kbp95011acwbkrb37vsm7rlw"))))
   (list "rust-pixman-sys-0.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pixman-sys/0.1.0/download")
          (file-name "rust-pixman-sys-0.1.0.tar.gz")
          (sha256 (base32 "1nja8kc7zs1w4lhllvsgssa0b07n4cgwb0zyvqapj7g8i4z4i851"))))
   (list "rust-pixman-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pixman/0.2.1/download")
          (file-name "rust-pixman-0.2.1.tar.gz")
          (sha256 (base32 "1pqybqb7rmd58yr9xvmd8iix30znw5w71cq2wnlc16n1jva1g8nf"))))
   (list "rust-pkg-config-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pkg-config/0.3.34/download")
          (file-name "rust-pkg-config-0.3.34.tar.gz")
          (sha256 (base32 "0j05h08nzg0q8rf6lzw7nry0b7kn7x97vc9n4hwrl52fqzxn9d7n"))))
   (list "rust-plain-0.2.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/plain/0.2.3/download")
          (file-name "rust-plain-0.2.3.tar.gz")
          (sha256 (base32 "19n1xbxb4wa7w891268bzf6cbwq4qvdb86bik1z129qb0xnnnndl"))))
   (list "rust-png-0.18.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/png/0.18.1/download")
          (file-name "rust-png-0.18.1.tar.gz")
          (sha256 (base32 "0qca282xp8a6d7mikxrwji3f52mjn4vnqxz2v9iz5adj665rnxk0"))))
   (list "rust-ppv-lite86-0.2.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ppv-lite86/0.2.21/download")
          (file-name "rust-ppv-lite86-0.2.21.tar.gz")
          (sha256 (base32 "1abxx6qz5qnd43br1dd9b2savpihzjza8gb4fbzdql1gxp2f7sl5"))))
   (list "rust-potential-utf-0.1.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/potential_utf/0.1.6/download")
          (file-name "rust-potential-utf-0.1.6.tar.gz")
          (sha256 (base32 "0qbndl2fpphq7mph41m11vaixs05xrh1s451wxlgap4fdnybjgnq"))))
   (list "rust-portable-atomic-1.15.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/portable-atomic/1.15.0/download")
          (file-name "rust-portable-atomic-1.15.0.tar.gz")
          (sha256 (base32 "11csag858ndk5w4yz17h91vy53ynh67r2903gwwdn2cnilzbdj05"))))
   (list "rust-polling-3.11.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/polling/3.11.0/download")
          (file-name "rust-polling-3.11.0.tar.gz")
          (sha256 (base32 "0622qfbxi3gb0ly2c99n3xawp878fkrd1sl83hjdhisx11cly3jx"))))
   (list "rust-pretty-assertions-1.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pretty_assertions/1.4.1/download")
          (file-name "rust-pretty-assertions-1.4.1.tar.gz")
          (sha256 (base32 "0v8iq35ca4rw3rza5is3wjxwsf88303ivys07anc5yviybi31q9s"))))
   (list "rust-proc-macro2-1.0.107.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proc-macro2/1.0.107/download")
          (file-name "rust-proc-macro2-1.0.107.tar.gz")
          (sha256 (base32 "1nb6ly8kp65f724kj73ippc7lvydss24sm2vagk6qpklpg4pwplq"))))
   (list "rust-proc-macro-crate-3.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proc-macro-crate/3.5.0/download")
          (file-name "rust-proc-macro-crate-3.5.0.tar.gz")
          (sha256 (base32 "0kv1g1d1zjwxlgcaba2qlshzyy32j03xic8rskqlcr5mnblsfyz6"))))
   (list "rust-proc-macro-error-attr-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download")
          (file-name "rust-proc-macro-error-attr-1.0.4.tar.gz")
          (sha256 (base32 "0sgq6m5jfmasmwwy8x4mjygx5l7kp8s4j60bv25ckv2j1qc41gm1"))))
   (list "rust-proc-macro-error-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download")
          (file-name "rust-proc-macro-error-1.0.4.tar.gz")
          (sha256 (base32 "1373bhxaf0pagd8zkyd03kkx6bchzf6g0dkwrwzsnal9z47lj9fs"))))
   (list "rust-profiling-procmacros-1.0.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/profiling-procmacros/1.0.18/download")
          (file-name "rust-profiling-procmacros-1.0.18.tar.gz")
          (sha256 (base32 "1jxvqff6j1z7ph3qghw2xhv18z7pf6cs6cja6fwscjwsdfis9224"))))
   (list "rust-profiling-1.0.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/profiling/1.0.18/download")
          (file-name "rust-profiling-1.0.18.tar.gz")
          (sha256 (base32 "1xdwlvxlgy99nn1dra7arzinkc8lbqljvcwpq70m7g16lda5wn9x"))))
   (list "rust-proptest-1.11.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proptest/1.11.0/download")
          (file-name "rust-proptest-1.11.0.tar.gz")
          (sha256 (base32 "0i27rr5drw4ic8hjzx6i1c6q8s7kmsgpfmzy4m80ys2c6k1gqiab"))))
   (list "rust-proptest-derive-0.8.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proptest-derive/0.8.0/download")
          (file-name "rust-proptest-derive-0.8.0.tar.gz")
          (sha256 (base32 "16sl8waqx20flr49aj24dh4rfbzqkcpzj6rfm7xxmpb432l28yf5"))))
   (list "rust-quick-error-1.2.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/quick-error/1.2.3/download")
          (file-name "rust-quick-error-1.2.3.tar.gz")
          (sha256 (base32 "1q6za3v78hsspisc197bg3g7rpc989qycy8ypr8ap8igv10ikl51"))))
   (list "rust-quote-1.0.47.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/quote/1.0.47/download")
          (file-name "rust-quote-1.0.47.tar.gz")
          (sha256 (base32 "00ch0yyzvv6s671ik0kcsbw8nigdaj2g3fr61kcahwx48aqlvgqz"))))
   (list "rust-rand-0.10.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand/0.10.2/download")
          (file-name "rust-rand-0.10.2.tar.gz")
          (sha256 (base32 "105yqkdzqbgggd3r1yjm9jg0zvibfdsmxylvxxkmblwc0lxgmxf7"))))
   (list "rust-quick-xml-0.41.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/quick-xml/0.41.0/download")
          (file-name "rust-quick-xml-0.41.0.tar.gz")
          (sha256 (base32 "1h9y8zry34r3mxfd5vqfj50vvvzvri4kzbx5d657jkqjalg4aq76"))))
   (list "rust-rand-0.9.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand/0.9.5/download")
          (file-name "rust-rand-0.9.5.tar.gz")
          (sha256 (base32 "0hbvllk8g28mqjld6hqmckk69w296qpzg95whm3didsyg46ivvxr"))))
   (list "rust-rand-chacha-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_chacha/0.9.0/download")
          (file-name "rust-rand-chacha-0.9.0.tar.gz")
          (sha256 (base32 "1jr5ygix7r60pz0s1cv3ms1f6pd1i9pcdmnxzzhjc3zn3mgjn0nk"))))
   (list "rust-rand-core-0.9.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_core/0.9.5/download")
          (file-name "rust-rand-core-0.9.5.tar.gz")
          (sha256 (base32 "0g6qc5r3f0hdmz9b11nripyp9qqrzb0xqk9piip8w8qlvqkcibvn"))))
   (list "rust-rand-core-0.10.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_core/0.10.1/download")
          (file-name "rust-rand-core-0.10.1.tar.gz")
          (sha256 (base32 "0s9wiacxrr100icl7i41308gcj85nlcclrc5jx1jd6p10dhigf33"))))
   (list "rust-rand-xorshift-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_xorshift/0.4.0/download")
          (file-name "rust-rand-xorshift-0.4.0.tar.gz")
          (sha256 (base32 "0njsn25pis742gb6b89cpq7jp48v9n23a9fvks10yczwks8n4fai"))))
   (list "rust-raw-window-handle-0.6.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/raw-window-handle/0.6.2/download")
          (file-name "rust-raw-window-handle-0.6.2.tar.gz")
          (sha256 (base32 "0ff5c648hncwx7hm2a8fqgqlbvbl4xawb6v3xxv9wkpjyrr5arr0"))))
   (list "rust-rayon-1.12.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rayon/1.12.0/download")
          (file-name "rust-rayon-1.12.0.tar.gz")
          (sha256 (base32 "0vcj63xgnk72c30vdrak7dhl53snnaqv9x2faf1d94hzg1kb2fgv"))))
   (list "rust-rayon-core-1.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rayon-core/1.13.0/download")
          (file-name "rust-rayon-core-1.13.0.tar.gz")
          (sha256 (base32 "14dbr0sq83a6lf1rfjq5xdpk5r6zgzvmzs5j6110vlv2007qpq92"))))
   (list "rust-redox-syscall-0.9.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/redox_syscall/0.9.4/download")
          (file-name "rust-redox-syscall-0.9.4.tar.gz")
          (sha256 (base32 "03p257wq9i52i5h5ns9v0xx03fycgcq17bdcwwqzmil7ka9p0ybk"))))
   (list "rust-redox-event-0.4.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/redox_event/0.4.8/download")
          (file-name "rust-redox-event-0.4.8.tar.gz")
          (sha256 (base32 "058v00q7mfnmd60wf5xb0gmx2rwhgqbqvsia6ncm8bvd7mc8s0f5"))))
   (list "rust-redox-users-0.5.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/redox_users/0.5.2/download")
          (file-name "rust-redox-users-0.5.2.tar.gz")
          (sha256 (base32 "1b17q7gf7w8b1vvl53bxna24xl983yn7bd00gfbii74bcg30irm4"))))
   (list "rust-ref-cast-impl-1.0.27.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ref-cast-impl/1.0.27/download")
          (file-name "rust-ref-cast-impl-1.0.27.tar.gz")
          (sha256 (base32 "0fnzgkvddgl9xs3884x5ypi9rd0dgc1p5vd1k4b74lw49ybdiv4j"))))
   (list "rust-ref-cast-1.0.27.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ref-cast/1.0.27/download")
          (file-name "rust-ref-cast-1.0.27.tar.gz")
          (sha256 (base32 "1hv5sf0j7b65gz2g57c3wp0fzr5r3807dywf6fap455lwjs0yi3y"))))
   (list "rust-r-efi-5.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/r-efi/5.3.0/download")
          (file-name "rust-r-efi-5.3.0.tar.gz")
          (sha256 (base32 "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))))
   (list "rust-r-efi-6.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/r-efi/6.0.0/download")
          (file-name "rust-r-efi-6.0.0.tar.gz")
          (sha256 (base32 "1gyrl2k5fyzj9k7kchg2n296z5881lg7070msabid09asp3wkp7q"))))
   (list "rust-regex-1.13.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/regex/1.13.1/download")
          (file-name "rust-regex-1.13.1.tar.gz")
          (sha256 (base32 "1391a0a4100ik8cp7l577p3ip3haqq03rd9c5vdr7vcfdixj687h"))))
   (list "rust-regex-syntax-0.8.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/regex-syntax/0.8.11/download")
          (file-name "rust-regex-syntax-0.8.11.tar.gz")
          (sha256 (base32 "1m25h5q2wp976fb9gc3dsc9l99svcvd5cri8lncb51c46ydgzxnn"))))
   (list "rust-regex-automata-0.4.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/regex-automata/0.4.18/download")
          (file-name "rust-regex-automata-0.4.18.tar.gz")
          (sha256 (base32 "1cml0rm0ssqfkibh9nh3gy4b6hbsbicj1rihpwf2a4v4nawm71dd"))))
   (list "rust-reis-0.7.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/reis/0.7.1/download")
          (file-name "rust-reis-0.7.1.tar.gz")
          (sha256 (base32 "0pzqwqzbjpyjmzhwnwv8g7m7hqdrgfc12kvj41x0chls9337x5jb"))))
   (list "rust-rustc-version-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustc_version/0.4.1/download")
          (file-name "rust-rustc-version-0.4.1.tar.gz")
          (sha256 (base32 "14lvdsmr5si5qbqzrajgb6vfn69k0sfygrvfvr2mps26xwi3mjyg"))))
   (list "rust-rustc-hash-2.1.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustc-hash/2.1.3/download")
          (file-name "rust-rustc-hash-2.1.3.tar.gz")
          (sha256 (base32 "0bbla578m87qmf3yr55q49l97gxn7z0ha1dwqlnvwwc58ad7y7kb"))))
   (list "rust-rustix-0.38.44.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustix/0.38.44/download")
          (file-name "rust-rustix-0.38.44.tar.gz")
          (sha256 (base32 "0m61v0h15lf5rrnbjhcb9306bgqrhskrqv7i1n0939dsw8dbrdgx"))))
   (list "rust-rustix-1.1.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustix/1.1.4/download")
          (file-name "rust-rustix-1.1.4.tar.gz")
          (sha256 (base32 "14511f9yjqh0ix07xjrjpllah3325774gfwi9zpq72sip5jlbzmn"))))
   (list "rust-rustversion-1.0.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustversion/1.0.23/download")
          (file-name "rust-rustversion-1.0.23.tar.gz")
          (sha256 (base32 "07z2a843fs80fawwflj9jwn49k9b0bd0dhhbvy0ar69vaxd72m6g"))))
   (list "rust-rusty-fork-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rusty-fork/0.3.1/download")
          (file-name "rust-rusty-fork-0.3.1.tar.gz")
          (sha256 (base32 "1qkf9rvz2irb1wlbkrhrns8n9hnax48z1lgql5nqyr2fyagzfsyc"))))
   (list "rust-same-file-1.0.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/same-file/1.0.6/download")
          (file-name "rust-same-file-1.0.6.tar.gz")
          (sha256 (base32 "00h5j1w87dmhnvbv9l8bic3y7xxsnjmssvifw2ayvgx9mb1ivz4k"))))
   (list "rust-schemars-derive-1.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/schemars_derive/1.2.2/download")
          (file-name "rust-schemars-derive-1.2.2.tar.gz")
          (sha256 (base32 "1fp2wkdk32nv66swy7k7pz7sxygn634snlppih5jzbs6ddqng36r"))))
   (list "rust-schemars-1.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/schemars/1.2.2/download")
          (file-name "rust-schemars-1.2.2.tar.gz")
          (sha256 (base32 "0jng632s64njf9vghr3i1l4m15h4y85m5vhg7vkwdkdnjg978wk8"))))
   (list "rust-scoped-tls-1.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/scoped-tls/1.0.1/download")
          (file-name "rust-scoped-tls-1.0.1.tar.gz")
          (sha256 (base32 "15524h04mafihcvfpgxd8f4bgc3k95aclz8grjkg9a0rxcvn9kz1"))))
   (list "rust-sd-notify-0.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/sd-notify/0.5.0/download")
          (file-name "rust-sd-notify-0.5.0.tar.gz")
          (sha256 (base32 "0xpy528vqfasq389pwg9z86w0m0bfsfhz8r7vpqzljv9kqszfkiy"))))
   (list "rust-serde-core-1.0.229.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_core/1.0.229/download")
          (file-name "rust-serde-core-1.0.229.tar.gz")
          (sha256 (base32 "0j1ajiha76h3nmd976il9li6975k121xa7jb39ws8n0yqp4s5p37"))))
   (list "rust-semver-1.0.28.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/semver/1.0.28/download")
          (file-name "rust-semver-1.0.28.tar.gz")
          (sha256 (base32 "1kaimrpy876bcgi8bfj0qqfxk77zm9iz2zhn1hp9hj685z854y4a"))))
   (list "rust-serde-1.0.229.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde/1.0.229/download")
          (file-name "rust-serde-1.0.229.tar.gz")
          (sha256 (base32 "1fp04fq4a79bpm61xz1zy0pbz4kpc7d771zii1k3inmszq55jj21"))))
   (list "rust-serde-derive-internals-0.30.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_derive_internals/0.30.0/download")
          (file-name "rust-serde-derive-internals-0.30.0.tar.gz")
          (sha256 (base32 "1gd9n45na7n79nr54ghfl79rygkbzw2ybk3wyr6nlp83rry16lpq"))))
   (list "rust-serde-derive-1.0.229.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_derive/1.0.229/download")
          (file-name "rust-serde-derive-1.0.229.tar.gz")
          (sha256 (base32 "0j4k63i7h1bikxwz2c89ig0hrwbnl9mz1czn85xx99x5cc9dg9g7"))))
   (list "rust-serde-json-1.0.151.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_json/1.0.151/download")
          (file-name "rust-serde-json-1.0.151.tar.gz")
          (sha256 (base32 "051zww7lvpw147vvwss1ng6w587qyrkzg75fvj08q2dfrmgbahf8"))))
   (list "rust-serde-repr-0.1.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_repr/0.1.21/download")
          (file-name "rust-serde-repr-0.1.21.tar.gz")
          (sha256 (base32 "01l987ghc17h1y9cf9xbzmcs77575mbrjf4ca2h70g15vqlicfwd"))))
   (list "rust-serde-spanned-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_spanned/1.1.1/download")
          (file-name "rust-serde-spanned-1.1.1.tar.gz")
          (sha256 (base32 "09jzk7i6wihn3d8i3wi4j4n98ghi93c3b8m8k64nxq0ijn3vaqk6"))))
   (list "rust-sha2-0.10.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/sha2/0.10.9/download")
          (file-name "rust-sha2-0.10.9.tar.gz")
          (sha256 (base32 "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))))
   (list "rust-sharded-slab-0.1.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/sharded-slab/0.1.7/download")
          (file-name "rust-sharded-slab-0.1.7.tar.gz")
          (sha256 (base32 "1xipjr4nqsgw34k7a2cgj9zaasl2ds6jwn89886kww93d32a637l"))))
   (list "rust-signal-hook-registry-1.4.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/signal-hook-registry/1.4.8/download")
          (file-name "rust-signal-hook-registry-1.4.8.tar.gz")
          (sha256 (base32 "06vc7pmnki6lmxar3z31gkyg9cw7py5x9g7px70gy2hil75nkny4"))))
   (list "rust-shlex-1.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/shlex/1.3.0/download")
          (file-name "rust-shlex-1.3.0.tar.gz")
          (sha256 (base32 "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))))
   (list "rust-shlex-2.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/shlex/2.0.1/download")
          (file-name "rust-shlex-2.0.1.tar.gz")
          (sha256 (base32 "1fjsll1cd7d2bcpdij9kd6w62rpbc7qqzvydvs021vsmr1cxvypq"))))
   (list "rust-simd-adler32-0.3.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simd-adler32/0.3.10/download")
          (file-name "rust-simd-adler32-0.3.10.tar.gz")
          (sha256 (base32 "1sny4y2qa5mwyxx5x59ln2p02vsdh92004njlslnx98imjc9489s"))))
   (list "rust-simd-cesu8-1.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simd_cesu8/1.2.0/download")
          (file-name "rust-simd-cesu8-1.2.0.tar.gz")
          (sha256 (base32 "0865mv3nmd35f1dccjcfj7dncjmmvvdij3j61z4131mz38jiw0qi"))))
   (list "rust-similar-2.7.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/similar/2.7.0/download")
          (file-name "rust-similar-2.7.0.tar.gz")
          (sha256 (base32 "1aidids7ymfr96s70232s6962v5g9l4zwhkvcjp4c5hlb6b5vfxv"))))
   (list "rust-simdutf8-0.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simdutf8/0.1.5/download")
          (file-name "rust-simdutf8-0.1.5.tar.gz")
          (sha256 (base32 "0vmpf7xaa0dnaikib5jlx6y4dxd3hxqz6l830qb079g7wcsgxag3"))))
   (list "rust-slab-0.4.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/slab/0.4.12/download")
          (file-name "rust-slab-0.4.12.tar.gz")
          (sha256 (base32 "1xcwik6s6zbd3lf51kkrcicdq2j4c1fw0yjdai2apy9467i0sy8c"))))
   (list "rust-smallvec-1.16.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smallvec/1.16.0/download")
          (file-name "rust-smallvec-1.16.0.tar.gz")
          (sha256 (base32 "03qz1zl899bzxzh8zr7lmi5hgcgla9zs78sacmawaqd81bsl5gmr"))))
   (list "rust-siphasher-1.0.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/siphasher/1.0.3/download")
          (file-name "rust-siphasher-1.0.3.tar.gz")
          (sha256 (base32 "0jg6l9xyzca5vy4h6gf8r6p4kk84g98fk95pzig1kq6cr4z8grcf"))))
   (list "rust-smawk-0.3.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smawk/0.3.3/download")
          (file-name "rust-smawk-0.3.3.tar.gz")
          (sha256 (base32 "006id1vx7vv7vdnmj0ss5dla34ggymlavv9b5wb4vfws947zpqp8"))))
   (list "rust-smithay-client-toolkit-0.21.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smithay-client-toolkit/0.21.1/download")
          (file-name "rust-smithay-client-toolkit-0.21.1.tar.gz")
          (sha256 (base32 "003zc6547msmwh729lkpm6acjw60rax42qamz4svbp0g9ghrxp3l"))))
   (list "rust-stable-deref-trait-1.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/stable_deref_trait/1.2.1/download")
          (file-name "rust-stable-deref-trait-1.2.1.tar.gz")
          (sha256 (base32 "15h5h73ppqyhdhx6ywxfj88azmrpml9gl6zp3pwy2malqa6vxqkc"))))
   (list "rust-smol-str-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smol_str/0.3.2/download")
          (file-name "rust-smol-str-0.3.2.tar.gz")
          (sha256 (base32 "039mj6lc1vkljj17ndlzzkak8kvlmw8ppi6yjdxsh433snfbhxln"))))
   (list "rust-static-assertions-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/static_assertions/1.1.0/download")
          (file-name "rust-static-assertions-1.1.0.tar.gz")
          (sha256 (base32 "0gsl6xmw10gvn3zs1rv99laj5ig7ylffnh71f9l34js4nr4r7sx2"))))
   (list "rust-strsim-0.11.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/strsim/0.11.1/download")
          (file-name "rust-strsim-0.11.1.tar.gz")
          (sha256 (base32 "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))))
   (list "rust-supports-color-2.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/supports-color/2.1.0/download")
          (file-name "rust-supports-color-2.1.0.tar.gz")
          (sha256 (base32 "12csf7chawxinaapm9rh718nha9hggk6ra86fdaw9hxdagg8qffn"))))
   (list "rust-supports-hyperlinks-2.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/supports-hyperlinks/2.1.0/download")
          (file-name "rust-supports-hyperlinks-2.1.0.tar.gz")
          (sha256 (base32 "0g93nh1db3f9lyd0ry35bqjrxkg6sbysn36x9hgd9m5h5rlk2hpq"))))
   (list "rust-supports-unicode-2.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/supports-unicode/2.1.0/download")
          (file-name "rust-supports-unicode-2.1.0.tar.gz")
          (sha256 (base32 "0yp703pvpzpmaw9mpncvwf0iqis4xmhs569ii1g20jhqvngc2l7q"))))
   (list "rust-syn-1.0.109.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/syn/1.0.109/download")
          (file-name "rust-syn-1.0.109.tar.gz")
          (sha256 (base32 "0ds2if4600bd59wsv7jjgfkayfzy3hnazs394kz6zdkmna8l3dkj"))))
   (list "rust-syn-3.0.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/syn/3.0.5/download")
          (file-name "rust-syn-3.0.5.tar.gz")
          (sha256 (base32 "1yc9vbm1wqs68fyj5f1f3f9isyh6i7wpxccvfrgpfnzn200jxpqj"))))
   (list "rust-syn-2.0.119.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/syn/2.0.119/download")
          (file-name "rust-syn-2.0.119.tar.gz")
          (sha256 (base32 "15vjy620l91a3q4n4f4gzhnflmdr6pnm38v2m6cpk86i8av32a47"))))
   (list "rust-synstructure-0.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/synstructure/0.13.2/download")
          (file-name "rust-synstructure-0.13.2.tar.gz")
          (sha256 (base32 "1lh9lx3r3jb18f8sbj29am5hm9jymvbwh6jb1izsnnxgvgrp12kj"))))
   (list "rust-system-deps-7.0.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/system-deps/7.0.8/download")
          (file-name "rust-system-deps-7.0.8.tar.gz")
          (sha256 (base32 "1rwnfw9dm6ck65a7lfjfpn2c91gwj88brz2i09z3fdbknvz3asir"))))
   (list "rust-target-lexicon-0.13.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/target-lexicon/0.13.5/download")
          (file-name "rust-target-lexicon-0.13.5.tar.gz")
          (sha256 (base32 "1jm6lmf9hsn7ri2d6v9gg6fy24lylhskh6pbxh71f82wdxd97dmd"))))
   (list "rust-tempfile-3.27.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tempfile/3.27.0/download")
          (file-name "rust-tempfile-3.27.0.tar.gz")
          (sha256 (base32 "1gblhnyfjsbg9wjg194n89wrzah7jy3yzgnyzhp56f3v9jd7wj9j"))))
   (list "rust-textwrap-0.15.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/textwrap/0.15.2/download")
          (file-name "rust-textwrap-0.15.2.tar.gz")
          (sha256 (base32 "0galmidi6gpn308b1kv3r4qbb48j2926lcj0idwhdhlylhjybcxp"))))
   (list "rust-terminal-size-0.1.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/terminal_size/0.1.17/download")
          (file-name "rust-terminal-size-0.1.17.tar.gz")
          (sha256 (base32 "1pq60ng1a7fjp597ifk1cqlz8fv9raz9xihddld1m1pfdia1lg33"))))
   (list "rust-thiserror-1.0.69.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror/1.0.69/download")
          (file-name "rust-thiserror-1.0.69.tar.gz")
          (sha256 (base32 "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))))
   (list "rust-thiserror-2.0.20.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror/2.0.20/download")
          (file-name "rust-thiserror-2.0.20.tar.gz")
          (sha256 (base32 "0kxs6p295jffxhzaxpxv1dwaaf5iqlm6sx8h0djp6ancbxgj71pc"))))
   (list "rust-thiserror-impl-2.0.20.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror-impl/2.0.20/download")
          (file-name "rust-thiserror-impl-2.0.20.tar.gz")
          (sha256 (base32 "1bwjc94gi0xn5jz26h1a8bjj1wdkvvr6jifamyc4mp9n28zcs15w"))))
   (list "rust-thiserror-impl-1.0.69.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror-impl/1.0.69/download")
          (file-name "rust-thiserror-impl-1.0.69.tar.gz")
          (sha256 (base32 "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))))
   (list "rust-thread-local-1.1.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thread_local/1.1.10/download")
          (file-name "rust-thread-local-1.1.10.tar.gz")
          (sha256 (base32 "0w20g2pfdcp8pz3gds0bzksv6mxk802szca8qlr3701jdm69rn8s"))))
   (list "rust-tinystr-0.8.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tinystr/0.8.4/download")
          (file-name "rust-tinystr-0.8.4.tar.gz")
          (sha256 (base32 "0hzncw8rgk4syla79qscfml46jm7ll1zdp7kdacc42cj8n8prqmi"))))
   (list "rust-toml-1.1.6+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml/1.1.6+spec-1.1.0/download")
          (file-name "rust-toml-1.1.6+spec-1.1.0.tar.gz")
          (sha256 (base32 "0sj0g89pyrkm9g5zaaqsdlclr98xf1chvi8jv9qsn4897xa041lj"))))
   (list "rust-toml-datetime-1.1.1+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_datetime/1.1.1+spec-1.1.0/download")
          (file-name "rust-toml-datetime-1.1.1+spec-1.1.0.tar.gz")
          (sha256 (base32 "1mws2mkkf46l7inn77azhm0vdwxngv9vsbhbl0ah33p2c9gzcr9i"))))
   (list "rust-toml-parser-1.1.3+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_parser/1.1.3+spec-1.1.0/download")
          (file-name "rust-toml-parser-1.1.3+spec-1.1.0.tar.gz")
          (sha256 (base32 "0mjdvihdkmjd4ykh574xgii71hpxw7ns7h4n4bisqpxrz4faqf0x"))))
   (list "rust-toml-edit-0.25.15+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_edit/0.25.15+spec-1.1.0/download")
          (file-name "rust-toml-edit-0.25.15+spec-1.1.0.tar.gz")
          (sha256 (base32 "0556lgzcvgfy16b8sxskr391s6cbfwnb0r4h5i4k6qw5lnaflh0k"))))
   (list "rust-toml-writer-1.1.2+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_writer/1.1.2+spec-1.1.0/download")
          (file-name "rust-toml-writer-1.1.2+spec-1.1.0.tar.gz")
          (sha256 (base32 "1lk6pqf9mac3v1x6282n6a66qx5b18c8f4a23bsd0nk658x3amkx"))))
   (list "rust-tracing-core-0.1.36.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-core/0.1.36/download")
          (file-name "rust-tracing-core-0.1.36.tar.gz")
          (sha256 (base32 "16mpbz6p8vd6j7sf925k9k8wzvm9vdfsjbynbmaxxyq6v7wwm5yv"))))
   (list "rust-tracing-log-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-log/0.2.0/download")
          (file-name "rust-tracing-log-0.2.0.tar.gz")
          (sha256 (base32 "1hs77z026k730ij1a9dhahzrl0s073gfa2hm5p0fbl0b80gmz1gf"))))
   (list "rust-tracing-attributes-0.1.31.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-attributes/0.1.31/download")
          (file-name "rust-tracing-attributes-0.1.31.tar.gz")
          (sha256 (base32 "1np8d77shfvz0n7camx2bsf1qw0zg331lra0hxb4cdwnxjjwz43l"))))
   (list "rust-tracing-0.1.44.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing/0.1.44/download")
          (file-name "rust-tracing-0.1.44.tar.gz")
          (sha256 (base32 "006ilqkg1lmfdh3xhg3z762izfwmxcvz0w7m4qx2qajbz9i1drv3"))))
   (list "rust-tracing-subscriber-0.3.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-subscriber/0.3.23/download")
          (file-name "rust-tracing-subscriber-0.3.23.tar.gz")
          (sha256 (base32 "06fkr0qhggvrs861d7f74pn3i3a10h5jsp4n70jj9ys5b675fzyb"))))
   (list "rust-tracy-client-sys-0.29.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracy-client-sys/0.29.0/download")
          (file-name "rust-tracy-client-sys-0.29.0.tar.gz")
          (sha256 (base32 "0y9k8c5blf41yrgl15sm8ypr21cg676hnbis85l4q8ckn1kz29xb"))))
   (list "rust-tracy-client-0.18.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracy-client/0.18.5/download")
          (file-name "rust-tracy-client-0.18.5.tar.gz")
          (sha256 (base32 "1q4w2qrhxrlhkc49j396hwk5x8bv882v0kpb0zs9djz2ycprjcb1"))))
   (list "rust-typenum-1.20.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/typenum/1.20.1/download")
          (file-name "rust-typenum-1.20.1.tar.gz")
          (sha256 (base32 "086s9ly0906kw5yw41249fba97w5zfxf03pyfwdkffvcprqfixdn"))))
   (list "rust-unarray-0.1.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unarray/0.1.4/download")
          (file-name "rust-unarray-0.1.4.tar.gz")
          (sha256 (base32 "154smf048k84prsdgh09nkm2n0w0336v84jd4zikyn6v6jrqbspa"))))
   (list "rust-udev-0.9.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/udev/0.9.3/download")
          (file-name "rust-udev-0.9.3.tar.gz")
          (sha256 (base32 "17vy1yc6ipb5m2kc2d4lx2qpj45yr7grsjzm3y2gq0a4xblkfkmg"))))
   (list "rust-uncased-0.9.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/uncased/0.9.10/download")
          (file-name "rust-uncased-0.9.10.tar.gz")
          (sha256 (base32 "15q6r6g4fszr8c2lzg9z9k9g52h8g29h24awda3d72cyw37qzf71"))))
   (list "rust-uds-windows-1.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/uds_windows/1.2.1/download")
          (file-name "rust-uds-windows-1.2.1.tar.gz")
          (sha256 (base32 "0vidqwwfgn8wyzvbxiqil787b4wyqjia50zpdbbjqx7n8wlgpxpj"))))
   (list "rust-unicode-ident-1.0.24.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-ident/1.0.24/download")
          (file-name "rust-unicode-ident-1.0.24.tar.gz")
          (sha256 (base32 "0xfs8y1g7syl2iykji8zk5hgfi5jw819f5zsrbaxmlzwsly33r76"))))
   (list "rust-unicode-linebreak-0.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-linebreak/0.1.5/download")
          (file-name "rust-unicode-linebreak-0.1.5.tar.gz")
          (sha256 (base32 "07spj2hh3daajg335m4wdav6nfkl0f6c0q72lc37blr97hych29v"))))
   (list "rust-unicode-segmentation-1.13.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-segmentation/1.13.3/download")
          (file-name "rust-unicode-segmentation-1.13.3.tar.gz")
          (sha256 (base32 "1a47zaq83p386r3baq4m018xd5q4q0grdg56i1x042dzn71x7xf6"))))
   (list "rust-unicode-width-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-width/0.2.2/download")
          (file-name "rust-unicode-width-0.2.2.tar.gz")
          (sha256 (base32 "0m7jjzlcccw716dy9423xxh0clys8pfpllc5smvfxrzdf66h9b5l"))))
   (list "rust-unicode-width-0.1.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-width/0.1.14/download")
          (file-name "rust-unicode-width-0.1.14.tar.gz")
          (sha256 (base32 "1bzn2zv0gp8xxbxbhifw778a7fc93pa6a1kj24jgg9msj07f7mkx"))))
   (list "rust-utf8-iter-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/utf8_iter/1.0.4/download")
          (file-name "rust-utf8-iter-1.0.4.tar.gz")
          (sha256 (base32 "1gmna9flnj8dbyd8ba17zigrp9c4c3zclngf5lnb5yvz1ri41hdn"))))
   (list "rust-url-2.5.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/url/2.5.8/download")
          (file-name "rust-url-2.5.8.tar.gz")
          (sha256 (base32 "1v8f7nx3hpr1qh76if0a04sj08k86amsq4h8cvpw6wvk76jahrzz"))))
   (list "rust-utf8parse-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/utf8parse/0.2.2/download")
          (file-name "rust-utf8parse-0.2.2.tar.gz")
          (sha256 (base32 "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))))
   (list "rust-uuid-1.26.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/uuid/1.26.1/download")
          (file-name "rust-uuid-1.26.1.tar.gz")
          (sha256 (base32 "1kl5nb7r3gpmkc43d6nbayvzqhcp2grczk6c7bxv80b6x70xmxif"))))
   (list "rust-version-check-0.9.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/version_check/0.9.5/download")
          (file-name "rust-version-check-0.9.5.tar.gz")
          (sha256 (base32 "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))))
   (list "rust-valuable-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/valuable/0.1.1/download")
          (file-name "rust-valuable-0.1.1.tar.gz")
          (sha256 (base32 "0r9srp55v7g27s5bg7a2m095fzckrcdca5maih6dy9bay6fflwxs"))))
   (list "rust-wait-timeout-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wait-timeout/0.2.1/download")
          (file-name "rust-wait-timeout-0.2.1.tar.gz")
          (sha256 (base32 "04azqv9mnfxgvnc8j2wp362xraybakh2dy1nj22gj51rdl93pb09"))))
   (list "rust-walkdir-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/walkdir/2.5.0/download")
          (file-name "rust-walkdir-2.5.0.tar.gz")
          (sha256 (base32 "0jsy7a710qv8gld5957ybrnc07gavppp963gs32xk4ag8130jy99"))))
   (list "rust-version-compare-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/version-compare/0.2.1/download")
          (file-name "rust-version-compare-0.2.1.tar.gz")
          (sha256 (base32 "03nziqxwnxlizl42cwsx33vi5xd2cf2jnszhh9rzay7g6xl8bhh3"))))
   (list "rust-wasi-0.11.1+wasi-snapshot-preview1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasi/0.11.1+wasi-snapshot-preview1/download")
          (file-name "rust-wasi-0.11.1+wasi-snapshot-preview1.tar.gz")
          (sha256 (base32 "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))))
   (list "rust-wasm-bindgen-futures-0.4.78.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-futures/0.4.78/download")
          (file-name "rust-wasm-bindgen-futures-0.4.78.tar.gz")
          (sha256 (base32 "0a6r1q1v2qvi3ypmy0nva3il422iyml1f61i897wbxfdsb9wbx3f"))))
   (list "rust-wasm-bindgen-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen/0.2.128/download")
          (file-name "rust-wasm-bindgen-0.2.128.tar.gz")
          (sha256 (base32 "1gsi4ggm03dqr3j9bcc1sbxzmkw6ykm3cqx4g8xmw31v7niqgjxf"))))
   (list "rust-wasip2-1.0.4+wasi-0.2.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasip2/1.0.4+wasi-0.2.12/download")
          (file-name "rust-wasip2-1.0.4+wasi-0.2.12.tar.gz")
          (sha256 (base32 "11wl7lqwq4pbmlmzr6n7bwz0hzy1z6sxc4554bkmrr86w4vznzmn"))))
   (list "rust-wasm-bindgen-macro-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.128/download")
          (file-name "rust-wasm-bindgen-macro-0.2.128.tar.gz")
          (sha256 (base32 "1vdrjrb7yqh8p0r0yr93rlaq9iq05hy1wl9kbsjv7a61wc8xb456"))))
   (list "rust-wayland-backend-0.3.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-backend/0.3.17/download")
          (file-name "rust-wayland-backend-0.3.17.tar.gz")
          (sha256 (base32 "0y50cw56f09cdcsinbbl94naz91xf7iqaj87s4f7py6zmm71pa9q"))))
   (list "rust-wasm-bindgen-macro-support-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.128/download")
          (file-name "rust-wasm-bindgen-macro-support-0.2.128.tar.gz")
          (sha256 (base32 "12p4jm9dr88h1j5sglycizvvxvr05pgmz7aa2v9g47h7y23lh7j1"))))
   (list "rust-wasm-bindgen-shared-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.128/download")
          (file-name "rust-wasm-bindgen-shared-0.2.128.tar.gz")
          (sha256 (base32 "0ghh8hqx038h9c9zj1rlmzlv2k2shh917q756dn054hcipbir541"))))
   (list "rust-wayland-client-0.31.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-client/0.31.15/download")
          (file-name "rust-wayland-client-0.31.15.tar.gz")
          (sha256 (base32 "0ww0d0r6rn2h0sn8ma1f7zvxj40l6930p07j044nvmqshq7nmhz3"))))
   (list "rust-wayland-csd-frame-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-csd-frame/0.3.0/download")
          (file-name "rust-wayland-csd-frame-0.3.0.tar.gz")
          (sha256 (base32 "0zjcmcqprfzx57hlm741n89ssp4sha5yh5cnmbk2agflvclm0p32"))))
   (list "rust-wayland-cursor-0.31.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-cursor/0.31.14/download")
          (file-name "rust-wayland-cursor-0.31.14.tar.gz")
          (sha256 (base32 "0kdk7xwj465idk54jf1f24024gdp63wyagca68a176xyh23x2lja"))))
   (list "rust-wayland-egl-0.32.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-egl/0.32.11/download")
          (file-name "rust-wayland-egl-0.32.11.tar.gz")
          (sha256 (base32 "0lalq3dzd1x7j7v2dsf9zmwp1m6sy22gyf1gasvxjnwyqjvvv5wv"))))
   (list "rust-wayland-protocols-0.32.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols/0.32.13/download")
          (file-name "rust-wayland-protocols-0.32.13.tar.gz")
          (sha256 (base32 "1dn4injzx1lnmacnhl3q60m743lvshxmmy0aabb2xaixvq9wil13"))))
   (list "rust-wayland-protocols-misc-0.3.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-misc/0.3.12/download")
          (file-name "rust-wayland-protocols-misc-0.3.12.tar.gz")
          (sha256 (base32 "1j19dg8h98s153rj2fvbqkghjicdfgjjkr6nvaw0jgpjkrcng5bf"))))
   (list "rust-wayland-protocols-experimental-20251230.0.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-experimental/20251230.0.3/download")
          (file-name "rust-wayland-protocols-experimental-20251230.0.3.tar.gz")
          (sha256 (base32 "04yg4ny7pkla5iqdswfxvslzxakrphr916a67l4ksmcf2zkw7ili"))))
   (list "rust-wayland-protocols-plasma-0.3.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-plasma/0.3.12/download")
          (file-name "rust-wayland-protocols-plasma-0.3.12.tar.gz")
          (sha256 (base32 "14adi3xgkldbih60705gshlq2lskds5chhsn3znk271cxgqqqv9b"))))
   (list "rust-wayland-protocols-wlr-0.3.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-wlr/0.3.12/download")
          (file-name "rust-wayland-protocols-wlr-0.3.12.tar.gz")
          (sha256 (base32 "0d424vn2hj27r4gjlshm6hy8fcqysr805jkqdjbwgmrng0pya17b"))))
   (list "rust-wayland-sys-0.31.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-sys/0.31.11/download")
          (file-name "rust-wayland-sys-0.31.11.tar.gz")
          (sha256 (base32 "1gp3hlkxx13i55lyyi794vnw9a780z3skx0xhj71zr69xwzv5snq"))))
   (list "rust-wayland-scanner-0.31.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-scanner/0.31.11/download")
          (file-name "rust-wayland-scanner-0.31.11.tar.gz")
          (sha256 (base32 "1h0al3271l2w124sxlh77s1kmjg0z24ns2mk1vbnfars3d3313ik"))))
   (list "rust-wayland-server-0.31.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-server/0.31.14/download")
          (file-name "rust-wayland-server-0.31.14.tar.gz")
          (sha256 (base32 "0xad6xz36fyxz5s0lwsj6shdzwsv8pp53pkp75bklwhgpqlrrphd"))))
   (list "rust-web-time-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/web-time/1.1.0/download")
          (file-name "rust-web-time-1.1.0.tar.gz")
          (sha256 (base32 "1fx05yqx83dhx628wb70fyy10yjfq1jpl20qfqhdkymi13rq0ras"))))
   (list "rust-web-sys-0.3.105.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/web-sys/0.3.105/download")
          (file-name "rust-web-sys-0.3.105.tar.gz")
          (sha256 (base32 "1y57whpj5ncrl0cljmfsj5m31jqm66ylad68317yq03g0d5drgcz"))))
   (list "rust-winapi-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi/0.3.9/download")
          (file-name "rust-winapi-0.3.9.tar.gz")
          (sha256 (base32 "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw"))))
   (list "rust-winapi-util-0.1.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi-util/0.1.11/download")
          (file-name "rust-winapi-util-0.1.11.tar.gz")
          (sha256 (base32 "08hdl7mkll7pz8whg869h58c1r9y7in0w0pk8fm24qc77k0b39y2"))))
   (list "rust-winapi-i686-pc-windows-gnu-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download")
          (file-name "rust-winapi-i686-pc-windows-gnu-0.4.0.tar.gz")
          (sha256 (base32 "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc"))))
   (list "rust-windows-aarch64-msvc-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.48.5/download")
          (file-name "rust-windows-aarch64-msvc-0.48.5.tar.gz")
          (sha256 (base32 "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))))
   (list "rust-winapi-x86-64-pc-windows-gnu-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download")
          (file-name "rust-winapi-x86-64-pc-windows-gnu-0.4.0.tar.gz")
          (sha256 (base32 "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki"))))
   (list "rust-windows-aarch64-gnullvm-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.48.5/download")
          (file-name "rust-windows-aarch64-gnullvm-0.48.5.tar.gz")
          (sha256 (base32 "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))))
   (list "rust-windows-aarch64-gnullvm-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.52.6/download")
          (file-name "rust-windows-aarch64-gnullvm-0.52.6.tar.gz")
          (sha256 (base32 "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))))
   (list "rust-windows-aarch64-msvc-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.52.6/download")
          (file-name "rust-windows-aarch64-msvc-0.52.6.tar.gz")
          (sha256 (base32 "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))))
   (list "rust-windows-i686-gnu-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_gnu/0.48.5/download")
          (file-name "rust-windows-i686-gnu-0.48.5.tar.gz")
          (sha256 (base32 "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))))
   (list "rust-windows-i686-gnu-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_gnu/0.52.6/download")
          (file-name "rust-windows-i686-gnu-0.52.6.tar.gz")
          (sha256 (base32 "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))))
   (list "rust-windows-i686-gnullvm-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_gnullvm/0.52.6/download")
          (file-name "rust-windows-i686-gnullvm-0.52.6.tar.gz")
          (sha256 (base32 "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))))
   (list "rust-windows-i686-msvc-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_msvc/0.52.6/download")
          (file-name "rust-windows-i686-msvc-0.52.6.tar.gz")
          (sha256 (base32 "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))))
   (list "rust-windows-result-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-result/0.4.1/download")
          (file-name "rust-windows-result-0.4.1.tar.gz")
          (sha256 (base32 "1d9yhmrmmfqh56zlj751s5wfm9a2aa7az9rd7nn5027nxa4zm0bp"))))
   (list "rust-windows-i686-msvc-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_msvc/0.48.5/download")
          (file-name "rust-windows-i686-msvc-0.48.5.tar.gz")
          (sha256 (base32 "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))))
   (list "rust-windows-link-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-link/0.2.1/download")
          (file-name "rust-windows-link-0.2.1.tar.gz")
          (sha256 (base32 "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))))
   (list "rust-windows-sys-0.48.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-sys/0.48.0/download")
          (file-name "rust-windows-sys-0.48.0.tar.gz")
          (sha256 (base32 "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))))
   (list "rust-windows-sys-0.59.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-sys/0.59.0/download")
          (file-name "rust-windows-sys-0.59.0.tar.gz")
          (sha256 (base32 "0fw5672ziw8b3zpmnbp9pdv1famk74f1l9fcbc3zsrzdg56vqf0y"))))
   (list "rust-windows-targets-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-targets/0.48.5/download")
          (file-name "rust-windows-targets-0.48.5.tar.gz")
          (sha256 (base32 "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))))
   (list "rust-windows-sys-0.61.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-sys/0.61.2/download")
          (file-name "rust-windows-sys-0.61.2.tar.gz")
          (sha256 (base32 "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))))
   (list "rust-windows-targets-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-targets/0.52.6/download")
          (file-name "rust-windows-targets-0.52.6.tar.gz")
          (sha256 (base32 "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))))
   (list "rust-windows-x86-64-gnu-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.52.6/download")
          (file-name "rust-windows-x86-64-gnu-0.52.6.tar.gz")
          (sha256 (base32 "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))))
   (list "rust-windows-x86-64-gnu-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.48.5/download")
          (file-name "rust-windows-x86-64-gnu-0.48.5.tar.gz")
          (sha256 (base32 "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))))
   (list "rust-windows-x86-64-gnullvm-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.48.5/download")
          (file-name "rust-windows-x86-64-gnullvm-0.48.5.tar.gz")
          (sha256 (base32 "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))))
   (list "rust-windows-x86-64-msvc-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.48.5/download")
          (file-name "rust-windows-x86-64-msvc-0.48.5.tar.gz")
          (sha256 (base32 "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))))
   (list "rust-windows-x86-64-gnullvm-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.52.6/download")
          (file-name "rust-windows-x86-64-gnullvm-0.52.6.tar.gz")
          (sha256 (base32 "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))))
   (list "rust-windows-x86-64-msvc-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.52.6/download")
          (file-name "rust-windows-x86-64-msvc-0.52.6.tar.gz")
          (sha256 (base32 "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))))
   (list "rust-winit-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit/0.31.0-beta.3/download")
          (file-name "rust-winit-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "0arfj38p8qj6f3sqi04cj193d3l3am76fdxgx8sin3sg7rm1acgl"))))
   (list "rust-winit-android-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-android/0.31.0-beta.3/download")
          (file-name "rust-winit-android-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1x2s442594pxfmsgzl3dfb7y9rr2rhs56chy66wqcjan9aa0vmnm"))))
   (list "rust-winit-appkit-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-appkit/0.31.0-beta.3/download")
          (file-name "rust-winit-appkit-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "0hmbcakx5517lzxj41jy77vbqqzvcvzsc2c0ydramiksxb03wd13"))))
   (list "rust-winit-common-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-common/0.31.0-beta.3/download")
          (file-name "rust-winit-common-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "09a0w3pcvr8ckq0j7y5kzfrvphlijw4ivb8xmjm2ll043kzj4179"))))
   (list "rust-winit-core-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-core/0.31.0-beta.3/download")
          (file-name "rust-winit-core-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1yfhsd5dy9jh5w9yjv5r1cjilj70h37ia34mk5qq8lbc4c3n7bxq"))))
   (list "rust-winit-orbital-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-orbital/0.31.0-beta.3/download")
          (file-name "rust-winit-orbital-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "0l3cry4r131m0ncw5v0f2cr3z8qdd1nnkzfjbp4knalh6zl8m2i7"))))
   (list "rust-winit-uikit-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-uikit/0.31.0-beta.3/download")
          (file-name "rust-winit-uikit-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1da08x4fzbrknrk7d1fq2nahrcic18xmxlr3rxk8973kl4z5lcc3"))))
   (list "rust-winit-web-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-web/0.31.0-beta.3/download")
          (file-name "rust-winit-web-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1jgic0vcpi9z9lm8acs1xi5dc9fr73prlml0zfyrghjwz52vwfgm"))))
   (list "rust-winit-wayland-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-wayland/0.31.0-beta.3/download")
          (file-name "rust-winit-wayland-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "00zqf5dykispphvy711kf0z43qdb0qhi01ggds44a36y0vnwwr4b"))))
   (list "rust-winit-x11-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-x11/0.31.0-beta.3/download")
          (file-name "rust-winit-x11-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1alnzmzrhvxffk6jhsg1z5vh1dqcgmpiq6j9jmw4nlbyj36lcmxv"))))
   (list "rust-winit-win32-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-win32/0.31.0-beta.3/download")
          (file-name "rust-winit-win32-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1v5nl3kng4cznp52snxv4afqlgq1fjnz7jsnyr8x60fz8464iyr5"))))
   (list "rust-winnow-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winnow/1.0.4/download")
          (file-name "rust-winnow-1.0.4.tar.gz")
          (sha256 (base32 "10fzxipa7lx16172p3aca9j60hzbqgjki2f95kqksd5qywcp7f93"))))
   (list "rust-wit-bindgen-0.57.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wit-bindgen/0.57.1/download")
          (file-name "rust-wit-bindgen-0.57.1.tar.gz")
          (sha256 (base32 "0vjk2jb593ri9k1aq4iqs2si9mrw5q46wxnn78im7hm7hx799gqy"))))
   (list "rust-writeable-0.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/writeable/0.6.4/download")
          (file-name "rust-writeable-0.6.4.tar.gz")
          (sha256 (base32 "1p3r4s4wbf3dksfpj3xyrn7id5p0f7r74mj6qx6ngjfd6cm2vn1s"))))
   (list "rust-x11rb-protocol-0.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/x11rb-protocol/0.13.2/download")
          (file-name "rust-x11rb-protocol-0.13.2.tar.gz")
          (sha256 (base32 "1g81cznbyn522b0fbis0i44wh3adad2vhsz5pzf99waf3sbc4vza"))))
   (list "rust-x11-dl-2.21.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/x11-dl/2.21.0/download")
          (file-name "rust-x11-dl-2.21.0.tar.gz")
          (sha256 (base32 "0vsiq62xpcfm0kn9zjw5c9iycvccxl22jya8wnk18lyxzqj5jwrq"))))
   (list "rust-x11rb-0.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/x11rb/0.13.2/download")
          (file-name "rust-x11rb-0.13.2.tar.gz")
          (sha256 (base32 "053lvnaw9ycbl791mgwly2hw27q6vqgzrb1y5kz1as52wmdsm4wr"))))
   (list "rust-xcursor-0.3.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xcursor/0.3.11/download")
          (file-name "rust-xcursor-0.3.11.tar.gz")
          (sha256 (base32 "08wfv0wrij9rrmbgfd2l8a132gyfax05abypllpmwic6hznk6fqn"))))
   (list "rust-xkbcommon-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkbcommon/0.9.0/download")
          (file-name "rust-xkbcommon-0.9.0.tar.gz")
          (sha256 (base32 "0bd0qkapxsvblfw42x6ryhi50d63v55g40awf2alx8b0h3s79ad7"))))
   (list "rust-xkeysym-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkeysym/0.2.1/download")
          (file-name "rust-xkeysym-0.2.1.tar.gz")
          (sha256 (base32 "0mksx670cszyd7jln6s7dhkw11hdfv7blwwr3isq98k22ljh1k5r"))))
   (list "rust-xml-rs-0.8.29.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xml-rs/0.8.29/download")
          (file-name "rust-xml-rs-0.8.29.tar.gz")
          (sha256 (base32 "19y8s93sh2dx21bqlpagkixld2c66f3rln0j9k4k7zqxxnrgjl74"))))
   (list "rust-xkbcommon-dl-0.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkbcommon-dl/0.4.2/download")
          (file-name "rust-xkbcommon-dl-0.4.2.tar.gz")
          (sha256 (base32 "1iai0r3b5skd9vbr8z5b0qixiz8jblzfm778ddm8ba596a0dwffh"))))
   (list "rust-xshell-0.2.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xshell/0.2.7/download")
          (file-name "rust-xshell-0.2.7.tar.gz")
          (sha256 (base32 "0g9pd9bfp0f35rzichic55k7p1mn8mqp607y5rimhiq14g390wly"))))
   (list "rust-xshell-macros-0.2.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xshell-macros/0.2.7/download")
          (file-name "rust-xshell-macros-0.2.7.tar.gz")
          (sha256 (base32 "0irm50jxdc92r0kd6yvl5p28jsfzha59brxk7z9w3jcf7z6h1b1j"))))
   (list "rust-yansi-1.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/yansi/1.0.1/download")
          (file-name "rust-yansi-1.0.1.tar.gz")
          (sha256 (base32 "0jdh55jyv0dpd38ij4qh60zglbw9aa8wafqai6m0wa7xaxk3mrfg"))))
   (list "rust-yoke-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/yoke/0.8.3/download")
          (file-name "rust-yoke-0.8.3.tar.gz")
          (sha256 (base32 "1xgyj6c2lxj2bp891ynmhws87c6z7yyv2li1v0ss9di40hxf57vh"))))
   (list "rust-yoke-derive-0.8.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/yoke-derive/0.8.2/download")
          (file-name "rust-yoke-derive-0.8.2.tar.gz")
          (sha256 (base32 "13l5y5sz4lqm7rmyakjbh6vwgikxiql51xfff9hq2j485hk4r16y"))))
   (list "rust-zbus-5.19.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zbus/5.19.0/download")
          (file-name "rust-zbus-5.19.0.tar.gz")
          (sha256 (base32 "01sram5sgwsg3x8mghx77cjbsfa2c10mar7fnzj23d2w0xybxd2x"))))
   (list "rust-zbus-lockstep-0.5.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zbus-lockstep/0.5.2/download")
          (file-name "rust-zbus-lockstep-0.5.2.tar.gz")
          (sha256 (base32 "0qsqsk67c2vpg26rp0x0ya0cv92fs11r92kjg1sln23s442xx639"))))
   (list "rust-zbus-lockstep-macros-0.5.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zbus-lockstep-macros/0.5.2/download")
          (file-name "rust-zbus-lockstep-macros-0.5.2.tar.gz")
          (sha256 (base32 "1853gk2fymvr2yaird9jpvz4mdp6ms8zmy6dr19payrsgwv0bnhh"))))
   (list "rust-zbus-macros-5.19.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zbus_macros/5.19.0/download")
          (file-name "rust-zbus-macros-5.19.0.tar.gz")
          (sha256 (base32 "0h4gr26kyhdyn503rgg8h44sjxm8d6n8qbzpd0cdzrmd15fn7419"))))
   (list "rust-zbus-names-4.3.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zbus_names/4.3.4/download")
          (file-name "rust-zbus-names-4.3.4.tar.gz")
          (sha256 (base32 "0kk250s3x1fxpz9fvhdr64ydbacpn8ah23hy021yhlzzlfs8igyq"))))
   (list "rust-zbus-xml-5.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zbus_xml/5.2.1/download")
          (file-name "rust-zbus-xml-5.2.1.tar.gz")
          (sha256 (base32 "0ak849z0h42zrfvgmddsbim1abiq8vjp9n6w2s90mjh13816qn6i"))))
   (list "rust-zcheapstr-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zcheapstr/1.1.0/download")
          (file-name "rust-zcheapstr-1.1.0.tar.gz")
          (sha256 (base32 "0wwlv70bi2rydvvzfq249q6i51mjx85c4m2wxcx1hra5c18yrbyi"))))
   (list "rust-zerocopy-derive-0.8.57.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerocopy-derive/0.8.57/download")
          (file-name "rust-zerocopy-derive-0.8.57.tar.gz")
          (sha256 (base32 "1g5js10p1q1d7wn6b74wjvrjznv34x5cfxpj7jj8s9a4mgsh2v0l"))))
   (list "rust-zerocopy-0.8.57.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerocopy/0.8.57/download")
          (file-name "rust-zerocopy-0.8.57.tar.gz")
          (sha256 (base32 "0wr85plmrkz0nh5grbqap23l9ghqq4mq1ip4x759q23dyflh4lfk"))))
   (list "rust-zerofrom-0.1.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerofrom/0.1.8/download")
          (file-name "rust-zerofrom-0.1.8.tar.gz")
          (sha256 (base32 "0wjjdj7gdmd0iq91gzkxl7dlv0nhkk80l4bmdpzh3a1yh48mmh0f"))))
   (list "rust-zerofrom-derive-0.1.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerofrom-derive/0.1.7/download")
          (file-name "rust-zerofrom-derive-0.1.7.tar.gz")
          (sha256 (base32 "18c4wsnznhdxx6m80piil1lbyszdiwsshgjrybqcm4b6qic22lqi"))))
   (list "rust-zerotrie-0.2.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerotrie/0.2.5/download")
          (file-name "rust-zerotrie-0.2.5.tar.gz")
          (sha256 (base32 "0gss16krjzk22m57dz5hkdjg99ibj6pa41qr68na7w1jpp1nk8jf"))))
   (list "rust-zerovec-0.11.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerovec/0.11.8/download")
          (file-name "rust-zerovec-0.11.8.tar.gz")
          (sha256 (base32 "1n3xlvyba8riys9s8awy4xp533phqycr78nbsmvdkh86g3hn815v"))))
   (list "rust-zlib-rs-0.6.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zlib-rs/0.6.7/download")
          (file-name "rust-zlib-rs-0.6.7.tar.gz")
          (sha256 (base32 "04mz6314vrfwg8k91qfgs9c71c1icvixcikvki7mls4xilc1vcrl"))))
   (list "rust-zerovec-derive-0.11.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerovec-derive/0.11.6/download")
          (file-name "rust-zerovec-derive-0.11.6.tar.gz")
          (sha256 (base32 "1ni5j8v99x3fcf3l8kp64b7aq4vf8y22jshfq74xs9mxkp1nzprl"))))
   (list "rust-zmij-1.0.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zmij/1.0.23/download")
          (file-name "rust-zmij-1.0.23.tar.gz")
          (sha256 (base32 "06zwri21nnrl34rwinmvbciap8yk1mrl8qfg9pff7lgspc56sri9"))))
   (list "rust-zvariant-5.15.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zvariant/5.15.0/download")
          (file-name "rust-zvariant-5.15.0.tar.gz")
          (sha256 (base32 "0iwihslxshfhalihp6kv7xz7nbv1p3b9sl97hi2izpbcrhklrly1"))))
   (list "rust-zvariant-derive-5.15.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zvariant_derive/5.15.0/download")
          (file-name "rust-zvariant-derive-5.15.0.tar.gz")
          (sha256 (base32 "15y4z1rkcpvrz7dv7j2rfv8wiq6i8nzifj9pgw6dnlj3kgk5ahc6"))))
   (list "rust-zvariant-utils-4.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zvariant_utils/4.2.0/download")
          (file-name "rust-zvariant-utils-4.2.0.tar.gz")
          (sha256 (base32 "18q80094ci64myzvcp0g2l3c6mnx7b3hsii8lfabc853c51jkl5s"))))
))

(define %smithay-git-crate-inputs
  (list
   (list "rust-adler2-2.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/adler2/2.0.1/download")
          (file-name "rust-adler2-2.0.1.tar.gz")
          (sha256 (base32 "1ymy18s9hs7ya1pjc9864l30wk8p2qfqdi7mhhcc5nfakxbij09j"))))
   (list "rust-aho-corasick-1.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/aho-corasick/1.1.5/download")
          (file-name "rust-aho-corasick-1.1.5.tar.gz")
          (sha256 (base32 "1fhjkp2nbs7gg4y1b68hpc8028rpax8aiscfh9b60q78m4pn90n9"))))
   (list "rust-aliasable-0.1.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/aliasable/0.1.3/download")
          (file-name "rust-aliasable-0.1.3.tar.gz")
          (sha256 (base32 "1z8548zdjlm4ps1k0d7x68lfdyji02crwcc9rw3q3bb106f643r5"))))
   (list "rust-aligned-0.4.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/aligned/0.4.3/download")
          (file-name "rust-aligned-0.4.3.tar.gz")
          (sha256 (base32 "1186lhb3gb4x6spzw7ff0zcraa8cr9zqk4ldpm5g1vb2ijc0higf"))))
   (list "rust-aligned-vec-0.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/aligned-vec/0.6.4/download")
          (file-name "rust-aligned-vec-0.6.4.tar.gz")
          (sha256 (base32 "16vnf78hvfix5cwzd5xs5a2g6afmgb4h7n6yfsc36bv0r22072fw"))))
   (list "rust-anes-0.1.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anes/0.1.6/download")
          (file-name "rust-anes-0.1.6.tar.gz")
          (sha256 (base32 "16bj1ww1xkwzbckk32j2pnbn5vk6wgsl3q4p3j9551xbcarwnijb"))))
   (list "rust-android-properties-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/android-properties/0.2.2/download")
          (file-name "rust-android-properties-0.2.2.tar.gz")
          (sha256 (base32 "016slvg269c0y120p9qd8vdfqa2jbw4j0g18gfw6p3ain44v4zpw"))))
   (list "rust-android-activity-0.6.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/android-activity/0.6.1/download")
          (file-name "rust-android-activity-0.6.1.tar.gz")
          (sha256 (base32 "1k8v4mw8kijvmjmqwr05cjvk2arklx2968bjjpa5szc5aaq1nahg"))))
   (list "rust-anstream-1.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstream/1.0.0/download")
          (file-name "rust-anstream-1.0.0.tar.gz")
          (sha256 (base32 "13d2bj0xfg012s4rmq44zc8zgy1q8k9yp7yhvfnarscnmwpj2jl2"))))
   (list "rust-anstyle-1.0.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle/1.0.14/download")
          (file-name "rust-anstyle-1.0.14.tar.gz")
          (sha256 (base32 "0030szmgj51fxkic1hpakxxgappxzwm6m154a3gfml83lq63l2wl"))))
   (list "rust-anstyle-query-1.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle-query/1.1.5/download")
          (file-name "rust-anstyle-query-1.1.5.tar.gz")
          (sha256 (base32 "1p6shfpnbghs6jsa0vnqd8bb8gd7pjd0jr7w0j8jikakzmr8zi20"))))
   (list "rust-anyhow-1.0.104.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anyhow/1.0.104/download")
          (file-name "rust-anyhow-1.0.104.tar.gz")
          (sha256 (base32 "0w34jjcm02p5g9kvsjr1dvpw0zs2fi7igi6nr414fkm5gz85w2ik"))))
   (list "rust-anstyle-wincon-3.0.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle-wincon/3.0.11/download")
          (file-name "rust-anstyle-wincon-3.0.11.tar.gz")
          (sha256 (base32 "0zblannm70sk3xny337mz7c6d8q8i24vhbqi42ld8v7q1wjnl7i9"))))
   (list "rust-anstyle-parse-1.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/anstyle-parse/1.0.0/download")
          (file-name "rust-anstyle-parse-1.0.0.tar.gz")
          (sha256 (base32 "03hkv2690s0crssbnmfkr76kw1k7ah2i6s5amdy9yca2n8w7zkjj"))))
   (list "rust-appendlist-1.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/appendlist/1.4.0/download")
          (file-name "rust-appendlist-1.4.0.tar.gz")
          (sha256 (base32 "1lnbl7mc7capcqj1z1ylxvm4h492sb9sr8pzww3q6lrhrmrxqjg1"))))
   (list "rust-arbitrary-1.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/arbitrary/1.4.2/download")
          (file-name "rust-arbitrary-1.4.2.tar.gz")
          (sha256 (base32 "1wcbi4x7i3lzcrkjda4810nqv03lpmvfhb0a85xrq1mbqjikdl63"))))
   (list "rust-arg-enum-proc-macro-0.3.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/arg_enum_proc_macro/0.3.4/download")
          (file-name "rust-arg-enum-proc-macro-0.3.4.tar.gz")
          (sha256 (base32 "1sjdfd5a8j6r99cf0bpqrd6b160x9vz97y5rysycsjda358jms8a"))))
   (list "rust-arrayvec-0.7.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/arrayvec/0.7.8/download")
          (file-name "rust-arrayvec-0.7.8.tar.gz")
          (sha256 (base32 "0mmd8lrijbvg1qp4c5zis5dq41a3mjv2rb6bxkyj9kwaw2k6gyyk"))))
   (list "rust-ash-0.38.0+1.3.281.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ash/0.38.0+1.3.281/download")
          (file-name "rust-ash-0.38.0+1.3.281.tar.gz")
          (sha256 (base32 "0vx4yf689v1rc680jvy8bnysx5sgd8f33wnp2vqaizh0v0v4kd0b"))))
   (list "rust-as-raw-xcb-connection-1.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/as-raw-xcb-connection/1.0.1/download")
          (file-name "rust-as-raw-xcb-connection-1.0.1.tar.gz")
          (sha256 (base32 "0sqgpz2ymv5yx76r5j2npjq2x5qvvqnw0vrs35cyv30p3pfp2m8p"))))
   (list "rust-as-slice-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/as-slice/0.2.1/download")
          (file-name "rust-as-slice-0.2.1.tar.gz")
          (sha256 (base32 "05j52y1ws8kir5zjxnl48ann0if79sb56p9nm76hvma01r7nnssi"))))
   (list "rust-atomic-waker-1.1.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/atomic-waker/1.1.2/download")
          (file-name "rust-atomic-waker-1.1.2.tar.gz")
          (sha256 (base32 "1h5av1lw56m0jf0fd3bchxq8a30xv0b4wv8s4zkp4s0i7mfvs18m"))))
   (list "rust-autocfg-1.5.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/autocfg/1.5.1/download")
          (file-name "rust-autocfg-1.5.1.tar.gz")
          (sha256 (base32 "0lqasy5i30flcgih1b50kvsk6z32g09r1q4ql7q81pj6228jy0zj"))))
   (list "rust-av1-grain-0.2.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/av1-grain/0.2.5/download")
          (file-name "rust-av1-grain-0.2.5.tar.gz")
          (sha256 (base32 "1y3p43i5xncbny0pfh8kw09am3l3mgyg82ln65r3f434443xpzcc"))))
   (list "rust-avif-serialize-0.8.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/avif-serialize/0.8.9/download")
          (file-name "rust-avif-serialize-0.8.9.tar.gz")
          (sha256 (base32 "0f3z55fma6xmdj0a0x15vz91cqisiardrfgbjlwb2q6lyzjqy5z7"))))
   (list "rust-av-scenechange-0.14.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/av-scenechange/0.14.1/download")
          (file-name "rust-av-scenechange-0.14.1.tar.gz")
          (sha256 (base32 "1543y7riwcy4mmsgcalxcm3bnb41hvwiqiz774nbj68fq9vischg"))))
   (list "rust-bincode-1.3.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bincode/1.3.3/download")
          (file-name "rust-bincode-1.3.3.tar.gz")
          (sha256 (base32 "1bfw3mnwzx5g1465kiqllp5n4r10qrqy88kdlp3jfwnq2ya5xx5i"))))
   (list "rust-bit-field-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bit_field/0.10.3/download")
          (file-name "rust-bit-field-0.10.3.tar.gz")
          (sha256 (base32 "1ikhbph4ap4w692c33r8bbv6yd2qxm1q3f64845grp1s6b3l0jqy"))))
   (list "rust-bindgen-0.72.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bindgen/0.72.1/download")
          (file-name "rust-bindgen-0.72.1.tar.gz")
          (sha256 (base32 "15bq73y3wd3x3vxh3z3g72hy08zs8rxg1f0i1xsrrd6g16spcdwr"))))
   (list "rust-bindgen-0.69.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bindgen/0.69.5/download")
          (file-name "rust-bindgen-0.69.5.tar.gz")
          (sha256 (base32 "1240snlcfj663k04bjsg629g4wx6f83flgbjh5rzpgyagk3864r7"))))
   (list "rust-bitflags-1.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bitflags/1.3.2/download")
          (file-name "rust-bitflags-1.3.2.tar.gz")
          (sha256 (base32 "12ki6w8gn1ldq7yz9y680llwk5gmrhrzszaa17g1sbrw2r2qvwxy"))))
   (list "rust-bindgen-0.70.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bindgen/0.70.1/download")
          (file-name "rust-bindgen-0.70.1.tar.gz")
          (sha256 (base32 "0vyf0jp6apcy9kjyz4s8vldj0xqycnbzb6zv3skkwiqdi3nqz7gl"))))
   (list "rust-bitflags-2.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bitflags/2.13.2/download")
          (file-name "rust-bitflags-2.13.2.tar.gz")
          (sha256 (base32 "01hbgjwvid66850fzi76mvn5f2bqycx6sf165ng1kfjqq9bl1v9x"))))
   (list "rust-bitstream-io-4.10.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bitstream-io/4.10.0/download")
          (file-name "rust-bitstream-io-4.10.0.tar.gz")
          (sha256 (base32 "07zxcy47l51k6vsxphzhgcnqyzl21pprs7212687c64s56z01zvy"))))
   (list "rust-block-buffer-0.10.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/block-buffer/0.10.4/download")
          (file-name "rust-block-buffer-0.10.4.tar.gz")
          (sha256 (base32 "0w9sa2ypmrsqqvc20nhwr75wbb5cjr4kkyhpjm1z1lv2kdicfy1h"))))
   (list "rust-block2-0.6.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/block2/0.6.2/download")
          (file-name "rust-block2-0.6.2.tar.gz")
          (sha256 (base32 "1xcfllzx6c3jc554nmb5qy6xmlkl6l6j5ib4wd11800n0n3rvsyd"))))
   (list "rust-borsh-1.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/borsh/1.8.1/download")
          (file-name "rust-borsh-1.8.1.tar.gz")
          (sha256 (base32 "02p2lhz49944wc6j5dzr42y1mkrv0znbicg3cl61b9bbda25sg2m"))))
   (list "rust-built-0.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/built/0.8.1/download")
          (file-name "rust-built-0.8.1.tar.gz")
          (sha256 (base32 "1saq332pd6g3svvc9ah8myjpfvgqlzl2ksb1ypp3976kjcfm63jw"))))
   (list "rust-bumpalo-3.20.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bumpalo/3.20.3/download")
          (file-name "rust-bumpalo-3.20.3.tar.gz")
          (sha256 (base32 "0jc6va3nwcqikm7chnpdv1s87my3gs2j7g1sc7g3k91brg3arxbj"))))
   (list "rust-bytemuck-1.25.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bytemuck/1.25.2/download")
          (file-name "rust-bytemuck-1.25.2.tar.gz")
          (sha256 (base32 "15rp2m7j7kq22s76cbjwmrkd5r8lvacnm0mnrj013cnzka22x0wm"))))
   (list "rust-byteorder-1.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/byteorder/1.5.0/download")
          (file-name "rust-byteorder-1.5.0.tar.gz")
          (sha256 (base32 "0jzncxyf404mwqdbspihyzpkndfgda450l0893pz5xj685cg5l0z"))))
   (list "rust-byteorder-lite-0.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/byteorder-lite/0.1.0/download")
          (file-name "rust-byteorder-lite-0.1.0.tar.gz")
          (sha256 (base32 "15alafmz4b9az56z6x7glcbcb6a8bfgyd109qc3bvx07zx4fj7wg"))))
   (list "rust-bytemuck-derive-1.12.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bytemuck_derive/1.12.1/download")
          (file-name "rust-bytemuck-derive-1.12.1.tar.gz")
          (sha256 (base32 "17379imphax0d85jzkc50acw746mw89hjbrxqxlw1wmnhxjqj7va"))))
   (list "rust-bytes-1.12.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/bytes/1.12.1/download")
          (file-name "rust-bytes-1.12.1.tar.gz")
          (sha256 (base32 "017z19dpg4f942h051m7bpnzcgng042hhcpd7bmg7bjjqd42lrgw"))))
   (list "rust-calloop-0.14.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/calloop/0.14.4/download")
          (file-name "rust-calloop-0.14.4.tar.gz")
          (sha256 (base32 "1xsd8xk53v9zbvhjy7ynf4gya9s4rvvh8jqx9psi1b2v6rw9kgsd"))))
   (list "rust-calloop-0.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/calloop/0.13.0/download")
          (file-name "rust-calloop-0.13.0.tar.gz")
          (sha256 (base32 "1v5zgidnhsyml403rzr7vm99f8q6r5bxq5gxyiqkr8lcapwa57dr"))))
   (list "rust-calloop-wayland-source-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/calloop-wayland-source/0.4.1/download")
          (file-name "rust-calloop-wayland-source-0.4.1.tar.gz")
          (sha256 (base32 "1yi1c23naqhd8m94q3v366s4cak8l50zy7ldrkqfn0hajkqgr3hk"))))
   (list "rust-cast-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cast/0.3.0/download")
          (file-name "rust-cast-0.3.0.tar.gz")
          (sha256 (base32 "1dbyngbyz2qkk0jn2sxil8vrz3rnpcj142y184p9l4nbl9radcip"))))
   (list "rust-calloop-wayland-source-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/calloop-wayland-source/0.3.0/download")
          (file-name "rust-calloop-wayland-source-0.3.0.tar.gz")
          (sha256 (base32 "086x5mq16prrcwd9k6bw9an0sp8bj9l5daz4ziz5z4snf2c6m9lm"))))
   (list "rust-cc-1.4.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cc/1.4.7/download")
          (file-name "rust-cc-1.4.7.tar.gz")
          (sha256 (base32 "04z3q2wqsg4qgx4vsqsd01s27svz0bgdymjiyccgbnn24gg3whal"))))
   (list "rust-cexpr-0.6.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cexpr/0.6.0/download")
          (file-name "rust-cexpr-0.6.0.tar.gz")
          (sha256 (base32 "0rl77bwhs5p979ih4r0202cn5jrfsrbgrksp40lkfz5vk1x3ib3g"))))
   (list "rust-cfg-aliases-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cfg_aliases/0.2.2/download")
          (file-name "rust-cfg-aliases-0.2.2.tar.gz")
          (sha256 (base32 "09rm3dv28gbsal7w6q76lg2nfyn8wp789ska9b8vr1w750xfhygh"))))
   (list "rust-cfg-expr-0.20.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cfg-expr/0.20.9/download")
          (file-name "rust-cfg-expr-0.20.9.tar.gz")
          (sha256 (base32 "05z97ah29viw66l3c46y391nfsri9dxpwr166k36dxxmfj2cwkpy"))))
   (list "rust-chacha20-0.10.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/chacha20/0.10.2/download")
          (file-name "rust-chacha20-0.10.2.tar.gz")
          (sha256 (base32 "01hvvbgdmqkcgs2s4f12s9wa5h2gbq05rqvypv61azlwd55mxhv5"))))
   (list "rust-cfg-if-1.0.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cfg-if/1.0.5/download")
          (file-name "rust-cfg-if-1.0.5.tar.gz")
          (sha256 (base32 "0026j56901nzjraap3da0a8njw42j66zcxnn6s2s9aa5bcblhxjf"))))
   (list "rust-ciborium-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ciborium/0.2.2/download")
          (file-name "rust-ciborium-0.2.2.tar.gz")
          (sha256 (base32 "03hgfw4674im1pdqblcp77m7rc8x2v828si5570ga5q9dzyrzrj2"))))
   (list "rust-ciborium-ll-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ciborium-ll/0.2.2/download")
          (file-name "rust-ciborium-ll-0.2.2.tar.gz")
          (sha256 (base32 "1n8g4j5rwkfs3rzfi6g1p7ngmz6m5yxsksryzf5k72ll7mjknrjp"))))
   (list "rust-ciborium-io-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ciborium-io/0.2.2/download")
          (file-name "rust-ciborium-io-0.2.2.tar.gz")
          (sha256 (base32 "0my7s5g24hvp1rs1zd1cxapz94inrvqpdf1rslrvxj8618gfmbq5"))))
   (list "rust-clang-sys-1.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clang-sys/1.9.1/download")
          (file-name "rust-clang-sys-1.9.1.tar.gz")
          (sha256 (base32 "12kqa3wywpxw3jk7n2dqz9fjm8p0qczx37y0yib3nwc0njkqnyhm"))))
   (list "rust-clap-4.6.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap/4.6.7/download")
          (file-name "rust-clap-4.6.7.tar.gz")
          (sha256 (base32 "0il98y2rfw75984ck59znd4n592p07bxz8yy3a9blddb02rpd25a"))))
   (list "rust-clap-builder-4.6.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_builder/4.6.7/download")
          (file-name "rust-clap-builder-4.6.7.tar.gz")
          (sha256 (base32 "0kbhai5rv1vj9r4np52g2b9fmhvy3y82digs9v40c57bgbxrf1zc"))))
   (list "rust-clap-lex-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_lex/1.1.1/download")
          (file-name "rust-clap-lex-1.1.1.tar.gz")
          (sha256 (base32 "11k4m4ngn39iz39lnq6nn6kyxzp62mnm1d86qfad3q0vlk33n4qw"))))
   (list "rust-colorchoice-1.0.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/colorchoice/1.0.5/download")
          (file-name "rust-colorchoice-1.0.5.tar.gz")
          (sha256 (base32 "0w75k89hw39p0mnnhlrwr23q50rza1yjki44qvh2mgrnj065a1qx"))))
   (list "rust-clap-derive-4.6.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/clap_derive/4.6.7/download")
          (file-name "rust-clap-derive-4.6.7.tar.gz")
          (sha256 (base32 "1q36bgbkfb9rdz7jcvd0ffv0wwlyw0lg3z6iwdcybm0mjjvm3izr"))))
   (list "rust-color-quant-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/color_quant/1.1.0/download")
          (file-name "rust-color-quant-1.1.0.tar.gz")
          (sha256 (base32 "12q1n427h2bbmmm1mnglr57jaz2dj9apk0plcxw7nwqiai7qjyrx"))))
   (list "rust-combine-4.6.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/combine/4.6.8/download")
          (file-name "rust-combine-4.6.8.tar.gz")
          (sha256 (base32 "0ppwzwdmszpan9ybx1myc6ldg5zih2sazf9idckdxrh9gn9j1hyg"))))
   (list "rust-concurrent-queue-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/concurrent-queue/2.5.0/download")
          (file-name "rust-concurrent-queue-2.5.0.tar.gz")
          (sha256 (base32 "0wrr3mzq2ijdkxwndhf79k952cp4zkz35ray8hvsxl96xrx1k82c"))))
   (list "rust-container-of-0.5.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/container_of/0.5.1/download")
          (file-name "rust-container-of-0.5.1.tar.gz")
          (sha256 (base32 "0as7g6gspvdbp4vl1a1834pzh481x9jp4clfgyl6c7vnhvmvpxc9"))))
   (list "rust-cpufeatures-0.2.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cpufeatures/0.2.17/download")
          (file-name "rust-cpufeatures-0.2.17.tar.gz")
          (sha256 (base32 "10023dnnaghhdl70xcds12fsx2b966sxbxjq5sxs49mvxqw5ivar"))))
   (list "rust-cpufeatures-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cpufeatures/0.3.1/download")
          (file-name "rust-cpufeatures-0.3.1.tar.gz")
          (sha256 (base32 "0rkm1l35jy1z1yfg723fddsxc7vr0gc1hhfvc138hnqiwc58p8jw"))))
   (list "rust-crc32fast-1.5.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crc32fast/1.5.2/download")
          (file-name "rust-crc32fast-1.5.2.tar.gz")
          (sha256 (base32 "0y0f955n2hr5a8rd9nw9sr23nhjc42ddx3bjc47dnlmqssgpk9q1"))))
   (list "rust-criterion-0.5.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/criterion/0.5.1/download")
          (file-name "rust-criterion-0.5.1.tar.gz")
          (sha256 (base32 "0bv9ipygam3z8kk6k771gh9zi0j0lb9ir0xi1pc075ljg80jvcgj"))))
   (list "rust-criterion-plot-0.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/criterion-plot/0.5.0/download")
          (file-name "rust-criterion-plot-0.5.0.tar.gz")
          (sha256 (base32 "1c866xkjqqhzg4cjvg01f8w6xc1j3j7s58rdksl52skq89iq4l3b"))))
   (list "rust-crossbeam-channel-0.5.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-channel/0.5.17/download")
          (file-name "rust-crossbeam-channel-0.5.17.tar.gz")
          (sha256 (base32 "1wcy7y77hw7z5m140114iqxb90gsq062djd9zpkndisvgcrcrc4q"))))
   (list "rust-crossbeam-epoch-0.9.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-epoch/0.9.21/download")
          (file-name "rust-crossbeam-epoch-0.9.21.tar.gz")
          (sha256 (base32 "17bdp2linl0milbmx00s3bda3fphgc85im1gqwa3p6hhhw39hx6w"))))
   (list "rust-crossbeam-utils-0.8.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-utils/0.8.23/download")
          (file-name "rust-crossbeam-utils-0.8.23.tar.gz")
          (sha256 (base32 "1ilan2nw7fvka8hki80fr57a5dgd4mvcsvwq60437j6yvlwyw7m3"))))
   (list "rust-crossbeam-deque-0.8.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crossbeam-deque/0.8.8/download")
          (file-name "rust-crossbeam-deque-0.8.8.tar.gz")
          (sha256 (base32 "06kip6ay8wcx5y4flg6wxbnyd44ay8308c8lf8y3iglh6v3kybv2"))))
   (list "rust-crunchy-0.2.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crunchy/0.2.4/download")
          (file-name "rust-crunchy-0.2.4.tar.gz")
          (sha256 (base32 "1mbp5navim2qr3x48lyvadqblcxc1dm0lqr0swrkkwy2qblvw3s6"))))
   (list "rust-crypto-common-0.1.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/crypto-common/0.1.7/download")
          (file-name "rust-crypto-common-0.1.7.tar.gz")
          (sha256 (base32 "02nn2rhfy7kvdkdjl457q2z0mklcvj9h662xrq6dzhfialh2kj3q"))))
   (list "rust-cursor-icon-1.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/cursor-icon/1.2.0/download")
          (file-name "rust-cursor-icon-1.2.0.tar.gz")
          (sha256 (base32 "0bvkw7ak1mqwcpkgd9lh7n00hcvlh87jfl7188f231nz6zfy2ypj"))))
   (list "rust-digest-0.10.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/digest/0.10.7/download")
          (file-name "rust-digest-0.10.7.tar.gz")
          (sha256 (base32 "14p2n6ih29x81akj097lvz7wi9b6b9hvls0lwrv7b6xwyy0s5ncy"))))
   (list "rust-dispatch2-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dispatch2/0.3.1/download")
          (file-name "rust-dispatch2-0.3.1.tar.gz")
          (sha256 (base32 "0f5xmnbzpaz1g80m27kd804p75nswh0ikb6wvqh4ba3x9rz3c3hy"))))
   (list "rust-displaydoc-0.2.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/displaydoc/0.2.7/download")
          (file-name "rust-displaydoc-0.2.7.tar.gz")
          (sha256 (base32 "1a42mwpgpwcqq2qqgkcc630wvsc2p2dkmgacjnclginwfz9js8y6"))))
   (list "rust-dlib-0.5.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dlib/0.5.3/download")
          (file-name "rust-dlib-0.5.3.tar.gz")
          (sha256 (base32 "0jpr4smrwrv8xj70mz4ixnbc6ljm82f12z2mz1hv89056y3wv3mb"))))
   (list "rust-downcast-rs-1.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/downcast-rs/1.2.1/download")
          (file-name "rust-downcast-rs-1.2.1.tar.gz")
          (sha256 (base32 "1lmrq383d1yszp7mg5i7i56b17x2lnn3kb91jwsq0zykvg2jbcvm"))))
   (list "rust-drm-0.14.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm/0.14.1/download")
          (file-name "rust-drm-0.14.1.tar.gz")
          (sha256 (base32 "0vvmj9n0wslrbw3rinpzlfyhwwgr02gqspy1al5gfh99dif8rg40"))))
   (list "rust-dpi-0.1.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/dpi/0.1.2/download")
          (file-name "rust-dpi-0.1.2.tar.gz")
          (sha256 (base32 "0xhsvzgjvdch2fwmfc9vkb708b0q59b6imypyjlgbiigyb74rcfq"))))
   (list "rust-drm-fourcc-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm-fourcc/2.2.0/download")
          (file-name "rust-drm-fourcc-2.2.0.tar.gz")
          (sha256 (base32 "1x76v9a0pkgym4n6cah4barnai9gsssm7gjzxskw2agwibdvrbqa"))))
   (list "rust-drm-ffi-0.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm-ffi/0.9.1/download")
          (file-name "rust-drm-ffi-0.9.1.tar.gz")
          (sha256 (base32 "147n13dnkr4kzdj4662dqgbjfvnnw14yhmf2vq2q2kmc6adiraai"))))
   (list "rust-drm-sys-0.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/drm-sys/0.8.1/download")
          (file-name "rust-drm-sys-0.8.1.tar.gz")
          (sha256 (base32 "1y59h9x5yn9p36f9bqjvw76kx75yqfin1w6gzigiznb620vf3j7c"))))
   (list "rust-either-1.18.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/either/1.18.0/download")
          (file-name "rust-either-1.18.0.tar.gz")
          (sha256 (base32 "0d7dx31sf8rakcgp63070ngb2vkjynrni866pnx879pawndgnai5"))))
   (list "rust-encoding-rs-0.8.35.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/encoding_rs/0.8.35/download")
          (file-name "rust-encoding-rs-0.8.35.tar.gz")
          (sha256 (base32 "1wv64xdrr9v37rqqdjsyb8l8wzlcbab80ryxhrszvnj59wy0y0vm"))))
   (list "rust-enumflags2-0.7.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/enumflags2/0.7.12/download")
          (file-name "rust-enumflags2-0.7.12.tar.gz")
          (sha256 (base32 "1vzcskg4dca2jiflsfx1p9yw1fvgzcakcs7cpip0agl51ilgf9qh"))))
   (list "rust-enumflags2-derive-0.7.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/enumflags2_derive/0.7.12/download")
          (file-name "rust-enumflags2-derive-0.7.12.tar.gz")
          (sha256 (base32 "09rqffacafl1b83ir55hrah9gza0x7pzjn6lr6jm76fzix6qmiv7"))))
   (list "rust-equator-0.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/equator/0.4.2/download")
          (file-name "rust-equator-0.4.2.tar.gz")
          (sha256 (base32 "1z760z5r0haxjyakbqxvswrz9mq7c29arrivgq8y1zldhc9v44a7"))))
   (list "rust-equator-macro-0.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/equator-macro/0.4.2/download")
          (file-name "rust-equator-macro-0.4.2.tar.gz")
          (sha256 (base32 "1cqzx3cqn9rxln3a607xr54wippzff56zs5chqdf3z2bnks3rwj4"))))
   (list "rust-equivalent-1.0.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/equivalent/1.0.2/download")
          (file-name "rust-equivalent-1.0.2.tar.gz")
          (sha256 (base32 "03swzqznragy8n0x31lqc78g2af054jwivp7lkrbrc0khz74lyl7"))))
   (list "rust-errno-0.3.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/errno/0.3.14/download")
          (file-name "rust-errno-0.3.14.tar.gz")
          (sha256 (base32 "1szgccmh8vgryqyadg8xd58mnwwicf39zmin3bsn63df2wbbgjir"))))
   (list "rust-fastrand-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fastrand/2.5.0/download")
          (file-name "rust-fastrand-2.5.0.tar.gz")
          (sha256 (base32 "08q2r30y62winysimnlpbvw9kiwn0rmdlidqlmzd6z90mv764z6s"))))
   (list "rust-exr-1.74.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/exr/1.74.2/download")
          (file-name "rust-exr-1.74.2.tar.gz")
          (sha256 (base32 "1wxd45pcgcc1zs7dcl39i2c4plp1w2gkzfizxq0mwab4k4nf87vi"))))
   (list "rust-fax-0.2.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fax/0.2.7/download")
          (file-name "rust-fax-0.2.7.tar.gz")
          (sha256 (base32 "0nmc65jjdym0f7lr4qm2q7awz1p5arm8i19wv1cmsg92cfahgwfa"))))
   (list "rust-fdeflate-0.3.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fdeflate/0.3.7/download")
          (file-name "rust-fdeflate-0.3.7.tar.gz")
          (sha256 (base32 "130ga18vyxbb5idbgi07njymdaavvk6j08yh1dfarm294ssm6s0y"))))
   (list "rust-find-msvc-tools-0.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/find-msvc-tools/0.1.13/download")
          (file-name "rust-find-msvc-tools-0.1.13.tar.gz")
          (sha256 (base32 "16ykhz2icc0xx8i3vr8fpp6h3djpik2zw5bcxbff9bxba5g909gg"))))
   (list "rust-float-cmp-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/float-cmp/0.9.0/download")
          (file-name "rust-float-cmp-0.9.0.tar.gz")
          (sha256 (base32 "1i799ksbq7fj9rm9m82g1yqgm6xi3jnrmylddmqknmksajylpplq"))))
   (list "rust-flate2-1.1.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/flate2/1.1.10/download")
          (file-name "rust-flate2-1.1.10.tar.gz")
          (sha256 (base32 "1jvd2cl8j5hyf8imi62y1x7gwzz1hajirni0801yxhds1qp4wqvf"))))
   (list "rust-foldhash-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/foldhash/0.2.0/download")
          (file-name "rust-foldhash-0.2.0.tar.gz")
          (sha256 (base32 "1nvgylb099s11xpfm1kn2wcsql080nqmnhj1l25bp3r2b35j9kkp"))))
   (list "rust-form-urlencoded-1.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/form_urlencoded/1.2.2/download")
          (file-name "rust-form-urlencoded-1.2.2.tar.gz")
          (sha256 (base32 "1kqzb2qn608rxl3dws04zahcklpplkd5r1vpabwga5l50d2v4k6b"))))
   (list "rust-fps-ticker-1.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/fps_ticker/1.0.0/download")
          (file-name "rust-fps-ticker-1.0.0.tar.gz")
          (sha256 (base32 "06cj5c5rk5grm2ajh4sabcppxr1h57gxfqacvi5psxb9zw2lj5py"))))
   (list "rust-futures-core-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-core/0.3.34/download")
          (file-name "rust-futures-core-0.3.34.tar.gz")
          (sha256 (base32 "0pjgv4fx0np6hrs5sz5a2phabwv0z70yr51v03injbi44bjrkmlj"))))
   (list "rust-futures-task-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-task/0.3.34/download")
          (file-name "rust-futures-task-0.3.34.tar.gz")
          (sha256 (base32 "1zfilqs8nwlfqz4prk7ihvpp5avvzins87ibzlxzq5fhs7ipshfd"))))
   (list "rust-futures-util-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/futures-util/0.3.34/download")
          (file-name "rust-futures-util-0.3.34.tar.gz")
          (sha256 (base32 "1g3r9ghzq7c2fh34lis43i72xavk9p84npgfwgb5vfpqcwjajl0d"))))
   (list "rust-gbm-0.18.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gbm/0.18.0/download")
          (file-name "rust-gbm-0.18.0.tar.gz")
          (sha256 (base32 "0skyaj51xlazaa24jdkxxi2g6pnw834k3yqlf2ly999wincjx1ff"))))
   (list "rust-gbm-sys-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gbm-sys/0.4.0/download")
          (file-name "rust-gbm-sys-0.4.0.tar.gz")
          (sha256 (base32 "0vzp28ip4w74p05ygs4p9m7sspggn2zvcykbpyv8ypbqrhm5yfn1"))))
   (list "rust-generator-0.8.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/generator/0.8.10/download")
          (file-name "rust-generator-0.8.10.tar.gz")
          (sha256 (base32 "0lf5yqjg606zdwp5m703nazmia7mkmdchdf0wyy46c00r5nykbal"))))
   (list "rust-generic-array-0.14.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/generic-array/0.14.7/download")
          (file-name "rust-generic-array-0.14.7.tar.gz")
          (sha256 (base32 "16lyyrzrljfq424c3n8kfwkqihlimmsg5nhshbbp48np3yjrqr45"))))
   (list "rust-gethostname-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gethostname/1.1.0/download")
          (file-name "rust-gethostname-1.1.0.tar.gz")
          (sha256 (base32 "1n6bj9gh503ggjblfjcai96gmxynxsrykaynljlrfdra34q95m0v"))))
   (list "rust-getrandom-0.4.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/getrandom/0.4.3/download")
          (file-name "rust-getrandom-0.4.3.tar.gz")
          (sha256 (base32 "16b0202fkdwz3p2cyll82dv24ljbn0wiyy829v4lwbkbflyqh3ih"))))
   (list "rust-getrandom-0.2.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/getrandom/0.2.17/download")
          (file-name "rust-getrandom-0.2.17.tar.gz")
          (sha256 (base32 "1l2ac6jfj9xhpjjgmcx6s1x89bbnw9x6j9258yy6xjkzpq0bqapz"))))
   (list "rust-getrandom-0.3.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/getrandom/0.3.4/download")
          (file-name "rust-getrandom-0.3.4.tar.gz")
          (sha256 (base32 "1zbpvpicry9lrbjmkd4msgj3ihff1q92i334chk7pzf46xffz7c9"))))
   (list "rust-gif-0.14.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gif/0.14.2/download")
          (file-name "rust-gif-0.14.2.tar.gz")
          (sha256 (base32 "0n81js7vlb9bwrjb765sicza3k0vrihjddrgm2mvpbfr272gr37f"))))
   (list "rust-glam-0.33.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glam/0.33.8/download")
          (file-name "rust-glam-0.33.8.tar.gz")
          (sha256 (base32 "18jbwm8z26ndfd0j5vnbcsz4a9n8hwp6k6k1cmpxfnc20w3hg6d0"))))
   (list "rust-gl-generator-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/gl_generator/0.14.0/download")
          (file-name "rust-gl-generator-0.14.0.tar.gz")
          (sha256 (base32 "0k8j1hmfnff312gy7x1aqjzcm8zxid7ij7dlb8prljib7b1dz58s"))))
   (list "rust-glob-0.3.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glob/0.3.4/download")
          (file-name "rust-glob-0.3.4.tar.gz")
          (sha256 (base32 "02zby4rsidb2ksrnysyrsaap7rk6wpp7vl5chflndafhl5gaisz4"))))
   (list "rust-glow-0.16.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/glow/0.16.0/download")
          (file-name "rust-glow-0.16.0.tar.gz")
          (sha256 (base32 "022z12nlyfpy36fvp2szq792xix1xbgkznpmicf1c404sxhfmrf5"))))
   (list "rust-half-2.7.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/half/2.7.1/download")
          (file-name "rust-half-2.7.1.tar.gz")
          (sha256 (base32 "0jyq42xfa6sghc397mx84av7fayd4xfxr4jahsqv90lmjr5xi8kf"))))
   (list "rust-hashbrown-0.17.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hashbrown/0.17.1/download")
          (file-name "rust-hashbrown-0.17.1.tar.gz")
          (sha256 (base32 "0jmqz7i4yl6cm7rbn0i2ffkfrmwi6xkmzkaldr2v8bcsx2v0jngd"))))
   (list "rust-heck-0.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/heck/0.5.0/download")
          (file-name "rust-heck-0.5.0.tar.gz")
          (sha256 (base32 "1sjmpsdl8czyh9ywl3qcsfsq9a307dg4ni2vnlwgnzzqhc4y0113"))))
   (list "rust-hermit-abi-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hermit-abi/0.3.9/download")
          (file-name "rust-hermit-abi-0.3.9.tar.gz")
          (sha256 (base32 "092hxjbjnq5fmz66grd9plxd0sh6ssg5fhgwwwqbrzgzkjwdycfj"))))
   (list "rust-hermit-abi-0.5.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/hermit-abi/0.5.3/download")
          (file-name "rust-hermit-abi-0.5.3.tar.gz")
          (sha256 (base32 "115jzi6ixx2nhkzbr2ijj36634agz32n6ilz2rg7vk5s1vb94xg1"))))
   (list "rust-home-0.5.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/home/0.5.11/download")
          (file-name "rust-home-0.5.11.tar.gz")
          (sha256 (base32 "1kxb4k87a9sayr8jipr7nq9wpgmjk4hk4047hmf9kc24692k75aq"))))
   (list "rust-icu-normalizer-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_normalizer/2.2.0/download")
          (file-name "rust-icu-normalizer-2.2.0.tar.gz")
          (sha256 (base32 "1d7krxr0xpc4x9635k1100a24nh0nrc59n65j6yk6gbfkplmwvn5"))))
   (list "rust-icu-collections-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_collections/2.2.0/download")
          (file-name "rust-icu-collections-2.2.0.tar.gz")
          (sha256 (base32 "070r7xd0pynm0hnc1v2jzlbxka6wf50f81wybf9xg0y82v6x3119"))))
   (list "rust-icu-locale-core-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_locale_core/2.2.0/download")
          (file-name "rust-icu-locale-core-2.2.0.tar.gz")
          (sha256 (base32 "0a9cmin5w1x3bg941dlmgszn33qgq428k7qiqn5did72ndi9n8cj"))))
   (list "rust-icu-normalizer-data-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_normalizer_data/2.2.0/download")
          (file-name "rust-icu-normalizer-data-2.2.0.tar.gz")
          (sha256 (base32 "0f5d5d5fhhr9937m2z6z38fzh6agf14z24kwlr6lyczafypf0fys"))))
   (list "rust-icu-properties-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_properties/2.2.0/download")
          (file-name "rust-icu-properties-2.2.0.tar.gz")
          (sha256 (base32 "1pkh3s837808cbwxvfagwc28cvwrz2d9h5rl02jwrhm51ryvdqxy"))))
   (list "rust-icu-provider-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_provider/2.2.0/download")
          (file-name "rust-icu-provider-2.2.0.tar.gz")
          (sha256 (base32 "08dl8pxbwr8zsz4c5vphqb7xw0hykkznwi4rw7bk6pwb3krlr70k"))))
   (list "rust-icu-properties-data-2.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/icu_properties_data/2.2.0/download")
          (file-name "rust-icu-properties-data-2.2.0.tar.gz")
          (sha256 (base32 "052awny0qwkbcbpd5jg2cd7vl5ry26pq4hz1nfsgf10c3qhbnawf"))))
   (list "rust-idna-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/idna/1.1.0/download")
          (file-name "rust-idna-1.1.0.tar.gz")
          (sha256 (base32 "1pp4n7hppm480zcx411dsv9wfibai00wbpgnjj4qj0xa7kr7a21v"))))
   (list "rust-image-0.25.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/image/0.25.9/download")
          (file-name "rust-image-0.25.9.tar.gz")
          (sha256 (base32 "06lwa4ag3zcmjzivl356q0qhgxxqpkp7qwda7x0mjrkq21n6ql76"))))
   (list "rust-idna-adapter-1.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/idna_adapter/1.2.2/download")
          (file-name "rust-idna-adapter-1.2.2.tar.gz")
          (sha256 (base32 "0557p76l8hj35r9zn1yv7c6x1c0qbrsffmg80n0yy8361ly3fs6b"))))
   (list "rust-image-webp-0.2.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/image-webp/0.2.4/download")
          (file-name "rust-image-webp-0.2.4.tar.gz")
          (sha256 (base32 "1hz814csyi9283vinzlkix6qpnd6hs3fkw7xl6z2zgm4w7rrypjj"))))
   (list "rust-indexmap-2.14.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/indexmap/2.14.2/download")
          (file-name "rust-indexmap-2.14.2.tar.gz")
          (sha256 (base32 "0mf86hbjkkcd82cpq683bblbs0zwa8ndla96ci8p1ji6bl7ijknc"))))
   (list "rust-imgref-1.12.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/imgref/1.12.3/download")
          (file-name "rust-imgref-1.12.3.tar.gz")
          (sha256 (base32 "0byjryn74gh3jxshkvmf81r7hnphspr67aah3m22zj54xajb0i3f"))))
   (list "rust-input-0.10.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/input/0.10.0/download")
          (file-name "rust-input-0.10.0.tar.gz")
          (sha256 (base32 "17cmlwa5z6z3x47r7m78vmh8f7rmv2sncc53cdvk2waxlr2k6ygr"))))
   (list "rust-input-sys-1.19.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/input-sys/1.19.0/download")
          (file-name "rust-input-sys-1.19.0.tar.gz")
          (sha256 (base32 "1rqrrglhgyyiy7xh8jvf9jwh2dyk2g7l5rmjaazrbg82iryy1vin"))))
   (list "rust-instant-0.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/instant/0.1.13/download")
          (file-name "rust-instant-0.1.13.tar.gz")
          (sha256 (base32 "08h27kzvb5jw74mh0ajv0nv9ggwvgqm8ynjsn2sa9jsks4cjh970"))))
   (list "rust-interpolate-name-0.2.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/interpolate_name/0.2.4/download")
          (file-name "rust-interpolate-name-0.2.4.tar.gz")
          (sha256 (base32 "0q7s5mrfkx4p56dl8q9zq71y1ysdj4shh6f28qf9gly35l21jj63"))))
   (list "rust-io-lifetimes-1.0.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/io-lifetimes/1.0.11/download")
          (file-name "rust-io-lifetimes-1.0.11.tar.gz")
          (sha256 (base32 "1hph5lz4wd3drnn6saakwxr497liznpfnv70via6s0v8x6pbkrza"))))
   (list "rust-is-terminal-0.4.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/is-terminal/0.4.17/download")
          (file-name "rust-is-terminal-0.4.17.tar.gz")
          (sha256 (base32 "0ilfr9n31m0k6fsm3gvfrqaa62kbzkjqpwcd9mc46klfig1w2h1n"))))
   (list "rust-is-terminal-polyfill-1.70.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/is_terminal_polyfill/1.70.2/download")
          (file-name "rust-is-terminal-polyfill-1.70.2.tar.gz")
          (sha256 (base32 "15anlc47sbz0jfs9q8fhwf0h3vs2w4imc030shdnq54sny5i7jx6"))))
   (list "rust-itertools-0.10.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itertools/0.10.5/download")
          (file-name "rust-itertools-0.10.5.tar.gz")
          (sha256 (base32 "0ww45h7nxx5kj6z2y6chlskxd1igvs4j507anr6dzg99x1h25zdh"))))
   (list "rust-itertools-0.12.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itertools/0.12.1/download")
          (file-name "rust-itertools-0.12.1.tar.gz")
          (sha256 (base32 "0s95jbb3ndj1lvfxyq5wanc0fm0r6hg6q4ngb92qlfdxvci10ads"))))
   (list "rust-itertools-0.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itertools/0.13.0/download")
          (file-name "rust-itertools-0.13.0.tar.gz")
          (sha256 (base32 "11hiy3qzl643zcigknclh446qb9zlg4dpdzfkjaa9q9fqpgyfgj1"))))
   (list "rust-itertools-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itertools/0.14.0/download")
          (file-name "rust-itertools-0.14.0.tar.gz")
          (sha256 (base32 "118j6l1vs2mx65dqhwyssbrxpawa90886m3mzafdvyip41w2q69b"))))
   (list "rust-itoa-1.0.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/itoa/1.0.18/download")
          (file-name "rust-itoa-1.0.18.tar.gz")
          (sha256 (base32 "10jnd1vpfkb8kj38rlkn2a6k02afvj3qmw054dfpzagrpl6achlg"))))
   (list "rust-jni-0.22.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni/0.22.4/download")
          (file-name "rust-jni-0.22.4.tar.gz")
          (sha256 (base32 "161lza8gz071h22pgyqyx4n91ixd691z2dbb1pq2g97k5i49mzay"))))
   (list "rust-jni-macros-0.22.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-macros/0.22.4/download")
          (file-name "rust-jni-macros-0.22.4.tar.gz")
          (sha256 (base32 "18v02mcn5c7mb2yw6r930xg6ynsn7hwkxv8z2kdhn3qprjn0j0d0"))))
   (list "rust-jni-sys-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-sys/0.3.1/download")
          (file-name "rust-jni-sys-0.3.1.tar.gz")
          (sha256 (base32 "0n1j8fbz081w1igfrpc79n6vgm7h3ik34nziy5fjgq5nz7hm59j1"))))
   (list "rust-jni-sys-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-sys/0.4.1/download")
          (file-name "rust-jni-sys-0.4.1.tar.gz")
          (sha256 (base32 "1wlahx6f2zhczdjqyn8mk7kshb8x5vsd927sn3lvw41rrf47ldy6"))))
   (list "rust-jni-sys-macros-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jni-sys-macros/0.4.1/download")
          (file-name "rust-jni-sys-macros-0.4.1.tar.gz")
          (sha256 (base32 "0r32gbabrak15a7p487765b5wc0jcna2yv88mk6m1zjqyi1bkh1q"))))
   (list "rust-jobserver-0.1.35.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/jobserver/0.1.35/download")
          (file-name "rust-jobserver-0.1.35.tar.gz")
          (sha256 (base32 "1crwgbb0wjph42ni4hqryjxlv4vlr0hyk81g76id9fpa56ysq00w"))))
   (list "rust-js-sys-0.3.105.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/js-sys/0.3.105/download")
          (file-name "rust-js-sys-0.3.105.tar.gz")
          (sha256 (base32 "17pr58p55pxbflkjl2wz6pyz854j80nlgavjq4mcwr583q6x4myf"))))
   (list "rust-keyboard-types-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/keyboard-types/0.8.3/download")
          (file-name "rust-keyboard-types-0.8.3.tar.gz")
          (sha256 (base32 "13dj6jsk4rr4kqghlxyr3ql7ajfrg65awc1h4c21mris80xqbghg"))))
   (list "rust-khronos-api-3.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/khronos_api/3.1.0/download")
          (file-name "rust-khronos-api-3.1.0.tar.gz")
          (sha256 (base32 "1p0xj5mlbagqyvvnv8wmv3cr7l9y1m153888pxqwg3vk3mg5inz2"))))
   (list "rust-lazycell-1.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/lazycell/1.3.0/download")
          (file-name "rust-lazycell-1.3.0.tar.gz")
          (sha256 (base32 "0m8gw7dn30i0zjjpjdyf6pc16c34nl71lpv461mix50x3p70h3c3"))))
   (list "rust-lazy-static-1.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/lazy_static/1.5.0/download")
          (file-name "rust-lazy-static-1.5.0.tar.gz")
          (sha256 (base32 "1zk6dqqni0193xg6iijh7i3i44sryglwgvx20spdvwk3r6sbrlmv"))))
   (list "rust-lebe-0.5.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/lebe/0.5.3/download")
          (file-name "rust-lebe-0.5.3.tar.gz")
          (sha256 (base32 "1f459clndzzm35nyd15vj5dlasyagfasp7hcgl6lh2b658rs6ybs"))))
   (list "rust-libc-0.2.189.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libc/0.2.189/download")
          (file-name "rust-libc-0.2.189.tar.gz")
          (sha256 (base32 "1whjfs375vlng2q6yrbzs73cvp5lm3w1n2gfqajb2vgf7zg3xbry"))))
   (list "rust-libdisplay-info-sys-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libdisplay-info-sys/0.3.0/download")
          (file-name "rust-libdisplay-info-sys-0.3.0.tar.gz")
          (sha256 (base32 "07xmkc2aqcdn6d58321y87rd3gzdr4nx3ncm1mmrr7w1p1ahsn96"))))
   (list "rust-libdisplay-info-derive-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libdisplay-info-derive/0.1.1/download")
          (file-name "rust-libdisplay-info-derive-0.1.1.tar.gz")
          (sha256 (base32 "162ahw5kry0d7yf50b62dhw18s6c9bkdjim4409fj6aqrw8cghld"))))
   (list "rust-libdisplay-info-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libdisplay-info/0.3.0/download")
          (file-name "rust-libdisplay-info-0.3.0.tar.gz")
          (sha256 (base32 "0nf3c4rpdhgpr8g7dn2wrjyzwl45vz5sq1sg64gz67rqnbdrdzar"))))
   (list "rust-libfuzzer-sys-0.4.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libfuzzer-sys/0.4.13/download")
          (file-name "rust-libfuzzer-sys-0.4.13.tar.gz")
          (sha256 (base32 "1li9z5q55wi81zzyifm7a4rw1xvcclsnqsqbkbvrk86bl50jzzd9"))))
   (list "rust-libloading-0.7.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libloading/0.7.4/download")
          (file-name "rust-libloading-0.7.4.tar.gz")
          (sha256 (base32 "17wbccnjvhjd9ibh019xcd8kjvqws8lqgq86lqkpbgig7gyq0wxn"))))
   (list "rust-libloading-0.8.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libloading/0.8.9/download")
          (file-name "rust-libloading-0.8.9.tar.gz")
          (sha256 (base32 "0mfwxwjwi2cf0plxcd685yxzavlslz7xirss3b9cbrzyk4hv1i6p"))))
   (list "rust-libm-0.2.16.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libm/0.2.16/download")
          (file-name "rust-libm-0.2.16.tar.gz")
          (sha256 (base32 "10brh0a3qjmbzkr5mf5xqi887nhs5y9layvnki89ykz9xb1wxlmn"))))
   (list "rust-libredox-0.1.24.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libredox/0.1.24/download")
          (file-name "rust-libredox-0.1.24.tar.gz")
          (sha256 (base32 "0nhrva4wrys367r8c8yj82k8ny8g3dsj86w9wjr9nf51az0wr034"))))
   (list "rust-libseat-sys-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libseat-sys/0.2.0/download")
          (file-name "rust-libseat-sys-0.2.0.tar.gz")
          (sha256 (base32 "1yvx15lx8qj3xycdx4ddzs681ayhg5vpdvgzsfl64pxy93x89978"))))
   (list "rust-libseat-0.2.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libseat/0.2.4/download")
          (file-name "rust-libseat-0.2.4.tar.gz")
          (sha256 (base32 "0cggn682xklm5h7i8bbjc48wjpys9wz2y8xa7ywgyrh3dsdwcmk6"))))
   (list "rust-lock-api-0.4.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/lock_api/0.4.14/download")
          (file-name "rust-lock-api-0.4.14.tar.gz")
          (sha256 (base32 "0rg9mhx7vdpajfxvdjmgmlyrn20ligzqvn8ifmaz7dc79gkrjhr2"))))
   (list "rust-libudev-sys-0.1.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/libudev-sys/0.1.4/download")
          (file-name "rust-libudev-sys-0.1.4.tar.gz")
          (sha256 (base32 "09236fdzlx9l0dlrsc6xx21v5x8flpfm3d5rjq9jr5ivlas6k11w"))))
   (list "rust-linux-raw-sys-0.4.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/linux-raw-sys/0.4.15/download")
          (file-name "rust-linux-raw-sys-0.4.15.tar.gz")
          (sha256 (base32 "1aq7r2g7786hyxhv40spzf2nhag5xbw2axxc1k8z5k1dsgdm4v6j"))))
   (list "rust-linux-raw-sys-0.12.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/linux-raw-sys/0.12.1/download")
          (file-name "rust-linux-raw-sys-0.12.1.tar.gz")
          (sha256 (base32 "0lwasljrqxjjfk9l2j8lyib1babh2qjlnhylqzl01nihw14nk9ij"))))
   (list "rust-litemap-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/litemap/0.8.3/download")
          (file-name "rust-litemap-0.8.3.tar.gz")
          (sha256 (base32 "1bpgpj87560hmckh3875fbahpmfxbk4g8pzns84h3ykf3nfx3na7"))))
   (list "rust-linux-raw-sys-0.9.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/linux-raw-sys/0.9.4/download")
          (file-name "rust-linux-raw-sys-0.9.4.tar.gz")
          (sha256 (base32 "04kyjdrq79lz9ibrf7czk6cv9d3jl597pb9738vzbsbzy1j5i56d"))))
   (list "rust-log-0.4.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/log/0.4.34/download")
          (file-name "rust-log-0.4.34.tar.gz")
          (sha256 (base32 "1ihkzn0m33ab79fcl4mkb04n5iwqzbxzyw7l7hazqkffaqzbvy7r"))))
   (list "rust-loom-0.7.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/loom/0.7.2/download")
          (file-name "rust-loom-0.7.2.tar.gz")
          (sha256 (base32 "1jpszf9qxv8ydpsm2h9vcyvxvyxcfkhmmfbylzd4gfbc0k40v7j1"))))
   (list "rust-lz4-flex-0.10.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/lz4_flex/0.10.0/download")
          (file-name "rust-lz4-flex-0.10.0.tar.gz")
          (sha256 (base32 "10sgbj93sagbl0ngzqvnlkldzbfz5vnzr7fry8sgssy299cp534b"))))
   (list "rust-memmap2-0.8.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memmap2/0.8.0/download")
          (file-name "rust-memmap2-0.8.0.tar.gz")
          (sha256 (base32 "1vf3djv9s917fbvw5vclllpl22g12iph6cz11gn57ndhxwya19a3"))))
   (list "rust-matchers-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/matchers/0.2.0/download")
          (file-name "rust-matchers-0.2.0.tar.gz")
          (sha256 (base32 "1sasssspdj2vwcwmbq3ra18d3qniapkimfcbr47zmx6750m5llni"))))
   (list "rust-loop9-0.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/loop9/0.1.5/download")
          (file-name "rust-loop9-0.1.5.tar.gz")
          (sha256 (base32 "0qphc1c0cbbx43pwm6isnwzwbg6nsxjh7jah04n1sg5h4p0qgbhg"))))
   (list "rust-memchr-2.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memchr/2.8.3/download")
          (file-name "rust-memchr-2.8.3.tar.gz")
          (sha256 (base32 "161xa63ipfanf8v3nb82xd5hqgydv55nzw59wyngqbz6alfaz2yg"))))
   (list "rust-maybe-rayon-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/maybe-rayon/0.1.1/download")
          (file-name "rust-maybe-rayon-0.1.1.tar.gz")
          (sha256 (base32 "06cmvhj4n36459g327ng5dnj8d58qs472pv5ahlhm7ynxl6g78cf"))))
   (list "rust-memmap2-0.9.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memmap2/0.9.11/download")
          (file-name "rust-memmap2-0.9.11.tar.gz")
          (sha256 (base32 "1h4qnzgarnn488ljjpg9ns5y4bw0sq0xv0fj0iqywagjnz8rw8fi"))))
   (list "rust-memoffset-0.6.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memoffset/0.6.5/download")
          (file-name "rust-memoffset-0.6.5.tar.gz")
          (sha256 (base32 "1kkrzll58a3ayn5zdyy9i1f1v3mx0xgl29x0chq614zazba638ss"))))
   (list "rust-memoffset-0.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/memoffset/0.9.1/download")
          (file-name "rust-memoffset-0.9.1.tar.gz")
          (sha256 (base32 "12i17wh9a9plx869g7j4whf62xw68k5zd4k0k5nh6ys5mszid028"))))
   (list "rust-miniz-oxide-0.9.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/miniz_oxide/0.9.1/download")
          (file-name "rust-miniz-oxide-0.9.1.tar.gz")
          (sha256 (base32 "0k2bgjzk2sbsynpsv4wizwxbqp6vs7g08y5anbkrh3l6a15bqgxn"))))
   (list "rust-miniz-oxide-0.8.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/miniz_oxide/0.8.9/download")
          (file-name "rust-miniz-oxide-0.8.9.tar.gz")
          (sha256 (base32 "05k3pdg8bjjzayq3rf0qhpirq9k37pxnasfn4arbs17phqn6m9qz"))))
   (list "rust-minimal-lexical-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/minimal-lexical/0.2.1/download")
          (file-name "rust-minimal-lexical-0.2.1.tar.gz")
          (sha256 (base32 "16ppc5g84aijpri4jzv14rvcnslvlpphbszc7zzp6vfkddf4qdb8"))))
   (list "rust-moxcms-0.7.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/moxcms/0.7.11/download")
          (file-name "rust-moxcms-0.7.11.tar.gz")
          (sha256 (base32 "15qa5znj029i7677l0hdv0lwmjggrg920bhjgs3cjvydb72mg5dc"))))
   (list "rust-ndk-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ndk/0.9.0/download")
          (file-name "rust-ndk-0.9.0.tar.gz")
          (sha256 (base32 "1m32zpmi5w1pf3j47k6k5fw395dc7aj8d0mdpsv53lqkprxjxx63"))))
   (list "rust-ndk-context-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ndk-context/0.1.1/download")
          (file-name "rust-ndk-context-0.1.1.tar.gz")
          (sha256 (base32 "12sai3dqsblsvfd1l1zab0z6xsnlha3xsfl7kagdnmj3an3jvc17"))))
   (list "rust-nix-0.27.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nix/0.27.1/download")
          (file-name "rust-nix-0.27.1.tar.gz")
          (sha256 (base32 "0ly0kkmij5f0sqz35lx9czlbk6zpihb7yh1bsy4irzwfd2f4xc1f"))))
   (list "rust-new-debug-unreachable-1.0.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/new_debug_unreachable/1.0.6/download")
          (file-name "rust-new-debug-unreachable-1.0.6.tar.gz")
          (sha256 (base32 "11phpf1mjxq6khk91yzcbd3ympm78m3ivl7xg6lg2c0lf66fy3k5"))))
   (list "rust-ndk-sys-0.6.0+11769913.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ndk-sys/0.6.0+11769913/download")
          (file-name "rust-ndk-sys-0.6.0+11769913.tar.gz")
          (sha256 (base32 "0wx8r6pji20if4xs04g73gxl98nmjrfc73z0v6w1ypv6a4qdlv7f"))))
   (list "rust-nom-7.1.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nom/7.1.3/download")
          (file-name "rust-nom-7.1.3.tar.gz")
          (sha256 (base32 "0jha9901wxam390jcf5pfa0qqfrgh8li787jx2ip0yk5b8y9hwyj"))))
   (list "rust-nom-8.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nom/8.0.0/download")
          (file-name "rust-nom-8.0.0.tar.gz")
          (sha256 (base32 "01cl5xng9d0gxf26h39m0l8lprgpa00fcc75ps1yzgbib1vn35yz"))))
   (list "rust-noop-proc-macro-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/noop_proc_macro/0.3.0/download")
          (file-name "rust-noop-proc-macro-0.3.0.tar.gz")
          (sha256 (base32 "1j2v1c6ric4w9v12h34jghzmngcwmn0hll1ywly4h6lcm4rbnxh6"))))
   (list "rust-no-std-io2-0.9.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/no_std_io2/0.9.4/download")
          (file-name "rust-no-std-io2-0.9.4.tar.gz")
          (sha256 (base32 "00w0ggkaaacbwiv4qw188ih5llmhf53qgp20wk5gdyrldldvv2j1"))))
   (list "rust-nu-ansi-term-0.50.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/nu-ansi-term/0.50.3/download")
          (file-name "rust-nu-ansi-term-0.50.3.tar.gz")
          (sha256 (base32 "1ra088d885lbd21q1bxgpqdlk1zlndblmarn948jz2a40xsbjmvr"))))
   (list "rust-num-complex-0.4.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-complex/0.4.6/download")
          (file-name "rust-num-complex-0.4.6.tar.gz")
          (sha256 (base32 "15cla16mnw12xzf5g041nxbjjm9m85hdgadd5dl5d0b30w9qmy3k"))))
   (list "rust-num-derive-0.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-derive/0.4.2/download")
          (file-name "rust-num-derive-0.4.2.tar.gz")
          (sha256 (base32 "00p2am9ma8jgd2v6xpsz621wc7wbn1yqi71g15gc3h67m7qmafgd"))))
   (list "rust-num-bigint-0.4.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-bigint/0.4.8/download")
          (file-name "rust-num-bigint-0.4.8.tar.gz")
          (sha256 (base32 "0ry3xjal8f5xhdinani268ci13h14mf7j4w0y1gflfzhw3knk7n8"))))
   (list "rust-num-enum-0.7.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num_enum/0.7.6/download")
          (file-name "rust-num-enum-0.7.6.tar.gz")
          (sha256 (base32 "09kg0c2y08npdv0c9dbm4m9a9wz8w2qaiqqxl4gj3v22hj1wl2sx"))))
   (list "rust-num-enum-derive-0.7.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num_enum_derive/0.7.6/download")
          (file-name "rust-num-enum-derive-0.7.6.tar.gz")
          (sha256 (base32 "1y0x9z49s27vdas6mglqbv02sgkdmbr8ns2kwspzrp2ra81rh2b8"))))
   (list "rust-num-integer-0.1.47.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-integer/0.1.47/download")
          (file-name "rust-num-integer-0.1.47.tar.gz")
          (sha256 (base32 "02z1p3azy6p10n99skrab4a6hhfd4amf2i9gm8sxqd1p9dfxkqkw"))))
   (list "rust-objc2-app-kit-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-app-kit/0.3.2/download")
          (file-name "rust-objc2-app-kit-0.3.2.tar.gz")
          (sha256 (base32 "132ijwni8lsi8phq7wnmialkxp46zx998fns3zq5np0ya1mr77nl"))))
   (list "rust-objc2-0.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2/0.6.4/download")
          (file-name "rust-objc2-0.6.4.tar.gz")
          (sha256 (base32 "17x8qpl512frscfqbmgjr20kg3y4r0xdqxphja17dz5f0znsh4is"))))
   (list "rust-num-traits-0.2.19.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-traits/0.2.19/download")
          (file-name "rust-num-traits-0.2.19.tar.gz")
          (sha256 (base32 "0h984rhdkkqd4ny9cif7y2azl3xdfb7768hb9irhpsch4q3gq787"))))
   (list "rust-num-rational-0.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/num-rational/0.4.2/download")
          (file-name "rust-num-rational-0.4.2.tar.gz")
          (sha256 (base32 "093qndy02817vpgcqjnj139im3jl7vkq4h68kykdqqh577d18ggq"))))
   (list "rust-objc2-core-foundation-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-core-foundation/0.3.2/download")
          (file-name "rust-objc2-core-foundation-0.3.2.tar.gz")
          (sha256 (base32 "0dnmg7606n4zifyjw4ff554xvjmi256cs8fpgpdmr91gckc0s61a"))))
   (list "rust-objc2-core-graphics-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-core-graphics/0.3.2/download")
          (file-name "rust-objc2-core-graphics-0.3.2.tar.gz")
          (sha256 (base32 "01x8413pxq0m5rwidlaczni8v5cz9dc3xqzq8l9zlpl9cv8cj8p0"))))
   (list "rust-objc2-core-video-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-core-video/0.3.2/download")
          (file-name "rust-objc2-core-video-0.3.2.tar.gz")
          (sha256 (base32 "19j1a7f863gh30nq03w70x1js3f3vdg3wp4azllky8vkvzqwl9fl"))))
   (list "rust-objc2-encode-4.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-encode/4.1.0/download")
          (file-name "rust-objc2-encode-4.1.0.tar.gz")
          (sha256 (base32 "0cqckp4cpf68mxyc2zgnazj8klv0z395nsgbafa61cjgsyyan9gg"))))
   (list "rust-once-cell-1.21.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/once_cell/1.21.4/download")
          (file-name "rust-once-cell-1.21.4.tar.gz")
          (sha256 (base32 "0l1v676wf71kjg2khch4dphwh1jp3291ffiymr2mvy1kxd5kwz4z"))))
   (list "rust-objc2-foundation-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-foundation/0.3.2/download")
          (file-name "rust-objc2-foundation-0.3.2.tar.gz")
          (sha256 (base32 "0wijkxzzvw2xkzssds3fj8279cbykz2rz9agxf6qh7y2agpsvq73"))))
   (list "rust-objc2-ui-kit-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/objc2-ui-kit/0.3.2/download")
          (file-name "rust-objc2-ui-kit-0.3.2.tar.gz")
          (sha256 (base32 "08mbgqg8pffclyxpz2lr8r1fv8wn2i4m1k6bk1s5fvy06f766zfq"))))
   (list "rust-once-cell-polyfill-1.70.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/once_cell_polyfill/1.70.2/download")
          (file-name "rust-once-cell-polyfill-1.70.2.tar.gz")
          (sha256 (base32 "1zmla628f0sk3fhjdjqzgxhalr2xrfna958s632z65bjsfv8ljrq"))))
   (list "rust-oorandom-11.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/oorandom/11.1.5/download")
          (file-name "rust-oorandom-11.1.5.tar.gz")
          (sha256 (base32 "07mlf13z453fq01qff38big1lh83j8l6aaglf63ksqzzqxc0yyfn"))))
   (list "rust-orbclient-0.4.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/orbclient/0.4.6/download")
          (file-name "rust-orbclient-0.4.6.tar.gz")
          (sha256 (base32 "0sry8hmkxv87l056qhkgmnq2zzvgjdlx7pqjg4yj107i72kl1w81"))))
   (list "rust-parking-lot-0.12.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/parking_lot/0.12.5/download")
          (file-name "rust-parking-lot-0.12.5.tar.gz")
          (sha256 (base32 "06jsqh9aqmc94j2rlm8gpccilqm6bskbd67zf6ypfc0f4m9p91ck"))))
   (list "rust-paste-1.0.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/paste/1.0.15/download")
          (file-name "rust-paste-1.0.15.tar.gz")
          (sha256 (base32 "02pxffpdqkapy292harq6asfjvadgp1s005fip9ljfsn9fvxgh2p"))))
   (list "rust-parking-lot-core-0.9.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/parking_lot_core/0.9.12/download")
          (file-name "rust-parking-lot-core-0.9.12.tar.gz")
          (sha256 (base32 "1hb4rggy70fwa1w9nb0svbyflzdc69h047482v2z3sx2hmcnh896"))))
   (list "rust-percent-encoding-2.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/percent-encoding/2.3.2/download")
          (file-name "rust-percent-encoding-2.3.2.tar.gz")
          (sha256 (base32 "083jv1ai930azvawz2khv7w73xh8mnylk7i578cifndjn5y64kwv"))))
   (list "rust-pastey-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pastey/0.1.1/download")
          (file-name "rust-pastey-0.1.1.tar.gz")
          (sha256 (base32 "1v389jkifv757903flrrps67dvc6q6giwlyx3xi33hcfjmgjxyrm"))))
   (list "rust-pin-project-1.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pin-project/1.1.13/download")
          (file-name "rust-pin-project-1.1.13.tar.gz")
          (sha256 (base32 "09091qp946lpmjz4yp0xil1r5v4hgc91fi19dg5csayhdqrv4ri4"))))
   (list "rust-pin-project-internal-1.1.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pin-project-internal/1.1.13/download")
          (file-name "rust-pin-project-internal-1.1.13.tar.gz")
          (sha256 (base32 "12rzlh07i1sdgrvzj6wgkka5bjqyvbfsl8knq6qi7g16m7q9aqy9"))))
   (list "rust-pin-project-lite-0.2.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pin-project-lite/0.2.17/download")
          (file-name "rust-pin-project-lite-0.2.17.tar.gz")
          (sha256 (base32 "1kfmwvs271si96zay4mm8887v5khw0c27jc9srw1a75ykvgj54x8"))))
   (list "rust-pixman-sys-0.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pixman-sys/0.1.0/download")
          (file-name "rust-pixman-sys-0.1.0.tar.gz")
          (sha256 (base32 "1nja8kc7zs1w4lhllvsgssa0b07n4cgwb0zyvqapj7g8i4z4i851"))))
   (list "rust-pixman-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pixman/0.2.1/download")
          (file-name "rust-pixman-0.2.1.tar.gz")
          (sha256 (base32 "1pqybqb7rmd58yr9xvmd8iix30znw5w71cq2wnlc16n1jva1g8nf"))))
   (list "rust-pkg-config-0.3.34.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pkg-config/0.3.34/download")
          (file-name "rust-pkg-config-0.3.34.tar.gz")
          (sha256 (base32 "0j05h08nzg0q8rf6lzw7nry0b7kn7x97vc9n4hwrl52fqzxn9d7n"))))
   (list "rust-plain-0.2.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/plain/0.2.3/download")
          (file-name "rust-plain-0.2.3.tar.gz")
          (sha256 (base32 "19n1xbxb4wa7w891268bzf6cbwq4qvdb86bik1z129qb0xnnnndl"))))
   (list "rust-plotters-backend-0.3.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/plotters-backend/0.3.7/download")
          (file-name "rust-plotters-backend-0.3.7.tar.gz")
          (sha256 (base32 "0ahpliim4hrrf7d4ispc2hwr7rzkn6d6nf7lyyrid2lm28yf2hnz"))))
   (list "rust-plotters-0.3.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/plotters/0.3.7/download")
          (file-name "rust-plotters-0.3.7.tar.gz")
          (sha256 (base32 "0ixpy9svpmr2rkzkxvvdpysjjky4gw104d73n7pi2jbs7m06zsss"))))
   (list "rust-png-0.18.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/png/0.18.1/download")
          (file-name "rust-png-0.18.1.tar.gz")
          (sha256 (base32 "0qca282xp8a6d7mikxrwji3f52mjn4vnqxz2v9iz5adj665rnxk0"))))
   (list "rust-plotters-svg-0.3.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/plotters-svg/0.3.7/download")
          (file-name "rust-plotters-svg-0.3.7.tar.gz")
          (sha256 (base32 "0w56sxaa2crpasa1zj0bhxzihlapqfkncggavyngg0w86anf5fji"))))
   (list "rust-ppv-lite86-0.2.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ppv-lite86/0.2.21/download")
          (file-name "rust-ppv-lite86-0.2.21.tar.gz")
          (sha256 (base32 "1abxx6qz5qnd43br1dd9b2savpihzjza8gb4fbzdql1gxp2f7sl5"))))
   (list "rust-potential-utf-0.1.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/potential_utf/0.1.6/download")
          (file-name "rust-potential-utf-0.1.6.tar.gz")
          (sha256 (base32 "0qbndl2fpphq7mph41m11vaixs05xrh1s451wxlgap4fdnybjgnq"))))
   (list "rust-portable-atomic-1.15.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/portable-atomic/1.15.0/download")
          (file-name "rust-portable-atomic-1.15.0.tar.gz")
          (sha256 (base32 "11csag858ndk5w4yz17h91vy53ynh67r2903gwwdn2cnilzbdj05"))))
   (list "rust-polling-3.11.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/polling/3.11.0/download")
          (file-name "rust-polling-3.11.0.tar.gz")
          (sha256 (base32 "0622qfbxi3gb0ly2c99n3xawp878fkrd1sl83hjdhisx11cly3jx"))))
   (list "rust-prettyplease-0.2.37.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/prettyplease/0.2.37/download")
          (file-name "rust-prettyplease-0.2.37.tar.gz")
          (sha256 (base32 "0azn11i1kh0byabhsgab6kqs74zyrg69xkirzgqyhz6xmjnsi727"))))
   (list "rust-proc-macro2-1.0.107.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proc-macro2/1.0.107/download")
          (file-name "rust-proc-macro2-1.0.107.tar.gz")
          (sha256 (base32 "1nb6ly8kp65f724kj73ippc7lvydss24sm2vagk6qpklpg4pwplq"))))
   (list "rust-proc-macro-crate-3.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/proc-macro-crate/3.5.0/download")
          (file-name "rust-proc-macro-crate-3.5.0.tar.gz")
          (sha256 (base32 "0kv1g1d1zjwxlgcaba2qlshzyy32j03xic8rskqlcr5mnblsfyz6"))))
   (list "rust-profiling-procmacros-1.0.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/profiling-procmacros/1.0.18/download")
          (file-name "rust-profiling-procmacros-1.0.18.tar.gz")
          (sha256 (base32 "1jxvqff6j1z7ph3qghw2xhv18z7pf6cs6cja6fwscjwsdfis9224"))))
   (list "rust-profiling-1.0.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/profiling/1.0.18/download")
          (file-name "rust-profiling-1.0.18.tar.gz")
          (sha256 (base32 "1xdwlvxlgy99nn1dra7arzinkc8lbqljvcwpq70m7g16lda5wn9x"))))
   (list "rust-pulp-wasm-simd-flag-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pulp-wasm-simd-flag/0.1.1/download")
          (file-name "rust-pulp-wasm-simd-flag-0.1.1.tar.gz")
          (sha256 (base32 "0h67yf9psibw4768lihrcidsdfqiqnhrrrblbaa64fcwggh713qx"))))
   (list "rust-puffin-http-0.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/puffin_http/0.13.0/download")
          (file-name "rust-puffin-http-0.13.0.tar.gz")
          (sha256 (base32 "14w1ihjlv48mpbh114yvgixdqdnzzipnmsg158l3v49m1ihgrgqk"))))
   (list "rust-puffin-0.20.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/puffin/0.20.0/download")
          (file-name "rust-puffin-0.20.0.tar.gz")
          (sha256 (base32 "0ja0mnjhgz4hcqfms3vmv50lhjjgjwfgz8g8zl0yi2r5bbci9dc4"))))
   (list "rust-pxfm-0.1.30.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pxfm/0.1.30/download")
          (file-name "rust-pxfm-0.1.30.tar.gz")
          (sha256 (base32 "1slrnbxd0nc96sny6x50ss1sm9ci0gig0fp1w8mw0pkgm5prapfm"))))
   (list "rust-puffin-0.16.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/puffin/0.16.0/download")
          (file-name "rust-puffin-0.16.0.tar.gz")
          (sha256 (base32 "08ass1hfdcq86y7dywa1jylzq57la95rgpcmd6yx82hs9symlhkn"))))
   (list "rust-pulp-0.22.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/pulp/0.22.3/download")
          (file-name "rust-pulp-0.22.3.tar.gz")
          (sha256 (base32 "0sj9294yb8yr6z7vdlx467cfs4vvcwnygj0p8wpfqhlnk1ds8sh4"))))
   (list "rust-qoi-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/qoi/0.4.1/download")
          (file-name "rust-qoi-0.4.1.tar.gz")
          (sha256 (base32 "00c0wkb112annn2wl72ixyd78mf56p4lxkhlmsggx65l3v3n8vbz"))))
   (list "rust-rand-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand/0.10.3/download")
          (file-name "rust-rand-0.10.3.tar.gz")
          (sha256 (base32 "1bxlhj4m9zrgfgk1yirf0nny86izrngscydfx9w387n9rfbgpjb5"))))
   (list "rust-quote-1.0.47.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/quote/1.0.47/download")
          (file-name "rust-quote-1.0.47.tar.gz")
          (sha256 (base32 "00ch0yyzvv6s671ik0kcsbw8nigdaj2g3fr61kcahwx48aqlvgqz"))))
   (list "rust-quick-xml-0.41.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/quick-xml/0.41.0/download")
          (file-name "rust-quick-xml-0.41.0.tar.gz")
          (sha256 (base32 "1h9y8zry34r3mxfd5vqfj50vvvzvri4kzbx5d657jkqjalg4aq76"))))
   (list "rust-quick-error-2.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/quick-error/2.0.1/download")
          (file-name "rust-quick-error-2.0.1.tar.gz")
          (sha256 (base32 "18z6r2rcjvvf8cn92xjhm2qc3jpd1ljvcbf12zv0k9p565gmb4x9"))))
   (list "rust-rand-0.8.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand/0.8.8/download")
          (file-name "rust-rand-0.8.8.tar.gz")
          (sha256 (base32 "0k3d9psya5icpiylff1w1wjbnc3q4pb1953n1iw7gbr61ggcfn70"))))
   (list "rust-rand-0.9.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand/0.9.5/download")
          (file-name "rust-rand-0.9.5.tar.gz")
          (sha256 (base32 "0hbvllk8g28mqjld6hqmckk69w296qpzg95whm3didsyg46ivvxr"))))
   (list "rust-rand-chacha-0.3.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_chacha/0.3.1/download")
          (file-name "rust-rand-chacha-0.3.1.tar.gz")
          (sha256 (base32 "123x2adin558xbhvqb8w4f6syjsdkmqff8cxwhmjacpsl1ihmhg6"))))
   (list "rust-rand-chacha-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_chacha/0.9.0/download")
          (file-name "rust-rand-chacha-0.9.0.tar.gz")
          (sha256 (base32 "1jr5ygix7r60pz0s1cv3ms1f6pd1i9pcdmnxzzhjc3zn3mgjn0nk"))))
   (list "rust-rand-core-0.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_core/0.6.4/download")
          (file-name "rust-rand-core-0.6.4.tar.gz")
          (sha256 (base32 "0b4j2v4cb5krak1pv6kakv4sz6xcwbrmy2zckc32hsigbrwy82zc"))))
   (list "rust-rand-core-0.9.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_core/0.9.5/download")
          (file-name "rust-rand-core-0.9.5.tar.gz")
          (sha256 (base32 "0g6qc5r3f0hdmz9b11nripyp9qqrzb0xqk9piip8w8qlvqkcibvn"))))
   (list "rust-rand-core-0.10.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rand_core/0.10.1/download")
          (file-name "rust-rand-core-0.10.1.tar.gz")
          (sha256 (base32 "0s9wiacxrr100icl7i41308gcj85nlcclrc5jx1jd6p10dhigf33"))))
   (list "rust-rav1e-0.8.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rav1e/0.8.1/download")
          (file-name "rust-rav1e-0.8.1.tar.gz")
          (sha256 (base32 "0axk3ji3jmlr81svmsy5zvj8shmhpp8lz5nyghkq752xx1bdvdj3"))))
   (list "rust-ravif-0.12.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/ravif/0.12.0/download")
          (file-name "rust-ravif-0.12.0.tar.gz")
          (sha256 (base32 "11dj99rsrdjp12yn4xchxsb78prsg5s8x4smd08qmwgf1jcw2sgg"))))
   (list "rust-raw-cpuid-11.6.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/raw-cpuid/11.6.0/download")
          (file-name "rust-raw-cpuid-11.6.0.tar.gz")
          (sha256 (base32 "11j1lmrjqqnc43bxkrz0xai1g9piw3z9aap53qsj8cnpb7fd1329"))))
   (list "rust-raw-window-handle-0.6.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/raw-window-handle/0.6.2/download")
          (file-name "rust-raw-window-handle-0.6.2.tar.gz")
          (sha256 (base32 "0ff5c648hncwx7hm2a8fqgqlbvbl4xawb6v3xxv9wkpjyrr5arr0"))))
   (list "rust-reborrow-0.5.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/reborrow/0.5.5/download")
          (file-name "rust-reborrow-0.5.5.tar.gz")
          (sha256 (base32 "0c14ccj3fdf47a1ya21bkxqv7s2hxrcfhaw98aqd6jqg029i2983"))))
   (list "rust-rayon-1.12.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rayon/1.12.0/download")
          (file-name "rust-rayon-1.12.0.tar.gz")
          (sha256 (base32 "0vcj63xgnk72c30vdrak7dhl53snnaqv9x2faf1d94hzg1kb2fgv"))))
   (list "rust-rayon-core-1.13.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rayon-core/1.13.0/download")
          (file-name "rust-rayon-core-1.13.0.tar.gz")
          (sha256 (base32 "14dbr0sq83a6lf1rfjq5xdpk5r6zgzvmzs5j6110vlv2007qpq92"))))
   (list "rust-redox-syscall-0.5.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/redox_syscall/0.5.18/download")
          (file-name "rust-redox-syscall-0.5.18.tar.gz")
          (sha256 (base32 "0b9n38zsxylql36vybw18if68yc9jczxmbyzdwyhb9sifmag4azd"))))
   (list "rust-redox-syscall-0.9.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/redox_syscall/0.9.4/download")
          (file-name "rust-redox-syscall-0.9.4.tar.gz")
          (sha256 (base32 "03p257wq9i52i5h5ns9v0xx03fycgcq17bdcwwqzmil7ka9p0ybk"))))
   (list "rust-redox-event-0.4.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/redox_event/0.4.8/download")
          (file-name "rust-redox-event-0.4.8.tar.gz")
          (sha256 (base32 "058v00q7mfnmd60wf5xb0gmx2rwhgqbqvsia6ncm8bvd7mc8s0f5"))))
   (list "rust-r-efi-5.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/r-efi/5.3.0/download")
          (file-name "rust-r-efi-5.3.0.tar.gz")
          (sha256 (base32 "03sbfm3g7myvzyylff6qaxk4z6fy76yv860yy66jiswc2m6b7kb9"))))
   (list "rust-r-efi-6.0.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/r-efi/6.0.0/download")
          (file-name "rust-r-efi-6.0.0.tar.gz")
          (sha256 (base32 "1gyrl2k5fyzj9k7kchg2n296z5881lg7070msabid09asp3wkp7q"))))
   (list "rust-regex-1.13.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/regex/1.13.1/download")
          (file-name "rust-regex-1.13.1.tar.gz")
          (sha256 (base32 "1391a0a4100ik8cp7l577p3ip3haqq03rd9c5vdr7vcfdixj687h"))))
   (list "rust-regex-syntax-0.8.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/regex-syntax/0.8.11/download")
          (file-name "rust-regex-syntax-0.8.11.tar.gz")
          (sha256 (base32 "1m25h5q2wp976fb9gc3dsc9l99svcvd5cri8lncb51c46ydgzxnn"))))
   (list "rust-regex-automata-0.4.18.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/regex-automata/0.4.18/download")
          (file-name "rust-regex-automata-0.4.18.tar.gz")
          (sha256 (base32 "1cml0rm0ssqfkibh9nh3gy4b6hbsbicj1rihpwf2a4v4nawm71dd"))))
   (list "rust-reis-0.7.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/reis/0.7.1/download")
          (file-name "rust-reis-0.7.1.tar.gz")
          (sha256 (base32 "0pzqwqzbjpyjmzhwnwv8g7m7hqdrgfc12kvj41x0chls9337x5jb"))))
   (list "rust-renderdoc-sys-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/renderdoc-sys/1.1.0/download")
          (file-name "rust-renderdoc-sys-1.1.0.tar.gz")
          (sha256 (base32 "0cj8zjs7k0gvchcx3jhpg8r9bbqy8b1hsgbz0flcq2ydn12hmcqr"))))
   (list "rust-renderdoc-0.11.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/renderdoc/0.11.0/download")
          (file-name "rust-renderdoc-0.11.0.tar.gz")
          (sha256 (base32 "04hycbzwqmzw25qnk0lwps70jgxi43cgmkjdvwbyzc183vnajb97"))))
   (list "rust-rgb-0.8.53.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rgb/0.8.53/download")
          (file-name "rust-rgb-0.8.53.tar.gz")
          (sha256 (base32 "1i0c55whln68zs6f5qqrkbg1mzai0p3qk1mwkwzdgr9i3dw4pcs7"))))
   (list "rust-rustc-hash-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustc-hash/1.1.0/download")
          (file-name "rust-rustc-hash-1.1.0.tar.gz")
          (sha256 (base32 "1qkc5khrmv5pqi5l5ca9p5nl5hs742cagrndhbrlk3dhlrx3zm08"))))
   (list "rust-rustc-version-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustc_version/0.4.1/download")
          (file-name "rust-rustc-version-0.4.1.tar.gz")
          (sha256 (base32 "14lvdsmr5si5qbqzrajgb6vfn69k0sfygrvfvr2mps26xwi3mjyg"))))
   (list "rust-rustc-hash-2.1.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustc-hash/2.1.3/download")
          (file-name "rust-rustc-hash-2.1.3.tar.gz")
          (sha256 (base32 "0bbla578m87qmf3yr55q49l97gxn7z0ha1dwqlnvwwc58ad7y7kb"))))
   (list "rust-rustix-0.38.44.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustix/0.38.44/download")
          (file-name "rust-rustix-0.38.44.tar.gz")
          (sha256 (base32 "0m61v0h15lf5rrnbjhcb9306bgqrhskrqv7i1n0939dsw8dbrdgx"))))
   (list "rust-rustix-1.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustix/1.1.5/download")
          (file-name "rust-rustix-1.1.5.tar.gz")
          (sha256 (base32 "17b2srw7rcqmrs1shj89g8i3r1447lihv7qrbxvp11j1psxgl7l9"))))
   (list "rust-rustversion-1.0.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/rustversion/1.0.23/download")
          (file-name "rust-rustversion-1.0.23.tar.gz")
          (sha256 (base32 "07z2a843fs80fawwflj9jwn49k9b0bd0dhhbvy0ar69vaxd72m6g"))))
   (list "rust-same-file-1.0.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/same-file/1.0.6/download")
          (file-name "rust-same-file-1.0.6.tar.gz")
          (sha256 (base32 "00h5j1w87dmhnvbv9l8bic3y7xxsnjmssvifw2ayvgx9mb1ivz4k"))))
   (list "rust-scoped-tls-1.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/scoped-tls/1.0.1/download")
          (file-name "rust-scoped-tls-1.0.1.tar.gz")
          (sha256 (base32 "15524h04mafihcvfpgxd8f4bgc3k95aclz8grjkg9a0rxcvn9kz1"))))
   (list "rust-scopeguard-1.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/scopeguard/1.2.0/download")
          (file-name "rust-scopeguard-1.2.0.tar.gz")
          (sha256 (base32 "0jcz9sd47zlsgcnm1hdw0664krxwb5gczlif4qngj2aif8vky54l"))))
   (list "rust-serde-core-1.0.229.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_core/1.0.229/download")
          (file-name "rust-serde-core-1.0.229.tar.gz")
          (sha256 (base32 "0j1ajiha76h3nmd976il9li6975k121xa7jb39ws8n0yqp4s5p37"))))
   (list "rust-semver-1.0.28.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/semver/1.0.28/download")
          (file-name "rust-semver-1.0.28.tar.gz")
          (sha256 (base32 "1kaimrpy876bcgi8bfj0qqfxk77zm9iz2zhn1hp9hj685z854y4a"))))
   (list "rust-serde-1.0.229.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde/1.0.229/download")
          (file-name "rust-serde-1.0.229.tar.gz")
          (sha256 (base32 "1fp04fq4a79bpm61xz1zy0pbz4kpc7d771zii1k3inmszq55jj21"))))
   (list "rust-serde-derive-1.0.229.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_derive/1.0.229/download")
          (file-name "rust-serde-derive-1.0.229.tar.gz")
          (sha256 (base32 "0j4k63i7h1bikxwz2c89ig0hrwbnl9mz1czn85xx99x5cc9dg9g7"))))
   (list "rust-serde-json-1.0.151.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_json/1.0.151/download")
          (file-name "rust-serde-json-1.0.151.tar.gz")
          (sha256 (base32 "051zww7lvpw147vvwss1ng6w587qyrkzg75fvj08q2dfrmgbahf8"))))
   (list "rust-serde-spanned-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/serde_spanned/1.1.1/download")
          (file-name "rust-serde-spanned-1.1.1.tar.gz")
          (sha256 (base32 "09jzk7i6wihn3d8i3wi4j4n98ghi93c3b8m8k64nxq0ijn3vaqk6"))))
   (list "rust-sha2-0.10.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/sha2/0.10.9/download")
          (file-name "rust-sha2-0.10.9.tar.gz")
          (sha256 (base32 "10xjj843v31ghsksd9sl9y12qfc48157j1xpb8v1ml39jy0psl57"))))
   (list "rust-sharded-slab-0.1.7.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/sharded-slab/0.1.7/download")
          (file-name "rust-sharded-slab-0.1.7.tar.gz")
          (sha256 (base32 "1xipjr4nqsgw34k7a2cgj9zaasl2ds6jwn89886kww93d32a637l"))))
   (list "rust-shlex-1.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/shlex/1.3.0/download")
          (file-name "rust-shlex-1.3.0.tar.gz")
          (sha256 (base32 "0r1y6bv26c1scpxvhg2cabimrmwgbp4p3wy6syj9n0c4s3q2znhg"))))
   (list "rust-shlex-2.0.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/shlex/2.0.1/download")
          (file-name "rust-shlex-2.0.1.tar.gz")
          (sha256 (base32 "1fjsll1cd7d2bcpdij9kd6w62rpbc7qqzvydvs021vsmr1cxvypq"))))
   (list "rust-simd-adler32-0.3.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simd-adler32/0.3.10/download")
          (file-name "rust-simd-adler32-0.3.10.tar.gz")
          (sha256 (base32 "1sny4y2qa5mwyxx5x59ln2p02vsdh92004njlslnx98imjc9489s"))))
   (list "rust-simd-cesu8-1.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simd_cesu8/1.2.0/download")
          (file-name "rust-simd-cesu8-1.2.0.tar.gz")
          (sha256 (base32 "0865mv3nmd35f1dccjcfj7dncjmmvvdij3j61z4131mz38jiw0qi"))))
   (list "rust-simd-helpers-0.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simd_helpers/0.1.0/download")
          (file-name "rust-simd-helpers-0.1.0.tar.gz")
          (sha256 (base32 "19idqicn9k4vhd04ifh2ff41wvna79zphdf2c81rlmpc7f3hz2cm"))))
   (list "rust-simdutf8-0.1.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/simdutf8/0.1.5/download")
          (file-name "rust-simdutf8-0.1.5.tar.gz")
          (sha256 (base32 "0vmpf7xaa0dnaikib5jlx6y4dxd3hxqz6l830qb079g7wcsgxag3"))))
   (list "rust-slab-0.4.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/slab/0.4.12/download")
          (file-name "rust-slab-0.4.12.tar.gz")
          (sha256 (base32 "1xcwik6s6zbd3lf51kkrcicdq2j4c1fw0yjdai2apy9467i0sy8c"))))
   (list "rust-slotmap-1.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/slotmap/1.1.1/download")
          (file-name "rust-slotmap-1.1.1.tar.gz")
          (sha256 (base32 "0f20xf53zaysx9ydzkwwqm6hsjyb8lj2j6amhg57iln3jcy8rmdx"))))
   (list "rust-smallvec-1.16.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smallvec/1.16.1/download")
          (file-name "rust-smallvec-1.16.1.tar.gz")
          (sha256 (base32 "14gqvsqdli51r1bii3hfqv5vx1b9r0gic4br0x9fsixmy5b70ims"))))
   (list "rust-smithay-client-toolkit-0.19.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smithay-client-toolkit/0.19.2/download")
          (file-name "rust-smithay-client-toolkit-0.19.2.tar.gz")
          (sha256 (base32 "05h05hg4dn3v6br5jbdbs5nalk076a64s7fn6i01nqzby2hxwmrl"))))
   (list "rust-smithay-client-toolkit-0.21.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smithay-client-toolkit/0.21.1/download")
          (file-name "rust-smithay-client-toolkit-0.21.1.tar.gz")
          (sha256 (base32 "003zc6547msmwh729lkpm6acjw60rax42qamz4svbp0g9ghrxp3l"))))
   (list "rust-stable-deref-trait-1.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/stable_deref_trait/1.2.1/download")
          (file-name "rust-stable-deref-trait-1.2.1.tar.gz")
          (sha256 (base32 "15h5h73ppqyhdhx6ywxfj88azmrpml9gl6zp3pwy2malqa6vxqkc"))))
   (list "rust-smol-str-0.3.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/smol_str/0.3.2/download")
          (file-name "rust-smol-str-0.3.2.tar.gz")
          (sha256 (base32 "039mj6lc1vkljj17ndlzzkak8kvlmw8ppi6yjdxsh433snfbhxln"))))
   (list "rust-strsim-0.11.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/strsim/0.11.1/download")
          (file-name "rust-strsim-0.11.1.tar.gz")
          (sha256 (base32 "0kzvqlw8hxqb7y598w1s0hxlnmi84sg5vsipp3yg5na5d1rvba3x"))))
   (list "rust-syn-3.0.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/syn/3.0.6/download")
          (file-name "rust-syn-3.0.6.tar.gz")
          (sha256 (base32 "1vmw7s58rzrs926nv5m06x7qbgswm1aa9iw3s1bj5var47kyi4w5"))))
   (list "rust-syn-2.0.119.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/syn/2.0.119/download")
          (file-name "rust-syn-2.0.119.tar.gz")
          (sha256 (base32 "15vjy620l91a3q4n4f4gzhnflmdr6pnm38v2m6cpk86i8av32a47"))))
   (list "rust-synstructure-0.14.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/synstructure/0.14.0/download")
          (file-name "rust-synstructure-0.14.0.tar.gz")
          (sha256 (base32 "00kzyz38xqvs7x1dn6rp64y0ckly4m7ywf3qk3qkgqfzs3nh85wh"))))
   (list "rust-system-deps-7.0.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/system-deps/7.0.8/download")
          (file-name "rust-system-deps-7.0.8.tar.gz")
          (sha256 (base32 "1rwnfw9dm6ck65a7lfjfpn2c91gwj88brz2i09z3fdbknvz3asir"))))
   (list "rust-target-lexicon-0.13.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/target-lexicon/0.13.5/download")
          (file-name "rust-target-lexicon-0.13.5.tar.gz")
          (sha256 (base32 "1jm6lmf9hsn7ri2d6v9gg6fy24lylhskh6pbxh71f82wdxd97dmd"))))
   (list "rust-tempfile-3.27.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tempfile/3.27.0/download")
          (file-name "rust-tempfile-3.27.0.tar.gz")
          (sha256 (base32 "1gblhnyfjsbg9wjg194n89wrzah7jy3yzgnyzhp56f3v9jd7wj9j"))))
   (list "rust-thiserror-1.0.69.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror/1.0.69/download")
          (file-name "rust-thiserror-1.0.69.tar.gz")
          (sha256 (base32 "0lizjay08agcr5hs9yfzzj6axs53a2rgx070a1dsi3jpkcrzbamn"))))
   (list "rust-thiserror-2.0.20.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror/2.0.20/download")
          (file-name "rust-thiserror-2.0.20.tar.gz")
          (sha256 (base32 "0kxs6p295jffxhzaxpxv1dwaaf5iqlm6sx8h0djp6ancbxgj71pc"))))
   (list "rust-thiserror-impl-2.0.20.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror-impl/2.0.20/download")
          (file-name "rust-thiserror-impl-2.0.20.tar.gz")
          (sha256 (base32 "1bwjc94gi0xn5jz26h1a8bjj1wdkvvr6jifamyc4mp9n28zcs15w"))))
   (list "rust-thiserror-impl-1.0.69.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thiserror-impl/1.0.69/download")
          (file-name "rust-thiserror-impl-1.0.69.tar.gz")
          (sha256 (base32 "1h84fmn2nai41cxbhk6pqf46bxqq1b344v8yz089w1chzi76rvjg"))))
   (list "rust-thread-local-1.1.10.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/thread_local/1.1.10/download")
          (file-name "rust-thread-local-1.1.10.tar.gz")
          (sha256 (base32 "0w20g2pfdcp8pz3gds0bzksv6mxk802szca8qlr3701jdm69rn8s"))))
   (list "rust-tinystr-0.8.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tinystr/0.8.4/download")
          (file-name "rust-tinystr-0.8.4.tar.gz")
          (sha256 (base32 "0hzncw8rgk4syla79qscfml46jm7ll1zdp7kdacc42cj8n8prqmi"))))
   (list "rust-tinytemplate-1.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tinytemplate/1.2.1/download")
          (file-name "rust-tinytemplate-1.2.1.tar.gz")
          (sha256 (base32 "1g5n77cqkdh9hy75zdb01adxn45mkh9y40wdr7l68xpz35gnnkdy"))))
   (list "rust-tiff-0.10.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tiff/0.10.3/download")
          (file-name "rust-tiff-0.10.3.tar.gz")
          (sha256 (base32 "0vrkdk9cdk07rh7iifcxpn6m8zv3wz695mizhr8rb3gfgzg0b5mg"))))
   (list "rust-toml-1.1.6+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml/1.1.6+spec-1.1.0/download")
          (file-name "rust-toml-1.1.6+spec-1.1.0.tar.gz")
          (sha256 (base32 "0sj0g89pyrkm9g5zaaqsdlclr98xf1chvi8jv9qsn4897xa041lj"))))
   (list "rust-toml-datetime-1.1.1+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_datetime/1.1.1+spec-1.1.0/download")
          (file-name "rust-toml-datetime-1.1.1+spec-1.1.0.tar.gz")
          (sha256 (base32 "1mws2mkkf46l7inn77azhm0vdwxngv9vsbhbl0ah33p2c9gzcr9i"))))
   (list "rust-toml-parser-1.1.3+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_parser/1.1.3+spec-1.1.0/download")
          (file-name "rust-toml-parser-1.1.3+spec-1.1.0.tar.gz")
          (sha256 (base32 "0mjdvihdkmjd4ykh574xgii71hpxw7ns7h4n4bisqpxrz4faqf0x"))))
   (list "rust-toml-edit-0.25.15+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_edit/0.25.15+spec-1.1.0/download")
          (file-name "rust-toml-edit-0.25.15+spec-1.1.0.tar.gz")
          (sha256 (base32 "0556lgzcvgfy16b8sxskr391s6cbfwnb0r4h5i4k6qw5lnaflh0k"))))
   (list "rust-toml-writer-1.1.2+spec-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/toml_writer/1.1.2+spec-1.1.0/download")
          (file-name "rust-toml-writer-1.1.2+spec-1.1.0.tar.gz")
          (sha256 (base32 "1lk6pqf9mac3v1x6282n6a66qx5b18c8f4a23bsd0nk658x3amkx"))))
   (list "rust-tracing-core-0.1.36.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-core/0.1.36/download")
          (file-name "rust-tracing-core-0.1.36.tar.gz")
          (sha256 (base32 "16mpbz6p8vd6j7sf925k9k8wzvm9vdfsjbynbmaxxyq6v7wwm5yv"))))
   (list "rust-tracing-log-0.2.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-log/0.2.0/download")
          (file-name "rust-tracing-log-0.2.0.tar.gz")
          (sha256 (base32 "1hs77z026k730ij1a9dhahzrl0s073gfa2hm5p0fbl0b80gmz1gf"))))
   (list "rust-tracing-attributes-0.1.31.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-attributes/0.1.31/download")
          (file-name "rust-tracing-attributes-0.1.31.tar.gz")
          (sha256 (base32 "1np8d77shfvz0n7camx2bsf1qw0zg331lra0hxb4cdwnxjjwz43l"))))
   (list "rust-tracing-0.1.44.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing/0.1.44/download")
          (file-name "rust-tracing-0.1.44.tar.gz")
          (sha256 (base32 "006ilqkg1lmfdh3xhg3z762izfwmxcvz0w7m4qx2qajbz9i1drv3"))))
   (list "rust-tracing-subscriber-0.3.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracing-subscriber/0.3.23/download")
          (file-name "rust-tracing-subscriber-0.3.23.tar.gz")
          (sha256 (base32 "06fkr0qhggvrs861d7f74pn3i3a10h5jsp4n70jj9ys5b675fzyb"))))
   (list "rust-tracy-client-sys-0.29.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracy-client-sys/0.29.0/download")
          (file-name "rust-tracy-client-sys-0.29.0.tar.gz")
          (sha256 (base32 "0y9k8c5blf41yrgl15sm8ypr21cg676hnbis85l4q8ckn1kz29xb"))))
   (list "rust-tracy-client-0.18.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/tracy-client/0.18.5/download")
          (file-name "rust-tracy-client-0.18.5.tar.gz")
          (sha256 (base32 "1q4w2qrhxrlhkc49j396hwk5x8bv882v0kpb0zs9djz2ycprjcb1"))))
   (list "rust-typenum-1.20.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/typenum/1.20.1/download")
          (file-name "rust-typenum-1.20.1.tar.gz")
          (sha256 (base32 "086s9ly0906kw5yw41249fba97w5zfxf03pyfwdkffvcprqfixdn"))))
   (list "rust-udev-0.9.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/udev/0.9.3/download")
          (file-name "rust-udev-0.9.3.tar.gz")
          (sha256 (base32 "17vy1yc6ipb5m2kc2d4lx2qpj45yr7grsjzm3y2gq0a4xblkfkmg"))))
   (list "rust-unicode-ident-1.0.26.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-ident/1.0.26/download")
          (file-name "rust-unicode-ident-1.0.26.tar.gz")
          (sha256 (base32 "0m3915ipi4zz7isncf5k1dz47ys0nq9j7l4l2n2rm03zaxwg8ifj"))))
   (list "rust-unicode-segmentation-1.13.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/unicode-segmentation/1.13.3/download")
          (file-name "rust-unicode-segmentation-1.13.3.tar.gz")
          (sha256 (base32 "1a47zaq83p386r3baq4m018xd5q4q0grdg56i1x042dzn71x7xf6"))))
   (list "rust-utf8-iter-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/utf8_iter/1.0.4/download")
          (file-name "rust-utf8-iter-1.0.4.tar.gz")
          (sha256 (base32 "1gmna9flnj8dbyd8ba17zigrp9c4c3zclngf5lnb5yvz1ri41hdn"))))
   (list "rust-url-2.5.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/url/2.5.8/download")
          (file-name "rust-url-2.5.8.tar.gz")
          (sha256 (base32 "1v8f7nx3hpr1qh76if0a04sj08k86amsq4h8cvpw6wvk76jahrzz"))))
   (list "rust-utf8parse-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/utf8parse/0.2.2/download")
          (file-name "rust-utf8parse-0.2.2.tar.gz")
          (sha256 (base32 "088807qwjq46azicqwbhlmzwrbkz7l4hpw43sdkdyyk524vdxaq6"))))
   (list "rust-version-check-0.9.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/version_check/0.9.5/download")
          (file-name "rust-version-check-0.9.5.tar.gz")
          (sha256 (base32 "0nhhi4i5x89gm911azqbn7avs9mdacw2i3vcz3cnmz3mv4rqz4hb"))))
   (list "rust-valuable-0.1.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/valuable/0.1.1/download")
          (file-name "rust-valuable-0.1.1.tar.gz")
          (sha256 (base32 "0r9srp55v7g27s5bg7a2m095fzckrcdca5maih6dy9bay6fflwxs"))))
   (list "rust-walkdir-2.5.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/walkdir/2.5.0/download")
          (file-name "rust-walkdir-2.5.0.tar.gz")
          (sha256 (base32 "0jsy7a710qv8gld5957ybrnc07gavppp963gs32xk4ag8130jy99"))))
   (list "rust-version-compare-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/version-compare/0.2.1/download")
          (file-name "rust-version-compare-0.2.1.tar.gz")
          (sha256 (base32 "03nziqxwnxlizl42cwsx33vi5xd2cf2jnszhh9rzay7g6xl8bhh3"))))
   (list "rust-v-frame-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/v_frame/0.3.9/download")
          (file-name "rust-v-frame-0.3.9.tar.gz")
          (sha256 (base32 "1qkvb4ks33zck931vzqckjn36hkngj6l2cwmvfsnlpc7r0kpfsv6"))))
   (list "rust-wasi-0.11.1+wasi-snapshot-preview1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasi/0.11.1+wasi-snapshot-preview1/download")
          (file-name "rust-wasi-0.11.1+wasi-snapshot-preview1.tar.gz")
          (sha256 (base32 "0jx49r7nbkbhyfrfyhz0bm4817yrnxgd3jiwwwfv0zl439jyrwyc"))))
   (list "rust-wasm-bindgen-futures-0.4.78.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-futures/0.4.78/download")
          (file-name "rust-wasm-bindgen-futures-0.4.78.tar.gz")
          (sha256 (base32 "0a6r1q1v2qvi3ypmy0nva3il422iyml1f61i897wbxfdsb9wbx3f"))))
   (list "rust-wasm-bindgen-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen/0.2.128/download")
          (file-name "rust-wasm-bindgen-0.2.128.tar.gz")
          (sha256 (base32 "1gsi4ggm03dqr3j9bcc1sbxzmkw6ykm3cqx4g8xmw31v7niqgjxf"))))
   (list "rust-wasip2-1.0.4+wasi-0.2.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasip2/1.0.4+wasi-0.2.12/download")
          (file-name "rust-wasip2-1.0.4+wasi-0.2.12.tar.gz")
          (sha256 (base32 "11wl7lqwq4pbmlmzr6n7bwz0hzy1z6sxc4554bkmrr86w4vznzmn"))))
   (list "rust-wasm-bindgen-macro-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-macro/0.2.128/download")
          (file-name "rust-wasm-bindgen-macro-0.2.128.tar.gz")
          (sha256 (base32 "1vdrjrb7yqh8p0r0yr93rlaq9iq05hy1wl9kbsjv7a61wc8xb456"))))
   (list "rust-wayland-backend-0.3.17.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-backend/0.3.17/download")
          (file-name "rust-wayland-backend-0.3.17.tar.gz")
          (sha256 (base32 "0y50cw56f09cdcsinbbl94naz91xf7iqaj87s4f7py6zmm71pa9q"))))
   (list "rust-wasm-bindgen-macro-support-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-macro-support/0.2.128/download")
          (file-name "rust-wasm-bindgen-macro-support-0.2.128.tar.gz")
          (sha256 (base32 "12p4jm9dr88h1j5sglycizvvxvr05pgmz7aa2v9g47h7y23lh7j1"))))
   (list "rust-wasm-bindgen-shared-0.2.128.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wasm-bindgen-shared/0.2.128/download")
          (file-name "rust-wasm-bindgen-shared-0.2.128.tar.gz")
          (sha256 (base32 "0ghh8hqx038h9c9zj1rlmzlv2k2shh917q756dn054hcipbir541"))))
   (list "rust-wayland-client-0.31.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-client/0.31.15/download")
          (file-name "rust-wayland-client-0.31.15.tar.gz")
          (sha256 (base32 "0ww0d0r6rn2h0sn8ma1f7zvxj40l6930p07j044nvmqshq7nmhz3"))))
   (list "rust-wayland-csd-frame-0.3.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-csd-frame/0.3.0/download")
          (file-name "rust-wayland-csd-frame-0.3.0.tar.gz")
          (sha256 (base32 "0zjcmcqprfzx57hlm741n89ssp4sha5yh5cnmbk2agflvclm0p32"))))
   (list "rust-wayland-cursor-0.31.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-cursor/0.31.14/download")
          (file-name "rust-wayland-cursor-0.31.14.tar.gz")
          (sha256 (base32 "0kdk7xwj465idk54jf1f24024gdp63wyagca68a176xyh23x2lja"))))
   (list "rust-wayland-egl-0.32.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-egl/0.32.11/download")
          (file-name "rust-wayland-egl-0.32.11.tar.gz")
          (sha256 (base32 "0lalq3dzd1x7j7v2dsf9zmwp1m6sy22gyf1gasvxjnwyqjvvv5wv"))))
   (list "rust-wayland-protocols-0.32.13.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols/0.32.13/download")
          (file-name "rust-wayland-protocols-0.32.13.tar.gz")
          (sha256 (base32 "1dn4injzx1lnmacnhl3q60m743lvshxmmy0aabb2xaixvq9wil13"))))
   (list "rust-wayland-protocols-misc-0.3.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-misc/0.3.12/download")
          (file-name "rust-wayland-protocols-misc-0.3.12.tar.gz")
          (sha256 (base32 "1j19dg8h98s153rj2fvbqkghjicdfgjjkr6nvaw0jgpjkrcng5bf"))))
   (list "rust-wayland-protocols-experimental-20251230.0.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-experimental/20251230.0.3/download")
          (file-name "rust-wayland-protocols-experimental-20251230.0.3.tar.gz")
          (sha256 (base32 "04yg4ny7pkla5iqdswfxvslzxakrphr916a67l4ksmcf2zkw7ili"))))
   (list "rust-wayland-protocols-plasma-0.3.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-plasma/0.3.12/download")
          (file-name "rust-wayland-protocols-plasma-0.3.12.tar.gz")
          (sha256 (base32 "14adi3xgkldbih60705gshlq2lskds5chhsn3znk271cxgqqqv9b"))))
   (list "rust-wayland-protocols-wlr-0.3.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-protocols-wlr/0.3.12/download")
          (file-name "rust-wayland-protocols-wlr-0.3.12.tar.gz")
          (sha256 (base32 "0d424vn2hj27r4gjlshm6hy8fcqysr805jkqdjbwgmrng0pya17b"))))
   (list "rust-wayland-sys-0.31.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-sys/0.31.11/download")
          (file-name "rust-wayland-sys-0.31.11.tar.gz")
          (sha256 (base32 "1gp3hlkxx13i55lyyi794vnw9a780z3skx0xhj71zr69xwzv5snq"))))
   (list "rust-wayland-scanner-0.31.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-scanner/0.31.11/download")
          (file-name "rust-wayland-scanner-0.31.11.tar.gz")
          (sha256 (base32 "1h0al3271l2w124sxlh77s1kmjg0z24ns2mk1vbnfars3d3313ik"))))
   (list "rust-weezl-0.1.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/weezl/0.1.12/download")
          (file-name "rust-weezl-0.1.12.tar.gz")
          (sha256 (base32 "122a1dhha6cib5az4ihcqlh60ns2bi6rskdv875p94lbvj6wk2m2"))))
   (list "rust-wayland-server-0.31.14.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wayland-server/0.31.14/download")
          (file-name "rust-wayland-server-0.31.14.tar.gz")
          (sha256 (base32 "0xad6xz36fyxz5s0lwsj6shdzwsv8pp53pkp75bklwhgpqlrrphd"))))
   (list "rust-web-time-1.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/web-time/1.1.0/download")
          (file-name "rust-web-time-1.1.0.tar.gz")
          (sha256 (base32 "1fx05yqx83dhx628wb70fyy10yjfq1jpl20qfqhdkymi13rq0ras"))))
   (list "rust-web-sys-0.3.105.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/web-sys/0.3.105/download")
          (file-name "rust-web-sys-0.3.105.tar.gz")
          (sha256 (base32 "1y57whpj5ncrl0cljmfsj5m31jqm66ylad68317yq03g0d5drgcz"))))
   (list "rust-which-4.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/which/4.4.2/download")
          (file-name "rust-which-4.4.2.tar.gz")
          (sha256 (base32 "1ixzmx3svsv5hbdvd8vdhd3qwvf6ns8jdpif1wmwsy10k90j9fl7"))))
   (list "rust-winapi-0.3.9.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi/0.3.9/download")
          (file-name "rust-winapi-0.3.9.tar.gz")
          (sha256 (base32 "06gl025x418lchw1wxj64ycr7gha83m44cjr5sarhynd9xkrm0sw"))))
   (list "rust-winapi-util-0.1.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi-util/0.1.11/download")
          (file-name "rust-winapi-util-0.1.11.tar.gz")
          (sha256 (base32 "08hdl7mkll7pz8whg869h58c1r9y7in0w0pk8fm24qc77k0b39y2"))))
   (list "rust-winapi-i686-pc-windows-gnu-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi-i686-pc-windows-gnu/0.4.0/download")
          (file-name "rust-winapi-i686-pc-windows-gnu-0.4.0.tar.gz")
          (sha256 (base32 "1dmpa6mvcvzz16zg6d5vrfy4bxgg541wxrcip7cnshi06v38ffxc"))))
   (list "rust-windows-aarch64-msvc-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.48.5/download")
          (file-name "rust-windows-aarch64-msvc-0.48.5.tar.gz")
          (sha256 (base32 "1g5l4ry968p73g6bg6jgyvy9lb8fyhcs54067yzxpcpkf44k2dfw"))))
   (list "rust-winapi-x86-64-pc-windows-gnu-0.4.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winapi-x86_64-pc-windows-gnu/0.4.0/download")
          (file-name "rust-winapi-x86-64-pc-windows-gnu-0.4.0.tar.gz")
          (sha256 (base32 "0gqq64czqb64kskjryj8isp62m2sgvx25yyj3kpc2myh85w24bki"))))
   (list "rust-windows-aarch64-gnullvm-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.48.5/download")
          (file-name "rust-windows-aarch64-gnullvm-0.48.5.tar.gz")
          (sha256 (base32 "1n05v7qblg1ci3i567inc7xrkmywczxrs1z3lj3rkkxw18py6f1b"))))
   (list "rust-windows-aarch64-gnullvm-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_gnullvm/0.52.6/download")
          (file-name "rust-windows-aarch64-gnullvm-0.52.6.tar.gz")
          (sha256 (base32 "1lrcq38cr2arvmz19v32qaggvj8bh1640mdm9c2fr877h0hn591j"))))
   (list "rust-windows-aarch64-msvc-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_aarch64_msvc/0.52.6/download")
          (file-name "rust-windows-aarch64-msvc-0.52.6.tar.gz")
          (sha256 (base32 "0sfl0nysnz32yyfh773hpi49b1q700ah6y7sacmjbqjjn5xjmv09"))))
   (list "rust-windows-i686-gnu-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_gnu/0.48.5/download")
          (file-name "rust-windows-i686-gnu-0.48.5.tar.gz")
          (sha256 (base32 "0gklnglwd9ilqx7ac3cn8hbhkraqisd0n83jxzf9837nvvkiand7"))))
   (list "rust-windows-i686-gnu-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_gnu/0.52.6/download")
          (file-name "rust-windows-i686-gnu-0.52.6.tar.gz")
          (sha256 (base32 "02zspglbykh1jh9pi7gn8g1f97jh1rrccni9ivmrfbl0mgamm6wf"))))
   (list "rust-windows-i686-gnullvm-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_gnullvm/0.52.6/download")
          (file-name "rust-windows-i686-gnullvm-0.52.6.tar.gz")
          (sha256 (base32 "0rpdx1537mw6slcpqa0rm3qixmsb79nbhqy5fsm3q2q9ik9m5vhf"))))
   (list "rust-windows-i686-msvc-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_msvc/0.52.6/download")
          (file-name "rust-windows-i686-msvc-0.52.6.tar.gz")
          (sha256 (base32 "0rkcqmp4zzmfvrrrx01260q3xkpzi6fzi2x2pgdcdry50ny4h294"))))
   (list "rust-windows-result-0.4.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-result/0.4.1/download")
          (file-name "rust-windows-result-0.4.1.tar.gz")
          (sha256 (base32 "1d9yhmrmmfqh56zlj751s5wfm9a2aa7az9rd7nn5027nxa4zm0bp"))))
   (list "rust-windows-i686-msvc-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_i686_msvc/0.48.5/download")
          (file-name "rust-windows-i686-msvc-0.48.5.tar.gz")
          (sha256 (base32 "01m4rik437dl9rdf0ndnm2syh10hizvq0dajdkv2fjqcywrw4mcg"))))
   (list "rust-windows-link-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-link/0.2.1/download")
          (file-name "rust-windows-link-0.2.1.tar.gz")
          (sha256 (base32 "1rag186yfr3xx7piv5rg8b6im2dwcf8zldiflvb22xbzwli5507h"))))
   (list "rust-windows-sys-0.48.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-sys/0.48.0/download")
          (file-name "rust-windows-sys-0.48.0.tar.gz")
          (sha256 (base32 "1aan23v5gs7gya1lc46hqn9mdh8yph3fhxmhxlw36pn6pqc28zb7"))))
   (list "rust-windows-sys-0.59.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-sys/0.59.0/download")
          (file-name "rust-windows-sys-0.59.0.tar.gz")
          (sha256 (base32 "0fw5672ziw8b3zpmnbp9pdv1famk74f1l9fcbc3zsrzdg56vqf0y"))))
   (list "rust-windows-targets-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-targets/0.48.5/download")
          (file-name "rust-windows-targets-0.48.5.tar.gz")
          (sha256 (base32 "034ljxqshifs1lan89xwpcy1hp0lhdh4b5n0d2z4fwjx2piacbws"))))
   (list "rust-windows-sys-0.61.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-sys/0.61.2/download")
          (file-name "rust-windows-sys-0.61.2.tar.gz")
          (sha256 (base32 "1z7k3y9b6b5h52kid57lvmvm05362zv1v8w0gc7xyv5xphlp44xf"))))
   (list "rust-windows-targets-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows-targets/0.52.6/download")
          (file-name "rust-windows-targets-0.52.6.tar.gz")
          (sha256 (base32 "0wwrx625nwlfp7k93r2rra568gad1mwd888h1jwnl0vfg5r4ywlv"))))
   (list "rust-windows-x86-64-gnu-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.52.6/download")
          (file-name "rust-windows-x86-64-gnu-0.52.6.tar.gz")
          (sha256 (base32 "0y0sifqcb56a56mvn7xjgs8g43p33mfqkd8wj1yhrgxzma05qyhl"))))
   (list "rust-windows-x86-64-gnu-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnu/0.48.5/download")
          (file-name "rust-windows-x86-64-gnu-0.48.5.tar.gz")
          (sha256 (base32 "13kiqqcvz2vnyxzydjh73hwgigsdr2z1xpzx313kxll34nyhmm2k"))))
   (list "rust-windows-x86-64-gnullvm-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.48.5/download")
          (file-name "rust-windows-x86-64-gnullvm-0.48.5.tar.gz")
          (sha256 (base32 "1k24810wfbgz8k48c2yknqjmiigmql6kk3knmddkv8k8g1v54yqb"))))
   (list "rust-windows-x86-64-msvc-0.48.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.48.5/download")
          (file-name "rust-windows-x86-64-msvc-0.48.5.tar.gz")
          (sha256 (base32 "0f4mdp895kkjh9zv8dxvn4pc10xr7839lf5pa9l0193i2pkgr57d"))))
   (list "rust-windows-x86-64-gnullvm-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_gnullvm/0.52.6/download")
          (file-name "rust-windows-x86-64-gnullvm-0.52.6.tar.gz")
          (sha256 (base32 "03gda7zjx1qh8k9nnlgb7m3w3s1xkysg55hkd1wjch8pqhyv5m94"))))
   (list "rust-windows-x86-64-msvc-0.52.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/windows_x86_64_msvc/0.52.6/download")
          (file-name "rust-windows-x86-64-msvc-0.52.6.tar.gz")
          (sha256 (base32 "1v7rb5cibyzx8vak29pdrk8nx9hycsjs4w0jgms08qk49jl6v7sq"))))
   (list "rust-winit-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit/0.31.0-beta.3/download")
          (file-name "rust-winit-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "0arfj38p8qj6f3sqi04cj193d3l3am76fdxgx8sin3sg7rm1acgl"))))
   (list "rust-winit-android-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-android/0.31.0-beta.3/download")
          (file-name "rust-winit-android-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1x2s442594pxfmsgzl3dfb7y9rr2rhs56chy66wqcjan9aa0vmnm"))))
   (list "rust-winit-appkit-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-appkit/0.31.0-beta.3/download")
          (file-name "rust-winit-appkit-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "0hmbcakx5517lzxj41jy77vbqqzvcvzsc2c0ydramiksxb03wd13"))))
   (list "rust-winit-common-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-common/0.31.0-beta.3/download")
          (file-name "rust-winit-common-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "09a0w3pcvr8ckq0j7y5kzfrvphlijw4ivb8xmjm2ll043kzj4179"))))
   (list "rust-winit-core-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-core/0.31.0-beta.3/download")
          (file-name "rust-winit-core-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1yfhsd5dy9jh5w9yjv5r1cjilj70h37ia34mk5qq8lbc4c3n7bxq"))))
   (list "rust-winit-orbital-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-orbital/0.31.0-beta.3/download")
          (file-name "rust-winit-orbital-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "0l3cry4r131m0ncw5v0f2cr3z8qdd1nnkzfjbp4knalh6zl8m2i7"))))
   (list "rust-winit-uikit-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-uikit/0.31.0-beta.3/download")
          (file-name "rust-winit-uikit-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1da08x4fzbrknrk7d1fq2nahrcic18xmxlr3rxk8973kl4z5lcc3"))))
   (list "rust-winit-web-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-web/0.31.0-beta.3/download")
          (file-name "rust-winit-web-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1jgic0vcpi9z9lm8acs1xi5dc9fr73prlml0zfyrghjwz52vwfgm"))))
   (list "rust-winit-wayland-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-wayland/0.31.0-beta.3/download")
          (file-name "rust-winit-wayland-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "00zqf5dykispphvy711kf0z43qdb0qhi01ggds44a36y0vnwwr4b"))))
   (list "rust-winit-x11-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-x11/0.31.0-beta.3/download")
          (file-name "rust-winit-x11-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1alnzmzrhvxffk6jhsg1z5vh1dqcgmpiq6j9jmw4nlbyj36lcmxv"))))
   (list "rust-winit-win32-0.31.0-beta.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winit-win32/0.31.0-beta.3/download")
          (file-name "rust-winit-win32-0.31.0-beta.3.tar.gz")
          (sha256 (base32 "1v5nl3kng4cznp52snxv4afqlgq1fjnz7jsnyr8x60fz8464iyr5"))))
   (list "rust-winnow-1.0.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/winnow/1.0.4/download")
          (file-name "rust-winnow-1.0.4.tar.gz")
          (sha256 (base32 "10fzxipa7lx16172p3aca9j60hzbqgjki2f95kqksd5qywcp7f93"))))
   (list "rust-wio-0.2.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wio/0.2.2/download")
          (file-name "rust-wio-0.2.2.tar.gz")
          (sha256 (base32 "199p404fp96w1f1c93bf1jrvaqwypxf3hmmldhww4jk4yhr9j4jx"))))
   (list "rust-wit-bindgen-0.57.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wit-bindgen/0.57.1/download")
          (file-name "rust-wit-bindgen-0.57.1.tar.gz")
          (sha256 (base32 "0vjk2jb593ri9k1aq4iqs2si9mrw5q46wxnn78im7hm7hx799gqy"))))
   (list "rust-wlcs-0.1.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/wlcs/0.1.0/download")
          (file-name "rust-wlcs-0.1.0.tar.gz")
          (sha256 (base32 "17k0nwn3f2z71rncb8glb4x15m5zmcbklnk71hpv739nrq2w769d"))))
   (list "rust-writeable-0.6.4.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/writeable/0.6.4/download")
          (file-name "rust-writeable-0.6.4.tar.gz")
          (sha256 (base32 "1p3r4s4wbf3dksfpj3xyrn7id5p0f7r74mj6qx6ngjfd6cm2vn1s"))))
   (list "rust-x11rb-protocol-0.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/x11rb-protocol/0.13.2/download")
          (file-name "rust-x11rb-protocol-0.13.2.tar.gz")
          (sha256 (base32 "1g81cznbyn522b0fbis0i44wh3adad2vhsz5pzf99waf3sbc4vza"))))
   (list "rust-x11-dl-2.21.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/x11-dl/2.21.0/download")
          (file-name "rust-x11-dl-2.21.0.tar.gz")
          (sha256 (base32 "0vsiq62xpcfm0kn9zjw5c9iycvccxl22jya8wnk18lyxzqj5jwrq"))))
   (list "rust-x11rb-0.13.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/x11rb/0.13.2/download")
          (file-name "rust-x11rb-0.13.2.tar.gz")
          (sha256 (base32 "053lvnaw9ycbl791mgwly2hw27q6vqgzrb1y5kz1as52wmdsm4wr"))))
   (list "rust-xcursor-0.3.11.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xcursor/0.3.11/download")
          (file-name "rust-xcursor-0.3.11.tar.gz")
          (sha256 (base32 "08wfv0wrij9rrmbgfd2l8a132gyfax05abypllpmwic6hznk6fqn"))))
   (list "rust-xkbcommon-0.7.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkbcommon/0.7.0/download")
          (file-name "rust-xkbcommon-0.7.0.tar.gz")
          (sha256 (base32 "07n9shhcls66wjvmk5pzqql46ipfdv7b8hbc384wgv9hk4jpv1hk"))))
   (list "rust-xkbcommon-0.8.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkbcommon/0.8.0/download")
          (file-name "rust-xkbcommon-0.8.0.tar.gz")
          (sha256 (base32 "1j8s1sfwc6bw9phsca65rw3q3b5l2651v1s0pk5yxm6baa9wlrld"))))
   (list "rust-xkbcommon-0.9.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkbcommon/0.9.0/download")
          (file-name "rust-xkbcommon-0.9.0.tar.gz")
          (sha256 (base32 "0bd0qkapxsvblfw42x6ryhi50d63v55g40awf2alx8b0h3s79ad7"))))
   (list "rust-xkeysym-0.2.1.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkeysym/0.2.1/download")
          (file-name "rust-xkeysym-0.2.1.tar.gz")
          (sha256 (base32 "0mksx670cszyd7jln6s7dhkw11hdfv7blwwr3isq98k22ljh1k5r"))))
   (list "rust-xml-rs-0.8.29.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xml-rs/0.8.29/download")
          (file-name "rust-xml-rs-0.8.29.tar.gz")
          (sha256 (base32 "19y8s93sh2dx21bqlpagkixld2c66f3rln0j9k4k7zqxxnrgjl74"))))
   (list "rust-xkbcommon-dl-0.4.2.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/xkbcommon-dl/0.4.2/download")
          (file-name "rust-xkbcommon-dl-0.4.2.tar.gz")
          (sha256 (base32 "1iai0r3b5skd9vbr8z5b0qixiz8jblzfm778ddm8ba596a0dwffh"))))
   (list "rust-y4m-0.8.0.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/y4m/0.8.0/download")
          (file-name "rust-y4m-0.8.0.tar.gz")
          (sha256 (base32 "0j24y2zf60lpxwd7kyg737hqfyqx16y32s0fjyi6fax6w4hlnnks"))))
   (list "rust-yoke-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/yoke/0.8.3/download")
          (file-name "rust-yoke-0.8.3.tar.gz")
          (sha256 (base32 "1xgyj6c2lxj2bp891ynmhws87c6z7yyv2li1v0ss9di40hxf57vh"))))
   (list "rust-yoke-derive-0.8.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/yoke-derive/0.8.3/download")
          (file-name "rust-yoke-derive-0.8.3.tar.gz")
          (sha256 (base32 "0y1a857vmqk2zpq4jj4sxxm7mla18xsrapjldpmvq3g4pql1909k"))))
   (list "rust-zerocopy-derive-0.8.57.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerocopy-derive/0.8.57/download")
          (file-name "rust-zerocopy-derive-0.8.57.tar.gz")
          (sha256 (base32 "1g5js10p1q1d7wn6b74wjvrjznv34x5cfxpj7jj8s9a4mgsh2v0l"))))
   (list "rust-zerocopy-0.8.57.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerocopy/0.8.57/download")
          (file-name "rust-zerocopy-0.8.57.tar.gz")
          (sha256 (base32 "0wr85plmrkz0nh5grbqap23l9ghqq4mq1ip4x759q23dyflh4lfk"))))
   (list "rust-zerofrom-0.1.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerofrom/0.1.8/download")
          (file-name "rust-zerofrom-0.1.8.tar.gz")
          (sha256 (base32 "0wjjdj7gdmd0iq91gzkxl7dlv0nhkk80l4bmdpzh3a1yh48mmh0f"))))
   (list "rust-zerofrom-derive-0.1.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerofrom-derive/0.1.8/download")
          (file-name "rust-zerofrom-derive-0.1.8.tar.gz")
          (sha256 (base32 "0jhdy4p9c6ja3dynsdck14g2iilq8ai5ch6nsi455x67ys1lcnzp"))))
   (list "rust-zerotrie-0.2.5.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerotrie/0.2.5/download")
          (file-name "rust-zerotrie-0.2.5.tar.gz")
          (sha256 (base32 "0gss16krjzk22m57dz5hkdjg99ibj6pa41qr68na7w1jpp1nk8jf"))))
   (list "rust-zerovec-0.11.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerovec/0.11.8/download")
          (file-name "rust-zerovec-0.11.8.tar.gz")
          (sha256 (base32 "1n3xlvyba8riys9s8awy4xp533phqycr78nbsmvdkh86g3hn815v"))))
   (list "rust-zerovec-derive-0.11.6.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zerovec-derive/0.11.6/download")
          (file-name "rust-zerovec-derive-0.11.6.tar.gz")
          (sha256 (base32 "1ni5j8v99x3fcf3l8kp64b7aq4vf8y22jshfq74xs9mxkp1nzprl"))))
   (list "rust-zlib-rs-0.6.8.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zlib-rs/0.6.8/download")
          (file-name "rust-zlib-rs-0.6.8.tar.gz")
          (sha256 (base32 "04j158293bx73kv5pj1i89ai411q7fxc9zwk3wkpqgb9gj7fas5j"))))
   (list "rust-zune-core-0.4.12.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zune-core/0.4.12/download")
          (file-name "rust-zune-core-0.4.12.tar.gz")
          (sha256 (base32 "0jj1ra86klzlcj9aha9als9d1dzs7pqv3azs1j3n96822wn3lhiz"))))
   (list "rust-zmij-1.0.23.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zmij/1.0.23/download")
          (file-name "rust-zmij-1.0.23.tar.gz")
          (sha256 (base32 "06zwri21nnrl34rwinmvbciap8yk1mrl8qfg9pff7lgspc56sri9"))))
   (list "rust-zune-core-0.5.3.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zune-core/0.5.3/download")
          (file-name "rust-zune-core-0.5.3.tar.gz")
          (sha256 (base32 "12v5zdwcmjwzlfz61ajchzdaab75cxasqnmwf2hq929n8vypfqym"))))
   (list "rust-zune-inflate-0.2.54.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zune-inflate/0.2.54/download")
          (file-name "rust-zune-inflate-0.2.54.tar.gz")
          (sha256 (base32 "00kg24jh3zqa3i6rg6yksnb71bch9yi1casqydl00s7nw8pk7avk"))))
   (list "rust-zune-jpeg-0.4.21.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zune-jpeg/0.4.21/download")
          (file-name "rust-zune-jpeg-0.4.21.tar.gz")
          (sha256 (base32 "04r7g6y9jp7d4c9bq23rz3gwzlr1dsl7vdk4yly35bc4jf52rki9"))))
   (list "rust-zune-jpeg-0.5.15.tar.gz"
         (origin
          (method url-fetch)
          (uri "https://crates.io/api/v1/crates/zune-jpeg/0.5.15/download")
          (file-name "rust-zune-jpeg-0.5.15.tar.gz")
          (sha256 (base32 "15kjpn6pywxlwb8w5irfd68x31wi3mb4y1da8bqh7havh5drvg17"))))
))

