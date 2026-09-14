;;; Pinned registry sources from Clash Verge service 2.3.3's Cargo.lock.
(define-module (ch0r0ng packages clash-verge crates)
  #:use-module (guix base16)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:export (%clash-verge-service-crates))

(define %clash-verge-service-crates
  (list
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/aho-corasick/aho-corasick-1.1.4.crate")
          (file-name "rust-aho-corasick-1.1.4.tar.gz")
          (sha256 (base16-string->bytevector "ddd31a130427c27518df266943a5308ed92d4b226cc639f5a8f1002816174301")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/android_system_properties/android_system_properties-0.1.5.crate")
          (file-name "rust-android-system-properties-0.1.5.tar.gz")
          (sha256 (base16-string->bytevector "819e7219dbd41043ac279b19830f2efc897156490d7fd6ea916720117ee66311")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/anyhow/anyhow-1.0.103.crate")
          (file-name "rust-anyhow-1.0.103.tar.gz")
          (sha256 (base16-string->bytevector "2a4385e2e34eb35d6b3efe798b9eb88096925d87726c0798709bf56d9ed84af3")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/arraydeque/arraydeque-0.5.1.crate")
          (file-name "rust-arraydeque-0.5.1.tar.gz")
          (sha256 (base16-string->bytevector "7d902e3d592a523def97af8f317b08ce16b7ab854c1985a0c671e6f15cebc236")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/autocfg/autocfg-1.5.0.crate")
          (file-name "rust-autocfg-1.5.0.tar.gz")
          (sha256 (base16-string->bytevector "c08606f8c3cbf4ce6ec8e28fb0014a2c086708fe954eaa885384a6165172e7e8")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/bitflags/bitflags-2.11.1.crate")
          (file-name "rust-bitflags-2.11.1.tar.gz")
          (sha256 (base16-string->bytevector "c4512299f36f043ab09a583e57bceb5a5aab7a73db1805848e8fef3c9e8c78b3")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/bumpalo/bumpalo-3.20.2.crate")
          (file-name "rust-bumpalo-3.20.2.tar.gz")
          (sha256 (base16-string->bytevector "5d20789868f4b01b2f2caec9f5c4e0213b41e3e5702a50157d699ae31ced2fcb")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/bytes/bytes-1.11.1.crate")
          (file-name "rust-bytes-1.11.1.tar.gz")
          (sha256 (base16-string->bytevector "1e748733b7cbc798e1434b6ac524f0c1ff2ab456fe201501e6497c8417a4fc33")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/castaway/castaway-0.2.4.crate")
          (file-name "rust-castaway-0.2.4.tar.gz")
          (sha256 (base16-string->bytevector "dec551ab6e7578819132c713a93c022a05d60159dc86e7a7050223577484c55a")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/cc/cc-1.2.60.crate")
          (file-name "rust-cc-1.2.60.tar.gz")
          (sha256 (base16-string->bytevector "43c5703da9466b66a946814e1adf53ea2c90f10063b86290cc9eb67ce3478a20")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/cfg-if/cfg-if-1.0.4.crate")
          (file-name "rust-cfg-if-1.0.4.tar.gz")
          (sha256 (base16-string->bytevector "9330f8b2ff13f34540b44e946ef35111825727b38d33286ef986142615121801")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/cfg_aliases/cfg_aliases-0.2.1.crate")
          (file-name "rust-cfg-aliases-0.2.1.tar.gz")
          (sha256 (base16-string->bytevector "613afe47fcd5fac7ccf1db93babcb082c5994d996f20b8b159f2ad1658eb5724")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/chacha20/chacha20-0.10.0.crate")
          (file-name "rust-chacha20-0.10.0.tar.gz")
          (sha256 (base16-string->bytevector "6f8d983286843e49675a4b7a2d174efe136dc93a18d69130dd18198a6c167601")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/chrono/chrono-0.4.44.crate")
          (file-name "rust-chrono-0.4.44.tar.gz")
          (sha256 (base16-string->bytevector "c673075a2e0e5f4a1dde27ce9dee1ea4558c7ffe648f576438a20ca1d2acc4b0")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/compact_str/compact_str-0.9.1.crate")
          (file-name "rust-compact-str-0.9.1.tar.gz")
          (sha256 (base16-string->bytevector "9dfdd1c2274d9aa354115b09dc9a901d6c5576818cdf70d14cae2bdb47df00ab")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/core-foundation-sys/core-foundation-sys-0.8.7.crate")
          (file-name "rust-core-foundation-sys-0.8.7.tar.gz")
          (sha256 (base16-string->bytevector "773648b94d0e5d620f64f280777445740e61fe701025087ec8b57f45c791888b")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/cpufeatures/cpufeatures-0.3.0.crate")
          (file-name "rust-cpufeatures-0.3.0.tar.gz")
          (sha256 (base16-string->bytevector "8b2a41393f66f16b0823bb79094d54ac5fbd34ab292ddafb9a0456ac9f87d201")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/displaydoc/displaydoc-0.2.5.crate")
          (file-name "rust-displaydoc-0.2.5.tar.gz")
          (sha256 (base16-string->bytevector "97369cbbc041bc366949bc74d34658d6cda5621039731c6310521892a3a20ae0")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/doctest-file/doctest-file-1.1.1.crate")
          (file-name "rust-doctest-file-1.1.1.tar.gz")
          (sha256 (base16-string->bytevector "c2db04e74f0a9a93103b50e90b96024c9b2bdca8bce6a632ec71b88736d3d359")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/equivalent/equivalent-1.0.2.crate")
          (file-name "rust-equivalent-1.0.2.tar.gz")
          (sha256 (base16-string->bytevector "877a4ace8713b0bcf2a4e7eec82529c029f1d0619886d18145fea96c3ffe5c0f")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/errno/errno-0.3.14.crate")
          (file-name "rust-errno-0.3.14.tar.gz")
          (sha256 (base16-string->bytevector "39cab71617ae0d63f51a36d69f866391735b51691dbda63cf6f96d042b63efeb")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/find-msvc-tools/find-msvc-tools-0.1.9.crate")
          (file-name "rust-find-msvc-tools-0.1.9.tar.gz")
          (sha256 (base16-string->bytevector "5baebc0774151f905a1a2cc41989300b1e6fbb29aff0ceffa1064fdd3088d582")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/flexi_logger/flexi_logger-0.31.9.crate")
          (file-name "rust-flexi-logger-0.31.9.tar.gz")
          (sha256 (base16-string->bytevector "2e90140a77c0ffbe2e4839e062983ec4ec60d4473e41a4fcce0884809d1b76d6")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/foldhash/foldhash-0.1.5.crate")
          (file-name "rust-foldhash-0.1.5.tar.gz")
          (sha256 (base16-string->bytevector "d9c4f5dac5e15c24eb999c26181a6ca40b39fe946cbe4c263c7209467bc83af2")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/form_urlencoded/form_urlencoded-1.2.2.crate")
          (file-name "rust-form-urlencoded-1.2.2.tar.gz")
          (sha256 (base16-string->bytevector "cb4cb245038516f5f85277875cdaa4f7d2c9a0fa0468de06ed190163b1581fcf")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures/futures-0.3.32.crate")
          (file-name "rust-futures-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "8b147ee9d1f6d097cef9ce628cd2ee62288d963e16fb287bd9286455b241382d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-channel/futures-channel-0.3.32.crate")
          (file-name "rust-futures-channel-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "07bbe89c50d7a535e539b8c17bc0b49bdb77747034daa8087407d655f3f7cc1d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-core/futures-core-0.3.32.crate")
          (file-name "rust-futures-core-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "7e3450815272ef58cec6d564423f6e755e25379b217b0bc688e295ba24df6b1d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-executor/futures-executor-0.3.32.crate")
          (file-name "rust-futures-executor-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "baf29c38818342a3b26b5b923639e7b1f4a61fc5e76102d4b1981c6dc7a7579d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-io/futures-io-0.3.32.crate")
          (file-name "rust-futures-io-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "cecba35d7ad927e23624b22ad55235f2239cfa44fd10428eecbeba6d6a717718")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-macro/futures-macro-0.3.32.crate")
          (file-name "rust-futures-macro-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "e835b70203e41293343137df5c0664546da5745f82ec9b84d40be8336958447b")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-sink/futures-sink-0.3.32.crate")
          (file-name "rust-futures-sink-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "c39754e157331b013978ec91992bde1ac089843443c49cbc7f46150b0fad0893")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-task/futures-task-0.3.32.crate")
          (file-name "rust-futures-task-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "037711b3d59c33004d3856fbdc83b99d4ff37a24768fa1be9ce3538a1cde4393")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/futures-util/futures-util-0.3.32.crate")
          (file-name "rust-futures-util-0.3.32.tar.gz")
          (sha256 (base16-string->bytevector "389ca41296e6190b48053de0321d02a77f32f8a5d2461dd38762c0593805c6d6")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/getrandom/getrandom-0.4.2.crate")
          (file-name "rust-getrandom-0.4.2.tar.gz")
          (sha256 (base16-string->bytevector "0de51e6874e94e7bf76d726fc5d13ba782deca734ff60d5bb2fb2607c7406555")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/hashbrown/hashbrown-0.15.5.crate")
          (file-name "rust-hashbrown-0.15.5.tar.gz")
          (sha256 (base16-string->bytevector "9229cfe53dfd69f0609a49f65461bd93001ea1ef889cd5529dd176593f5338a1")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/hashbrown/hashbrown-0.17.0.crate")
          (file-name "rust-hashbrown-0.17.0.tar.gz")
          (sha256 (base16-string->bytevector "4f467dd6dccf739c208452f8014c75c18bb8301b050ad1cfb27153803edb0f51")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/heck/heck-0.5.0.crate")
          (file-name "rust-heck-0.5.0.tar.gz")
          (sha256 (base16-string->bytevector "2304e00983f87ffb38b55b444b5e3b60a884b5d30c0fca7d82fe33449bbe55ea")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/http/http-1.4.2.crate")
          (file-name "rust-http-1.4.2.tar.gz")
          (sha256 (base16-string->bytevector "6970f50e31d6fc17d3fa27329444bfa74e196cf62e95052a3f6fee181dba6425")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/httparse/httparse-1.10.1.crate")
          (file-name "rust-httparse-1.10.1.tar.gz")
          (sha256 (base16-string->bytevector "6dbf3de79e51f3d586ab4cb9d5c3e2c14aa28ed23d180cf89b4df0454a69cc87")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/iana-time-zone/iana-time-zone-0.1.65.crate")
          (file-name "rust-iana-time-zone-0.1.65.tar.gz")
          (sha256 (base16-string->bytevector "e31bc9ad994ba00e440a8aa5c9ef0ec67d5cb5e5cb0cc7f8b744a35b389cc470")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/iana-time-zone-haiku/iana-time-zone-haiku-0.1.2.crate")
          (file-name "rust-iana-time-zone-haiku-0.1.2.tar.gz")
          (sha256 (base16-string->bytevector "f31827a206f56af32e590ba56d5d2d085f558508192593743f16b2306495269f")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_collections/icu_collections-2.2.0.crate")
          (file-name "rust-icu-collections-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "2984d1cd16c883d7935b9e07e44071dca8d917fd52ecc02c04d5fa0b5a3f191c")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_locale_core/icu_locale_core-2.2.0.crate")
          (file-name "rust-icu-locale-core-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "92219b62b3e2b4d88ac5119f8904c10f8f61bf7e95b640d25ba3075e6cac2c29")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_normalizer/icu_normalizer-2.2.0.crate")
          (file-name "rust-icu-normalizer-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "c56e5ee99d6e3d33bd91c5d85458b6005a22140021cc324cea84dd0e72cff3b4")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_normalizer_data/icu_normalizer_data-2.2.0.crate")
          (file-name "rust-icu-normalizer-data-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "da3be0ae77ea334f4da67c12f149704f19f81d1adf7c51cf482943e84a2bad38")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_properties/icu_properties-2.2.0.crate")
          (file-name "rust-icu-properties-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "bee3b67d0ea5c2cca5003417989af8996f8604e34fb9ddf96208a033901e70de")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_properties_data/icu_properties_data-2.2.0.crate")
          (file-name "rust-icu-properties-data-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "8e2bbb201e0c04f7b4b3e14382af113e17ba4f63e2c9d2ee626b720cbce54a14")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/icu_provider/icu_provider-2.2.0.crate")
          (file-name "rust-icu-provider-2.2.0.tar.gz")
          (sha256 (base16-string->bytevector "139c4cf31c8b5f33d7e199446eff9c1e02decfc2f0eec2c8d71f65befa45b421")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/id-arena/id-arena-2.3.0.crate")
          (file-name "rust-id-arena-2.3.0.tar.gz")
          (sha256 (base16-string->bytevector "3d3067d79b975e8844ca9eb072e16b31c3c1c36928edf9c6789548c524d0d954")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/idna/idna-1.1.0.crate")
          (file-name "rust-idna-1.1.0.tar.gz")
          (sha256 (base16-string->bytevector "3b0875f23caa03898994f6ddc501886a45c7d3d62d04d2d90788d47be1b1e4de")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/idna_adapter/idna_adapter-1.2.1.crate")
          (file-name "rust-idna-adapter-1.2.1.tar.gz")
          (sha256 (base16-string->bytevector "3acae9609540aa318d1bc588455225fb2085b9ed0c4f6bd0d9d5bcd86f1a0344")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/indexmap/indexmap-2.14.0.crate")
          (file-name "rust-indexmap-2.14.0.tar.gz")
          (sha256 (base16-string->bytevector "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/interprocess/interprocess-2.4.2.crate")
          (file-name "rust-interprocess-2.4.2.tar.gz")
          (sha256 (base16-string->bytevector "069323743400cb7ab06a8fe5c1ed911d36b6919ec531661d034c89083629595b")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/itoa/itoa-1.0.18.crate")
          (file-name "rust-itoa-1.0.18.tar.gz")
          (sha256 (base16-string->bytevector "8f42a60cbdf9a97f5d2305f08a87dc4e09308d1276d28c869c684d7777685682")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/js-sys/js-sys-0.3.95.crate")
          (file-name "rust-js-sys-0.3.95.tar.gz")
          (sha256 (base16-string->bytevector "2964e92d1d9dc3364cae4d718d93f227e3abb088e747d92e0395bfdedf1c12ca")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/kode-bridge/kode-bridge-0.4.0.crate")
          (file-name "rust-kode-bridge-0.4.0.tar.gz")
          (sha256 (base16-string->bytevector "c462fd5d0886cd98cd74ecafdb44dd3f2b52b30711f07d42cc0f5956f38e706d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/lazy_static/lazy_static-1.5.0.crate")
          (file-name "rust-lazy-static-1.5.0.tar.gz")
          (sha256 (base16-string->bytevector "bbd2bcb4c963f2ddae06a2efc7e9f3591312473c50c6685e1f298068316e66fe")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/leb128fmt/leb128fmt-0.1.0.crate")
          (file-name "rust-leb128fmt-0.1.0.tar.gz")
          (sha256 (base16-string->bytevector "09edd9e8b54e49e587e4f6295a7d29c3ea94d469cb40ab8ca70b288248a81db2")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/libc/libc-0.2.186.crate")
          (file-name "rust-libc-0.2.186.tar.gz")
          (sha256 (base16-string->bytevector "68ab91017fe16c622486840e4c83c9a37afeff978bd239b5293d61ece587de66")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/litemap/litemap-0.8.2.crate")
          (file-name "rust-litemap-0.8.2.tar.gz")
          (sha256 (base16-string->bytevector "92daf443525c4cce67b150400bc2316076100ce0b3686209eb8cf3c31612e6f0")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/lock_api/lock_api-0.4.14.crate")
          (file-name "rust-lock-api-0.4.14.tar.gz")
          (sha256 (base16-string->bytevector "224399e74b87b5f3557511d98dff8b14089b3dadafcab6bb93eab67d3aace965")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/log/log-0.4.33.crate")
          (file-name "rust-log-0.4.33.tar.gz")
          (sha256 (base16-string->bytevector "0ceec5bc11778974d1bcb055b18002eba7f4b3518b6a0081b3af5f21666da9ad")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/matchers/matchers-0.2.0.crate")
          (file-name "rust-matchers-0.2.0.tar.gz")
          (sha256 (base16-string->bytevector "d1525a2a28c7f4fa0fc98bb91ae755d1e2d1505079e05539e35bc876b5d65ae9")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/memchr/memchr-2.8.0.crate")
          (file-name "rust-memchr-2.8.0.tar.gz")
          (sha256 (base16-string->bytevector "f8ca58f447f06ed17d5fc4043ce1b10dd205e060fb3ce5b979b8ed8e59ff3f79")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/mio/mio-1.2.0.crate")
          (file-name "rust-mio-1.2.0.tar.gz")
          (sha256 (base16-string->bytevector "50b7e5b27aa02a74bac8c3f23f448f8d87ff11f92d3aac1a6ed369ee08cc56c1")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/munge/munge-0.4.7.crate")
          (file-name "rust-munge-0.4.7.tar.gz")
          (sha256 (base16-string->bytevector "5e17401f259eba956ca16491461b6e8f72913a0a114e39736ce404410f915a0c")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/munge_macro/munge_macro-0.4.7.crate")
          (file-name "rust-munge-macro-0.4.7.tar.gz")
          (sha256 (base16-string->bytevector "4568f25ccbd45ab5d5603dc34318c1ec56b117531781260002151b8530a9f931")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/nix/nix-0.31.3.crate")
          (file-name "rust-nix-0.31.3.tar.gz")
          (sha256 (base16-string->bytevector "cf20d2fde8ff38632c426f1165ed7436270b44f199fc55284c38276f9db47c3d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/nu-ansi-term/nu-ansi-term-0.50.3.crate")
          (file-name "rust-nu-ansi-term-0.50.3.tar.gz")
          (sha256 (base16-string->bytevector "7957b9740744892f114936ab4a57b3f487491bbeafaf8083688b16841a4240e5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/num-traits/num-traits-0.2.19.crate")
          (file-name "rust-num-traits-0.2.19.tar.gz")
          (sha256 (base16-string->bytevector "071dfc062690e90b734c0b2273ce72ad0ffa95f0c74596bc250dcfd960262841")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/once_cell/once_cell-1.21.4.crate")
          (file-name "rust-once-cell-1.21.4.tar.gz")
          (sha256 (base16-string->bytevector "9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/parking_lot/parking_lot-0.12.5.crate")
          (file-name "rust-parking-lot-0.12.5.tar.gz")
          (sha256 (base16-string->bytevector "93857453250e3077bd71ff98b6a65ea6621a19bb0f559a85248955ac12c45a1a")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/parking_lot_core/parking_lot_core-0.9.12.crate")
          (file-name "rust-parking-lot-core-0.9.12.tar.gz")
          (sha256 (base16-string->bytevector "2621685985a2ebf1c516881c026032ac7deafcda1a2c9b7850dc81e3dfcb64c1")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/path-tree/path-tree-0.8.3.crate")
          (file-name "rust-path-tree-0.8.3.tar.gz")
          (sha256 (base16-string->bytevector "c2a97453bc21a968f722df730bfe11bd08745cb50d1300b0df2bda131dece136")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/percent-encoding/percent-encoding-2.3.2.crate")
          (file-name "rust-percent-encoding-2.3.2.tar.gz")
          (sha256 (base16-string->bytevector "9b4f627cb1b25917193a259e49bdad08f671f8d9708acfd5fe0a8c1455d87220")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/pin-project-lite/pin-project-lite-0.2.17.crate")
          (file-name "rust-pin-project-lite-0.2.17.tar.gz")
          (sha256 (base16-string->bytevector "a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/potential_utf/potential_utf-0.1.5.crate")
          (file-name "rust-potential-utf-0.1.5.tar.gz")
          (sha256 (base16-string->bytevector "0103b1cef7ec0cf76490e969665504990193874ea05c85ff9bab8b911d0a0564")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/prettyplease/prettyplease-0.2.37.crate")
          (file-name "rust-prettyplease-0.2.37.tar.gz")
          (sha256 (base16-string->bytevector "479ca8adacdd7ce8f1fb39ce9ecccbfe93a3f1344b3d0d97f20bc0196208f62b")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/proc-macro2/proc-macro2-1.0.106.crate")
          (file-name "rust-proc-macro2-1.0.106.tar.gz")
          (sha256 (base16-string->bytevector "8fd00f0bb2e90d81d1044c2b32617f68fcb9fa3bb7640c23e9c748e53fb30934")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/ptr_meta/ptr_meta-0.3.1.crate")
          (file-name "rust-ptr-meta-0.3.1.tar.gz")
          (sha256 (base16-string->bytevector "0b9a0cf95a1196af61d4f1cbdab967179516d9a4a4312af1f31948f8f6224a79")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/ptr_meta_derive/ptr_meta_derive-0.3.1.crate")
          (file-name "rust-ptr-meta-derive-0.3.1.tar.gz")
          (sha256 (base16-string->bytevector "7347867d0a7e1208d93b46767be83e2b8f978c3dad35f775ac8d8847551d6fe1")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/quote/quote-1.0.45.crate")
          (file-name "rust-quote-1.0.45.tar.gz")
          (sha256 (base16-string->bytevector "41f2619966050689382d2b44f664f4bc593e129785a36d6ee376ddf37259b924")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/r-efi/r-efi-6.0.0.crate")
          (file-name "rust-r-efi-6.0.0.tar.gz")
          (sha256 (base16-string->bytevector "f8dcc9c7d52a811697d2151c701e0d08956f92b0e24136cf4cf27b57a6a0d9bf")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rancor/rancor-0.1.1.crate")
          (file-name "rust-rancor-0.1.1.tar.gz")
          (sha256 (base16-string->bytevector "a063ea72381527c2a0561da9c80000ef822bdd7c3241b1cc1b12100e3df081ee")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rand/rand-0.10.1.crate")
          (file-name "rust-rand-0.10.1.tar.gz")
          (sha256 (base16-string->bytevector "d2e8e8bcc7961af1fdac401278c6a831614941f6164ee3bf4ce61b7edb162207")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rand_core/rand_core-0.10.1.crate")
          (file-name "rust-rand-core-0.10.1.tar.gz")
          (sha256 (base16-string->bytevector "63b8176103e19a2643978565ca18b50549f6101881c443590420e4dc998a3c69")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/recvmsg/recvmsg-1.0.0.crate")
          (file-name "rust-recvmsg-1.0.0.tar.gz")
          (sha256 (base16-string->bytevector "d3edd4d5d42c92f0a659926464d4cce56b562761267ecf0f469d85b7de384175")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/redox_syscall/redox_syscall-0.5.18.crate")
          (file-name "rust-redox-syscall-0.5.18.tar.gz")
          (sha256 (base16-string->bytevector "ed2bf2547551a7053d6fdfafda3f938979645c44812fbfcda098faae3f1a362d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/regex/regex-1.12.3.crate")
          (file-name "rust-regex-1.12.3.tar.gz")
          (sha256 (base16-string->bytevector "e10754a14b9137dd7b1e3e5b0493cc9171fdd105e0ab477f51b72e7f3ac0e276")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/regex-automata/regex-automata-0.4.14.crate")
          (file-name "rust-regex-automata-0.4.14.tar.gz")
          (sha256 (base16-string->bytevector "6e1dd4122fc1595e8162618945476892eefca7b88c52820e74af6262213cae8f")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/regex-syntax/regex-syntax-0.8.10.crate")
          (file-name "rust-regex-syntax-0.8.10.tar.gz")
          (sha256 (base16-string->bytevector "dc897dd8d9e8bd1ed8cdad82b5966c3e0ecae09fb1907d58efaa013543185d0a")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rend/rend-0.5.3.crate")
          (file-name "rust-rend-0.5.3.tar.gz")
          (sha256 (base16-string->bytevector "cadadef317c2f20755a64d7fdc48f9e7178ee6b0e1f7fce33fa60f1d68a276e6")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rkyv/rkyv-0.8.16.crate")
          (file-name "rust-rkyv-0.8.16.tar.gz")
          (sha256 (base16-string->bytevector "73389e0c99e664f919275ab5b5b0471391fe9a8de61e1dff9b1eaf56a90f16e3")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rkyv_derive/rkyv_derive-0.8.16.crate")
          (file-name "rust-rkyv-derive-0.8.16.tar.gz")
          (sha256 (base16-string->bytevector "5d2ed0b54125315fb36bd021e82d314d1c126548f871634b483f46b31d13cac6")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/rustversion/rustversion-1.0.22.crate")
          (file-name "rust-rustversion-1.0.22.tar.gz")
          (sha256 (base16-string->bytevector "b39cdef0fa800fc44525c84ccb54a029961a8215f9619753635a9c0d2538d46d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/ryu/ryu-1.0.23.crate")
          (file-name "rust-ryu-1.0.23.tar.gz")
          (sha256 (base16-string->bytevector "9774ba4a74de5f7b1c1451ed6cd5285a32eddb5cccb8cc655a4e50009e06477f")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/scopeguard/scopeguard-1.2.0.crate")
          (file-name "rust-scopeguard-1.2.0.tar.gz")
          (sha256 (base16-string->bytevector "94143f37725109f92c262ed2cf5e59bce7498c01bcc1502d7b9afe439a4e9f49")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/semver/semver-1.0.28.crate")
          (file-name "rust-semver-1.0.28.tar.gz")
          (sha256 (base16-string->bytevector "8a7852d02fc848982e0c167ef163aaff9cd91dc640ba85e263cb1ce46fae51cd")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serde/serde-1.0.228.crate")
          (file-name "rust-serde-1.0.228.tar.gz")
          (sha256 (base16-string->bytevector "9a8e94ea7f378bd32cbbd37198a4a91436180c5bb472411e48b5ec2e2124ae9e")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serde_core/serde_core-1.0.228.crate")
          (file-name "rust-serde-core-1.0.228.tar.gz")
          (sha256 (base16-string->bytevector "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serde_derive/serde_derive-1.0.228.crate")
          (file-name "rust-serde-derive-1.0.228.tar.gz")
          (sha256 (base16-string->bytevector "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serde_json/serde_json-1.0.150.crate")
          (file-name "rust-serde-json-1.0.150.tar.gz")
          (sha256 (base16-string->bytevector "e8014e44b4736ed0538adeecded0fce2a272f22dc9578a7eb6b2d9993c74cfb9")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serde_spanned/serde_spanned-1.1.1.crate")
          (file-name "rust-serde-spanned-1.1.1.tar.gz")
          (sha256 (base16-string->bytevector "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serial_test/serial_test-3.5.0.crate")
          (file-name "rust-serial-test-3.5.0.tar.gz")
          (sha256 (base16-string->bytevector "699f4197115b8a7e7ff19c9a315a4bd6fffec26cc4626ef45ecaea389e081c6d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/serial_test_derive/serial_test_derive-3.5.0.crate")
          (file-name "rust-serial-test-derive-3.5.0.tar.gz")
          (sha256 (base16-string->bytevector "94e153fc76e1c6a068703d6d29c508a0b15c061c4b7e43da59cc097bc342673c")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/sharded-slab/sharded-slab-0.1.7.crate")
          (file-name "rust-sharded-slab-0.1.7.tar.gz")
          (sha256 (base16-string->bytevector "f40ca3c46823713e0d4209592e8d6e826aa57e928f09752619fc696c499637f6")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/shlex/shlex-1.3.0.crate")
          (file-name "rust-shlex-1.3.0.tar.gz")
          (sha256 (base16-string->bytevector "0fda2ff0d084019ba4d7c6f371c95d8fd75ce3524c3cb8fb653a3023f6323e64")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/signal-hook-registry/signal-hook-registry-1.4.8.crate")
          (file-name "rust-signal-hook-registry-1.4.8.tar.gz")
          (sha256 (base16-string->bytevector "c4db69cba1110affc0e9f7bcd48bbf87b3f4fc7c61fc9155afd4c469eb3d6c1b")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/slab/slab-0.4.12.crate")
          (file-name "rust-slab-0.4.12.tar.gz")
          (sha256 (base16-string->bytevector "0c790de23124f9ab44544d7ac05d60440adc586479ce501c1d6d7da3cd8c9cf5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/smallvec/smallvec-1.15.1.crate")
          (file-name "rust-smallvec-1.15.1.tar.gz")
          (sha256 (base16-string->bytevector "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/socket2/socket2-0.6.3.crate")
          (file-name "rust-socket2-0.6.3.tar.gz")
          (sha256 (base16-string->bytevector "3a766e1110788c36f4fa1c2b71b387a7815aa65f88ce0229841826633d93723e")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/stable_deref_trait/stable_deref_trait-1.2.1.crate")
          (file-name "rust-stable-deref-trait-1.2.1.tar.gz")
          (sha256 (base16-string->bytevector "6ce2be8dc25455e1f91df71bfa12ad37d7af1092ae736f3a6cd0e37bc7810596")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/static_assertions/static_assertions-1.1.0.crate")
          (file-name "rust-static-assertions-1.1.0.tar.gz")
          (sha256 (base16-string->bytevector "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/strum/strum-0.28.0.crate")
          (file-name "rust-strum-0.28.0.tar.gz")
          (sha256 (base16-string->bytevector "9628de9b8791db39ceda2b119bbe13134770b56c138ec1d3af810d045c04f9bd")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/strum_macros/strum_macros-0.28.0.crate")
          (file-name "rust-strum-macros-0.28.0.tar.gz")
          (sha256 (base16-string->bytevector "ab85eea0270ee17587ed4156089e10b9e6880ee688791d45a905f5b1ca36f664")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/syn/syn-2.0.117.crate")
          (file-name "rust-syn-2.0.117.tar.gz")
          (sha256 (base16-string->bytevector "e665b8803e7b1d2a727f4023456bbbbe74da67099c585258af0ad9c5013b9b99")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/synstructure/synstructure-0.13.2.crate")
          (file-name "rust-synstructure-0.13.2.tar.gz")
          (sha256 (base16-string->bytevector "728a70f3dbaf5bab7f0c4b1ac8d7ae5ea60a4b5549c8a5914361c99147a709d2")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/thiserror/thiserror-2.0.18.crate")
          (file-name "rust-thiserror-2.0.18.tar.gz")
          (sha256 (base16-string->bytevector "4288b5bcbc7920c07a1149a35cf9590a2aa808e0bc1eafaade0b80947865fbc4")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/thiserror-impl/thiserror-impl-2.0.18.crate")
          (file-name "rust-thiserror-impl-2.0.18.tar.gz")
          (sha256 (base16-string->bytevector "ebc4ee7f67670e9b64d05fa4253e753e016c6c95ff35b89b7941d6b856dec1d5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/thread_local/thread_local-1.1.9.crate")
          (file-name "rust-thread-local-1.1.9.tar.gz")
          (sha256 (base16-string->bytevector "f60246a4944f24f6e018aa17cdeffb7818b76356965d03b07d6a9886e8962185")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tinystr/tinystr-0.8.3.crate")
          (file-name "rust-tinystr-0.8.3.tar.gz")
          (sha256 (base16-string->bytevector "c8323304221c2a851516f22236c5722a72eaa19749016521d6dff0824447d96d")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tokio/tokio-1.52.3.crate")
          (file-name "rust-tokio-1.52.3.tar.gz")
          (sha256 (base16-string->bytevector "8fc7f01b389ac15039e4dc9531aa973a135d7a4135281b12d7c1bc79fd57fffe")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tokio-macros/tokio-macros-2.7.0.crate")
          (file-name "rust-tokio-macros-2.7.0.tar.gz")
          (sha256 (base16-string->bytevector "385a6cb71ab9ab790c5fe8d67f1645e6c450a7ce006a33de03daa956cf70a496")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tokio-stream/tokio-stream-0.1.18.crate")
          (file-name "rust-tokio-stream-0.1.18.tar.gz")
          (sha256 (base16-string->bytevector "32da49809aab5c3bc678af03902d4ccddea2a87d028d86392a4b1560c6906c70")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tokio-util/tokio-util-0.7.18.crate")
          (file-name "rust-tokio-util-0.7.18.tar.gz")
          (sha256 (base16-string->bytevector "9ae9cec805b01e8fc3fd2fe289f89149a9b66dd16786abd8b19cfa7b48cb0098")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/toml/toml-0.9.12+spec-1.1.0.crate")
          (file-name "rust-toml-0.9.12+spec-1.1.0.tar.gz")
          (sha256 (base16-string->bytevector "cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/toml_datetime/toml_datetime-0.7.5+spec-1.1.0.crate")
          (file-name "rust-toml-datetime-0.7.5+spec-1.1.0.tar.gz")
          (sha256 (base16-string->bytevector "92e1cfed4a3038bc5a127e35a2d360f145e1f4b971b551a2ba5fd7aedf7e1347")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/toml_parser/toml_parser-1.1.2+spec-1.1.0.crate")
          (file-name "rust-toml-parser-1.1.2+spec-1.1.0.tar.gz")
          (sha256 (base16-string->bytevector "a2abe9b86193656635d2411dc43050282ca48aa31c2451210f4202550afb7526")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/toml_writer/toml_writer-1.1.1+spec-1.1.0.crate")
          (file-name "rust-toml-writer-1.1.1+spec-1.1.0.tar.gz")
          (sha256 (base16-string->bytevector "756daf9b1013ebe47a8776667b466417e2d4c5679d441c26230efd9ef78692db")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tracing/tracing-0.1.44.crate")
          (file-name "rust-tracing-0.1.44.tar.gz")
          (sha256 (base16-string->bytevector "63e71662fa4b2a2c3a26f570f037eb95bb1f85397f3cd8076caed2f026a6d100")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tracing-attributes/tracing-attributes-0.1.31.crate")
          (file-name "rust-tracing-attributes-0.1.31.tar.gz")
          (sha256 (base16-string->bytevector "7490cfa5ec963746568740651ac6781f701c9c5ea257c58e057f3ba8cf69e8da")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tracing-core/tracing-core-0.1.36.crate")
          (file-name "rust-tracing-core-0.1.36.tar.gz")
          (sha256 (base16-string->bytevector "db97caf9d906fbde555dd62fa95ddba9eecfd14cb388e4f491a66d74cd5fb79a")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tracing-log/tracing-log-0.2.0.crate")
          (file-name "rust-tracing-log-0.2.0.tar.gz")
          (sha256 (base16-string->bytevector "ee855f1f400bd0e5c02d150ae5de3840039a3f54b025156404e34c23c03f47c3")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/tracing-subscriber/tracing-subscriber-0.3.23.crate")
          (file-name "rust-tracing-subscriber-0.3.23.tar.gz")
          (sha256 (base16-string->bytevector "cb7f578e5945fb242538965c2d0b04418d38ec25c79d160cd279bf0731c8d319")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/unicode-ident/unicode-ident-1.0.24.crate")
          (file-name "rust-unicode-ident-1.0.24.tar.gz")
          (sha256 (base16-string->bytevector "e6e4313cd5fcd3dad5cafa179702e2b244f760991f45397d14d4ebf38247da75")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/unicode-xid/unicode-xid-0.2.6.crate")
          (file-name "rust-unicode-xid-0.2.6.tar.gz")
          (sha256 (base16-string->bytevector "ebc1c04c71510c7f702b52b7c350734c9ff1295c464a03335b00bb84fc54f853")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/url/url-2.5.8.crate")
          (file-name "rust-url-2.5.8.tar.gz")
          (sha256 (base16-string->bytevector "ff67a8a4397373c3ef660812acab3268222035010ab8680ec4215f38ba3d0eed")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/utf8_iter/utf8_iter-1.0.4.crate")
          (file-name "rust-utf8-iter-1.0.4.tar.gz")
          (sha256 (base16-string->bytevector "b6c140620e7ffbb22c2dee59cafe6084a59b5ffc27a8859a5f0d494b5d52b6be")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/valuable/valuable-0.1.1.crate")
          (file-name "rust-valuable-0.1.1.tar.gz")
          (sha256 (base16-string->bytevector "ba73ea9cf16a25df0c8caa16c51acb937d5712a8429db78a3ee29d5dcacd3a65")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasi/wasi-0.11.1+wasi-snapshot-preview1.crate")
          (file-name "rust-wasi-0.11.1+wasi-snapshot-preview1.tar.gz")
          (sha256 (base16-string->bytevector "ccf3ec651a847eb01de73ccad15eb7d99f80485de043efb2f370cd654f4ea44b")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasip2/wasip2-1.0.3+wasi-0.2.9.crate")
          (file-name "rust-wasip2-1.0.3+wasi-0.2.9.tar.gz")
          (sha256 (base16-string->bytevector "20064672db26d7cdc89c7798c48a0fdfac8213434a1186e5ef29fd560ae223d6")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasip3/wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06.crate")
          (file-name "rust-wasip3-0.4.0+wasi-0.3.0-rc-2026-01-06.tar.gz")
          (sha256 (base16-string->bytevector "5428f8bf88ea5ddc08faddef2ac4a67e390b88186c703ce6dbd955e1c145aca5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasm-bindgen/wasm-bindgen-0.2.118.crate")
          (file-name "rust-wasm-bindgen-0.2.118.tar.gz")
          (sha256 (base16-string->bytevector "0bf938a0bacb0469e83c1e148908bd7d5a6010354cf4fb73279b7447422e3a89")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasm-bindgen-macro/wasm-bindgen-macro-0.2.118.crate")
          (file-name "rust-wasm-bindgen-macro-0.2.118.tar.gz")
          (sha256 (base16-string->bytevector "eeff24f84126c0ec2db7a449f0c2ec963c6a49efe0698c4242929da037ca28ed")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasm-bindgen-macro-support/wasm-bindgen-macro-support-0.2.118.crate")
          (file-name "rust-wasm-bindgen-macro-support-0.2.118.tar.gz")
          (sha256 (base16-string->bytevector "9d08065faf983b2b80a79fd87d8254c409281cf7de75fc4b773019824196c904")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasm-bindgen-shared/wasm-bindgen-shared-0.2.118.crate")
          (file-name "rust-wasm-bindgen-shared-0.2.118.tar.gz")
          (sha256 (base16-string->bytevector "5fd04d9e306f1907bd13c6361b5c6bfc7b3b3c095ed3f8a9246390f8dbdee129")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasm-encoder/wasm-encoder-0.244.0.crate")
          (file-name "rust-wasm-encoder-0.244.0.tar.gz")
          (sha256 (base16-string->bytevector "990065f2fe63003fe337b932cfb5e3b80e0b4d0f5ff650e6985b1048f62c8319")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasm-metadata/wasm-metadata-0.244.0.crate")
          (file-name "rust-wasm-metadata-0.244.0.tar.gz")
          (sha256 (base16-string->bytevector "bb0e353e6a2fbdc176932bbaab493762eb1255a7900fe0fea1a2f96c296cc909")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wasmparser/wasmparser-0.244.0.crate")
          (file-name "rust-wasmparser-0.244.0.tar.gz")
          (sha256 (base16-string->bytevector "47b807c72e1bac69382b3a6fb3dbe8ea4c0ed87ff5629b8685ae6b9a611028fe")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/widestring/widestring-1.2.1.crate")
          (file-name "rust-widestring-1.2.1.tar.gz")
          (sha256 (base16-string->bytevector "72069c3113ab32ab29e5584db3c6ec55d416895e60715417b5b883a357c3e471")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-core/windows-core-0.62.2.crate")
          (file-name "rust-windows-core-0.62.2.tar.gz")
          (sha256 (base16-string->bytevector "b8e83a14d34d0623b51dce9581199302a221863196a1dde71a7663a4c2be9deb")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-implement/windows-implement-0.60.2.crate")
          (file-name "rust-windows-implement-0.60.2.tar.gz")
          (sha256 (base16-string->bytevector "053e2e040ab57b9dc951b72c264860db7eb3b0200ba345b4e4c3b14f67855ddf")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-interface/windows-interface-0.59.3.crate")
          (file-name "rust-windows-interface-0.59.3.tar.gz")
          (sha256 (base16-string->bytevector "3f316c4a2570ba26bbec722032c4099d8c8bc095efccdc15688708623367e358")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-link/windows-link-0.2.1.crate")
          (file-name "rust-windows-link-0.2.1.tar.gz")
          (sha256 (base16-string->bytevector "f0805222e57f7521d6a62e36fa9163bc891acd422f971defe97d64e70d0a4fe5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-result/windows-result-0.4.1.crate")
          (file-name "rust-windows-result-0.4.1.tar.gz")
          (sha256 (base16-string->bytevector "7781fa89eaf60850ac3d2da7af8e5242a5ea78d1a11c49bf2910bb5a73853eb5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-service/windows-service-0.8.1.crate")
          (file-name "rust-windows-service-0.8.1.tar.gz")
          (sha256 (base16-string->bytevector "857224b3b211c6f3616921f081ee54721ee3ad2ace2fac6a6337e032f7b4dcf2")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-strings/windows-strings-0.5.1.crate")
          (file-name "rust-windows-strings-0.5.1.tar.gz")
          (sha256 (base16-string->bytevector "7837d08f69c77cf6b07689544538e017c1bfcf57e34b4c0ff58e6c2cd3b37091")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/windows-sys/windows-sys-0.61.2.crate")
          (file-name "rust-windows-sys-0.61.2.tar.gz")
          (sha256 (base16-string->bytevector "ae137229bcbd6cdf0f7b80a31df61766145077ddf49416a728b02cb3921ff3fc")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/winnow/winnow-0.7.15.crate")
          (file-name "rust-winnow-0.7.15.tar.gz")
          (sha256 (base16-string->bytevector "df79d97927682d2fd8adb29682d1140b343be4ac0f08fd68b7765d9c059d3945")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/winnow/winnow-1.0.2.crate")
          (file-name "rust-winnow-1.0.2.tar.gz")
          (sha256 (base16-string->bytevector "2ee1708bef14716a11bae175f579062d4554d95be2c6829f518df847b7b3fdd0")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-bindgen/wit-bindgen-0.51.0.crate")
          (file-name "rust-wit-bindgen-0.51.0.tar.gz")
          (sha256 (base16-string->bytevector "d7249219f66ced02969388cf2bb044a09756a083d0fab1e566056b04d9fbcaa5")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-bindgen/wit-bindgen-0.57.1.crate")
          (file-name "rust-wit-bindgen-0.57.1.tar.gz")
          (sha256 (base16-string->bytevector "1ebf944e87a7c253233ad6766e082e3cd714b5d03812acc24c318f549614536e")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-bindgen-core/wit-bindgen-core-0.51.0.crate")
          (file-name "rust-wit-bindgen-core-0.51.0.tar.gz")
          (sha256 (base16-string->bytevector "ea61de684c3ea68cb082b7a88508a8b27fcc8b797d738bfc99a82facf1d752dc")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-bindgen-rust/wit-bindgen-rust-0.51.0.crate")
          (file-name "rust-wit-bindgen-rust-0.51.0.tar.gz")
          (sha256 (base16-string->bytevector "b7c566e0f4b284dd6561c786d9cb0142da491f46a9fbed79ea69cdad5db17f21")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-bindgen-rust-macro/wit-bindgen-rust-macro-0.51.0.crate")
          (file-name "rust-wit-bindgen-rust-macro-0.51.0.tar.gz")
          (sha256 (base16-string->bytevector "0c0f9bfd77e6a48eccf51359e3ae77140a7f50b1e2ebfe62422d8afdaffab17a")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-component/wit-component-0.244.0.crate")
          (file-name "rust-wit-component-0.244.0.tar.gz")
          (sha256 (base16-string->bytevector "9d66ea20e9553b30172b5e831994e35fbde2d165325bec84fc43dbf6f4eb9cb2")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/wit-parser/wit-parser-0.244.0.crate")
          (file-name "rust-wit-parser-0.244.0.tar.gz")
          (sha256 (base16-string->bytevector "ecc8ac4bc1dc3381b7f59c34f00b67e18f910c2c0f50015669dde7def656a736")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/writeable/writeable-0.6.3.crate")
          (file-name "rust-writeable-0.6.3.tar.gz")
          (sha256 (base16-string->bytevector "1ffae5123b2d3fc086436f8834ae3ab053a283cfac8fe0a0b8eaae044768a4c4")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/yoke/yoke-0.8.2.crate")
          (file-name "rust-yoke-0.8.2.tar.gz")
          (sha256 (base16-string->bytevector "abe8c5fda708d9ca3df187cae8bfb9ceda00dd96231bed36e445a1a48e66f9ca")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/yoke-derive/yoke-derive-0.8.2.crate")
          (file-name "rust-yoke-derive-0.8.2.tar.gz")
          (sha256 (base16-string->bytevector "de844c262c8848816172cef550288e7dc6c7b7814b4ee56b3e1553f275f1858e")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/zerofrom/zerofrom-0.1.7.crate")
          (file-name "rust-zerofrom-0.1.7.tar.gz")
          (sha256 (base16-string->bytevector "69faa1f2a1ea75661980b013019ed6687ed0e83d069bc1114e2cc74c6c04c4df")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/zerofrom-derive/zerofrom-derive-0.1.7.crate")
          (file-name "rust-zerofrom-derive-0.1.7.tar.gz")
          (sha256 (base16-string->bytevector "11532158c46691caf0f2593ea8358fed6bbf68a0315e80aae9bd41fbade684a1")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/zerotrie/zerotrie-0.2.4.crate")
          (file-name "rust-zerotrie-0.2.4.tar.gz")
          (sha256 (base16-string->bytevector "0f9152d31db0792fa83f70fb2f83148effb5c1f5b8c7686c3459e361d9bc20bf")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/zerovec/zerovec-0.11.6.crate")
          (file-name "rust-zerovec-0.11.6.tar.gz")
          (sha256 (base16-string->bytevector "90f911cbc359ab6af17377d242225f4d75119aec87ea711a880987b18cd7b239")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/zerovec-derive/zerovec-derive-0.11.3.crate")
          (file-name "rust-zerovec-derive-0.11.3.tar.gz")
          (sha256 (base16-string->bytevector "625dc425cab0dca6dc3c3319506e6593dcb08a9f387ea3b284dbd52a92c40555")))
    (origin
          (method url-fetch)
          (uri "https://static.crates.io/crates/zmij/zmij-1.0.21.crate")
          (file-name "rust-zmij-1.0.21.tar.gz")
          (sha256 (base16-string->bytevector "b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa")))
    ))
