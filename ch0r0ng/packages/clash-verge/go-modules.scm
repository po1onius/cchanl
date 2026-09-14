;;; Pinned module proxy files verified against Mihomo 1.19.30's go.sum.
(define-module (ch0r0ng packages clash-verge go-modules)
  #:use-module (guix base16)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:export (%mihomo-module-files))

(define %mihomo-module-files
  (list
    (list "github.com/!ryua!nerin/go-krypto/@v/v1.3.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!ryua!nerin/go-krypto/@v/v1.3.0.info")
          (file-name "go-github.com-_ryua_nerin-go-krypto-_v-v1.3.0.info")
          (sha256 (base16-string->bytevector "1e8af735f74c28da9b3428c29dbe3b76da5a2b0a3a3d51b513c2cfbc2b3d3c7c"))))
    (list "github.com/!ryua!nerin/go-krypto/@v/v1.3.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!ryua!nerin/go-krypto/@v/v1.3.0.mod")
          (file-name "go-github.com-_ryua_nerin-go-krypto-_v-v1.3.0.mod")
          (sha256 (base16-string->bytevector "536483d794f17cf79a218d491512afce793755240e32bc632b062729e74a07f7"))))
    (list "github.com/!ryua!nerin/go-krypto/@v/v1.3.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!ryua!nerin/go-krypto/@v/v1.3.0.zip")
          (file-name "go-github.com-_ryua_nerin-go-krypto-_v-v1.3.0.zip")
          (sha256 (base16-string->bytevector "4f98d5d243e2706b588fba752dd8a75c0e2e76542a990a3c6494fc0aac3e9a9b"))))
    (list "github.com/!ryua!nerin/testingutil/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!ryua!nerin/testingutil/@v/v0.1.0.info")
          (file-name "go-github.com-_ryua_nerin-testingutil-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "929bf85aff44465b8a5581dfaf934e41446f2232cbbb956d1217720c3eb57ff4"))))
    (list "github.com/!ryua!nerin/testingutil/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!ryua!nerin/testingutil/@v/v0.1.0.zip")
          (file-name "go-github.com-_ryua_nerin-testingutil-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "253382e4ad976ece6944045be53429028d484b3cf66a447a2393e5df34e8fa46"))))
    (list "github.com/!yawning/aez/@v/v0.0.0-20211027044916-e49e68abd344.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!yawning/aez/@v/v0.0.0-20211027044916-e49e68abd344.info")
          (file-name "go-github.com-_yawning-aez-_v-v0.0.0-20211027044916-e49e68abd344.info")
          (sha256 (base16-string->bytevector "1d59ebcdda09e4f3f0d847e582772922c25c7d3d3a99d6e7b93bf269c184c16f"))))
    (list "github.com/!yawning/aez/@v/v0.0.0-20211027044916-e49e68abd344.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!yawning/aez/@v/v0.0.0-20211027044916-e49e68abd344.mod")
          (file-name "go-github.com-_yawning-aez-_v-v0.0.0-20211027044916-e49e68abd344.mod")
          (sha256 (base16-string->bytevector "ef798a62d275a03c3833d8e4c4fe9c6d34af47d434ec4f0ec0ee458f9baffede"))))
    (list "github.com/!yawning/aez/@v/v0.0.0-20211027044916-e49e68abd344.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/!yawning/aez/@v/v0.0.0-20211027044916-e49e68abd344.zip")
          (file-name "go-github.com-_yawning-aez-_v-v0.0.0-20211027044916-e49e68abd344.zip")
          (sha256 (base16-string->bytevector "aa90c86cd46a111c7c86e7653cdcd4099059ba9ac63d235b496c1e1886f52a0f"))))
    (list "github.com/ajg/form/@v/v1.7.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ajg/form/@v/v1.7.1.info")
          (file-name "go-github.com-ajg-form-_v-v1.7.1.info")
          (sha256 (base16-string->bytevector "abf2921eca064b297e2495d57d285c5a7aef2e6409680193313820db7b862a63"))))
    (list "github.com/ajg/form/@v/v1.7.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ajg/form/@v/v1.7.1.mod")
          (file-name "go-github.com-ajg-form-_v-v1.7.1.mod")
          (sha256 (base16-string->bytevector "9f325da1cba1ab39a4080d2bd0c34bb614a576450339dc99d7e86fb678a1a9ca"))))
    (list "github.com/ajg/form/@v/v1.7.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ajg/form/@v/v1.7.1.zip")
          (file-name "go-github.com-ajg-form-_v-v1.7.1.zip")
          (sha256 (base16-string->bytevector "683da1615a209adbf425bf612d666f6ed3e2e6a248cf8eeb93365c26d8b40a2c"))))
    (list "github.com/akutz/memconn/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/akutz/memconn/@v/v0.1.0.info")
          (file-name "go-github.com-akutz-memconn-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "1359c0c2cea42073620062ae915f08d8915b365f59847a42d1619a40a9578248"))))
    (list "github.com/akutz/memconn/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/akutz/memconn/@v/v0.1.0.mod")
          (file-name "go-github.com-akutz-memconn-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "9a1b79fe03282a79fc3f8728ecc70cf7a930c243fe07706f3bc1e4cf93f39987"))))
    (list "github.com/akutz/memconn/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/akutz/memconn/@v/v0.1.0.zip")
          (file-name "go-github.com-akutz-memconn-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "d56211ea9afd0c85f84231fb33dfad0ab2687e0ff6b34b8a6b37e57af4f64196"))))
    (list "github.com/andybalholm/brotli/@v/v1.1.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/andybalholm/brotli/@v/v1.1.1.info")
          (file-name "go-github.com-andybalholm-brotli-_v-v1.1.1.info")
          (sha256 (base16-string->bytevector "19bc8744d0d16fdf476f9aa0424ea004d922ab7a71b5cc2b3d1f330bd76d31da"))))
    (list "github.com/andybalholm/brotli/@v/v1.1.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/andybalholm/brotli/@v/v1.1.1.mod")
          (file-name "go-github.com-andybalholm-brotli-_v-v1.1.1.mod")
          (sha256 (base16-string->bytevector "bc0a2cdd9c9ef8041b184ecbd2365cb223ae6b945c565b053258364a670c3ec9"))))
    (list "github.com/andybalholm/brotli/@v/v1.1.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/andybalholm/brotli/@v/v1.1.1.zip")
          (file-name "go-github.com-andybalholm-brotli-_v-v1.1.1.zip")
          (sha256 (base16-string->bytevector "d183c2a1277d2784861bfa89e3903ecba31ef08237c3e92fbdfd4ab0b551154e"))))
    (list "github.com/bahlo/generic-list-go/@v/v0.2.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bahlo/generic-list-go/@v/v0.2.0.info")
          (file-name "go-github.com-bahlo-generic-list-go-_v-v0.2.0.info")
          (sha256 (base16-string->bytevector "7c2ac6458e3b7d55d34d3a09c0d0474be3d8cf1e40445868805f4429d1029d70"))))
    (list "github.com/bahlo/generic-list-go/@v/v0.2.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bahlo/generic-list-go/@v/v0.2.0.mod")
          (file-name "go-github.com-bahlo-generic-list-go-_v-v0.2.0.mod")
          (sha256 (base16-string->bytevector "963215560d40b8b6b6363b343e042a84389b76ec6ca6ff4b1322038f42ee95de"))))
    (list "github.com/bahlo/generic-list-go/@v/v0.2.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bahlo/generic-list-go/@v/v0.2.0.zip")
          (file-name "go-github.com-bahlo-generic-list-go-_v-v0.2.0.zip")
          (sha256 (base16-string->bytevector "e773fa812176a62f1d27d7a1e7589683f5e5af2d36628fa6a5a522e59474c504"))))
    (list "github.com/blang/semver/@v/v3.5.1+incompatible.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/blang/semver/@v/v3.5.1+incompatible.mod")
          (file-name "go-github.com-blang-semver-_v-v3.5.1+incompatible.mod")
          (sha256 (base16-string->bytevector "63bdcb88b2383e6591a1dcf521494c732b28c7abe8d9b18c21671efe23d7ba78"))))
    (list "github.com/bodgit/plumbing/@v/v1.3.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bodgit/plumbing/@v/v1.3.0.info")
          (file-name "go-github.com-bodgit-plumbing-_v-v1.3.0.info")
          (sha256 (base16-string->bytevector "b76ce3f70edbdcb7b7ce0667ba7e26bb6dc9f78f88bed54f98c9a205a2f38d6a"))))
    (list "github.com/bodgit/plumbing/@v/v1.3.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bodgit/plumbing/@v/v1.3.0.mod")
          (file-name "go-github.com-bodgit-plumbing-_v-v1.3.0.mod")
          (sha256 (base16-string->bytevector "47c6e79a0285fbacce06096f0f8e7d730aa1491d5b7b015c3198ba0b80647570"))))
    (list "github.com/bodgit/plumbing/@v/v1.3.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bodgit/plumbing/@v/v1.3.0.zip")
          (file-name "go-github.com-bodgit-plumbing-_v-v1.3.0.zip")
          (sha256 (base16-string->bytevector "15c80dc98fd6b972798a6c24a002f6fb00b28abdc9928185206a5abc5e56a089"))))
    (list "github.com/bodgit/windows/@v/v1.0.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bodgit/windows/@v/v1.0.1.info")
          (file-name "go-github.com-bodgit-windows-_v-v1.0.1.info")
          (sha256 (base16-string->bytevector "956c1a55f408ea39a930024b39c33be59d1ff460df0d19229c5854da540edefa"))))
    (list "github.com/bodgit/windows/@v/v1.0.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bodgit/windows/@v/v1.0.1.mod")
          (file-name "go-github.com-bodgit-windows-_v-v1.0.1.mod")
          (sha256 (base16-string->bytevector "89f0c3b76ed9bc76f2f3ffe449890b627465d7cd6893e860168f5b75feec85fe"))))
    (list "github.com/bodgit/windows/@v/v1.0.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/bodgit/windows/@v/v1.0.1.zip")
          (file-name "go-github.com-bodgit-windows-_v-v1.0.1.zip")
          (sha256 (base16-string->bytevector "cbe5f1c687372fd463b19c05b2cfdd3cdcaad86baea38f83ebe580b26f19e956"))))
    (list "github.com/cilium/ebpf/@v/v0.12.3.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/cilium/ebpf/@v/v0.12.3.info")
          (file-name "go-github.com-cilium-ebpf-_v-v0.12.3.info")
          (sha256 (base16-string->bytevector "4ed6f99d317aca14852c18dca6adbc45c8fab861815836794c4b223a7ec9abc4"))))
    (list "github.com/cilium/ebpf/@v/v0.12.3.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/cilium/ebpf/@v/v0.12.3.zip")
          (file-name "go-github.com-cilium-ebpf-_v-v0.12.3.zip")
          (sha256 (base16-string->bytevector "7e0016701b808c81a00cc45e6d93b4a6c8380d9db4824c86f6f241686280adac"))))
    (list "github.com/coder/websocket/@v/v1.8.12.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/coder/websocket/@v/v1.8.12.info")
          (file-name "go-github.com-coder-websocket-_v-v1.8.12.info")
          (sha256 (base16-string->bytevector "980b058eb22977dd164e3ba3893415de2ec01e3cbc2b661670edb9d1ccc7a5bc"))))
    (list "github.com/coder/websocket/@v/v1.8.12.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/coder/websocket/@v/v1.8.12.mod")
          (file-name "go-github.com-coder-websocket-_v-v1.8.12.mod")
          (sha256 (base16-string->bytevector "61d60dcecabd24e19d1fd9a2717feae570b45b0e619acc92c4aa543838d160d9"))))
    (list "github.com/coder/websocket/@v/v1.8.12.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/coder/websocket/@v/v1.8.12.zip")
          (file-name "go-github.com-coder-websocket-_v-v1.8.12.zip")
          (sha256 (base16-string->bytevector "ad8d323970c04679f4566ee7db98946508c37cdd21a46a875d5257d631a9e990"))))
    (list "github.com/coreos/go-iptables/@v/v0.8.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/coreos/go-iptables/@v/v0.8.0.info")
          (file-name "go-github.com-coreos-go-iptables-_v-v0.8.0.info")
          (sha256 (base16-string->bytevector "88ef84a3348ef829faa6594594fa3e6ce8dc4751b0677efbc0d82d40cab61a5e"))))
    (list "github.com/coreos/go-iptables/@v/v0.8.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/coreos/go-iptables/@v/v0.8.0.mod")
          (file-name "go-github.com-coreos-go-iptables-_v-v0.8.0.mod")
          (sha256 (base16-string->bytevector "b72bc9bc2ec923366b39a0dd6979db3533c74f6b4d680a4b1d8056a7b169e259"))))
    (list "github.com/coreos/go-iptables/@v/v0.8.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/coreos/go-iptables/@v/v0.8.0.zip")
          (file-name "go-github.com-coreos-go-iptables-_v-v0.8.0.zip")
          (sha256 (base16-string->bytevector "48d679f4287e901385f1707d83e8e766089feee5ec36d0810b23d3b7ddeec4d1"))))
    (list "github.com/davecgh/go-spew/@v/v1.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/davecgh/go-spew/@v/v1.1.0.mod")
          (file-name "go-github.com-davecgh-go-spew-_v-v1.1.0.mod")
          (sha256 (base16-string->bytevector "bcb29393251237b79a17b6c19bf29134f43e8f438c3198988fcd461a1cdf05cc"))))
    (list "github.com/davecgh/go-spew/@v/v1.1.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/davecgh/go-spew/@v/v1.1.1.info")
          (file-name "go-github.com-davecgh-go-spew-_v-v1.1.1.info")
          (sha256 (base16-string->bytevector "73de263267a4545708302d807be60fdb649c5c7b981d25302a638145fba0ec47"))))
    (list "github.com/davecgh/go-spew/@v/v1.1.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/davecgh/go-spew/@v/v1.1.1.mod")
          (file-name "go-github.com-davecgh-go-spew-_v-v1.1.1.mod")
          (sha256 (base16-string->bytevector "bcb29393251237b79a17b6c19bf29134f43e8f438c3198988fcd461a1cdf05cc"))))
    (list "github.com/davecgh/go-spew/@v/v1.1.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/davecgh/go-spew/@v/v1.1.1.zip")
          (file-name "go-github.com-davecgh-go-spew-_v-v1.1.1.zip")
          (sha256 (base16-string->bytevector "6b44a843951f371b7010c754ecc3cabefe815d5ced1c5b9409fb2d697e8a890d"))))
    (list "github.com/dlclark/regexp2/@v/v1.12.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/dlclark/regexp2/@v/v1.12.0.info")
          (file-name "go-github.com-dlclark-regexp2-_v-v1.12.0.info")
          (sha256 (base16-string->bytevector "cf881c90a5811f7b0e32bd87d689d13fa9b6a1d6a8a050f3467087e8fa8d80f9"))))
    (list "github.com/dlclark/regexp2/@v/v1.12.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/dlclark/regexp2/@v/v1.12.0.mod")
          (file-name "go-github.com-dlclark-regexp2-_v-v1.12.0.mod")
          (sha256 (base16-string->bytevector "7017e81fb9fa9227a3180a62e323158b4523c67062f0a8aa08637c092b8d4aa7"))))
    (list "github.com/dlclark/regexp2/@v/v1.12.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/dlclark/regexp2/@v/v1.12.0.zip")
          (file-name "go-github.com-dlclark-regexp2-_v-v1.12.0.zip")
          (sha256 (base16-string->bytevector "dac93d7598b95a6a2c8b334f98078c77d22e29a85b4f73573591bcda65406636"))))
    (list "github.com/dunglas/httpsfv/@v/v1.0.2.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/dunglas/httpsfv/@v/v1.0.2.info")
          (file-name "go-github.com-dunglas-httpsfv-_v-v1.0.2.info")
          (sha256 (base16-string->bytevector "c524fb692f6514a0f4f5a8e847fa6e684393a8db1d6b3c81eee96e0b1839566c"))))
    (list "github.com/dunglas/httpsfv/@v/v1.0.2.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/dunglas/httpsfv/@v/v1.0.2.mod")
          (file-name "go-github.com-dunglas-httpsfv-_v-v1.0.2.mod")
          (sha256 (base16-string->bytevector "6b1e5bec67de8fc5da677f8f9ae994657209d8cee9d2f60e8cb225f0be1fb37a"))))
    (list "github.com/dunglas/httpsfv/@v/v1.0.2.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/dunglas/httpsfv/@v/v1.0.2.zip")
          (file-name "go-github.com-dunglas-httpsfv-_v-v1.0.2.zip")
          (sha256 (base16-string->bytevector "c1570b9a558b1d780e9e0058f93ce951fdf9f8e74f647ed69864a036403af803"))))
    (list "github.com/enfein/mieru/v3/@v/v3.35.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/enfein/mieru/v3/@v/v3.35.0.info")
          (file-name "go-github.com-enfein-mieru-v3-_v-v3.35.0.info")
          (sha256 (base16-string->bytevector "b446576b6a3c88d3645d8b30672c166169076dcbd71c0ed26aa8d45e5dc1197d"))))
    (list "github.com/enfein/mieru/v3/@v/v3.35.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/enfein/mieru/v3/@v/v3.35.0.mod")
          (file-name "go-github.com-enfein-mieru-v3-_v-v3.35.0.mod")
          (sha256 (base16-string->bytevector "8e5c9b5a2626b7b4431f5541adffa731e558bbfd85b8a0240d5d2acb539686b3"))))
    (list "github.com/enfein/mieru/v3/@v/v3.35.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/enfein/mieru/v3/@v/v3.35.0.zip")
          (file-name "go-github.com-enfein-mieru-v3-_v-v3.35.0.zip")
          (sha256 (base16-string->bytevector "dacaf079409d3c64b391e708617e674fcdef41add5f1f7b706d0d273b897e73b"))))
    (list "github.com/ericlagergren/aegis/@v/v0.0.0-20250325060835-cd0defd64358.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/aegis/@v/v0.0.0-20250325060835-cd0defd64358.info")
          (file-name "go-github.com-ericlagergren-aegis-_v-v0.0.0-20250325060835-cd0defd64358.info")
          (sha256 (base16-string->bytevector "c6b6bb8aa3d12604b80b6a4566b9f26a4378ca71f36bd5251de49dffd8a94a44"))))
    (list "github.com/ericlagergren/aegis/@v/v0.0.0-20250325060835-cd0defd64358.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/aegis/@v/v0.0.0-20250325060835-cd0defd64358.mod")
          (file-name "go-github.com-ericlagergren-aegis-_v-v0.0.0-20250325060835-cd0defd64358.mod")
          (sha256 (base16-string->bytevector "c1f06f26e1efba402486501647f19b11ff0b592989606266175c8452841d6a5d"))))
    (list "github.com/ericlagergren/aegis/@v/v0.0.0-20250325060835-cd0defd64358.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/aegis/@v/v0.0.0-20250325060835-cd0defd64358.zip")
          (file-name "go-github.com-ericlagergren-aegis-_v-v0.0.0-20250325060835-cd0defd64358.zip")
          (sha256 (base16-string->bytevector "9c2daea819a0849f1d7137aac3c332184ecdd662338cf5718b9caef9c79226db"))))
    (list "github.com/ericlagergren/polyval/@v/v0.0.0-20220411101811-e25bc10ba391.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/polyval/@v/v0.0.0-20220411101811-e25bc10ba391.info")
          (file-name "go-github.com-ericlagergren-polyval-_v-v0.0.0-20220411101811-e25bc10ba391.info")
          (sha256 (base16-string->bytevector "47fdc1602b26f49cbc4f08dabbc1d6563c97fd0182fe2ee0d4ef4e30b337b6e8"))))
    (list "github.com/ericlagergren/polyval/@v/v0.0.0-20220411101811-e25bc10ba391.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/polyval/@v/v0.0.0-20220411101811-e25bc10ba391.mod")
          (file-name "go-github.com-ericlagergren-polyval-_v-v0.0.0-20220411101811-e25bc10ba391.mod")
          (sha256 (base16-string->bytevector "6386751f2171efb3c35776e12bd267c59d28811cafed385f24ba375137cfbce4"))))
    (list "github.com/ericlagergren/polyval/@v/v0.0.0-20220411101811-e25bc10ba391.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/polyval/@v/v0.0.0-20220411101811-e25bc10ba391.zip")
          (file-name "go-github.com-ericlagergren-polyval-_v-v0.0.0-20220411101811-e25bc10ba391.zip")
          (sha256 (base16-string->bytevector "47adb15e96f65fb2e461bfa50ff1601e99a24eef1ab0cd47a0d7f35149f84c76"))))
    (list "github.com/ericlagergren/saferand/@v/v0.0.0-20220206064634-960a4dd2bc5c.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/saferand/@v/v0.0.0-20220206064634-960a4dd2bc5c.info")
          (file-name "go-github.com-ericlagergren-saferand-_v-v0.0.0-20220206064634-960a4dd2bc5c.info")
          (sha256 (base16-string->bytevector "1001368abcc98986df4e311328c950d6a987023d45fad67f19af66d674a1d9e7"))))
    (list "github.com/ericlagergren/saferand/@v/v0.0.0-20220206064634-960a4dd2bc5c.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/saferand/@v/v0.0.0-20220206064634-960a4dd2bc5c.zip")
          (file-name "go-github.com-ericlagergren-saferand-_v-v0.0.0-20220206064634-960a4dd2bc5c.zip")
          (sha256 (base16-string->bytevector "d46a174240962acd701ccd12684a9d9b762cf2c0504a5a7ce2c6ccf882fae1dd"))))
    (list "github.com/ericlagergren/siv/@v/v0.0.0-20220507050439-0b757b3aa5f1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/siv/@v/v0.0.0-20220507050439-0b757b3aa5f1.info")
          (file-name "go-github.com-ericlagergren-siv-_v-v0.0.0-20220507050439-0b757b3aa5f1.info")
          (sha256 (base16-string->bytevector "b0790a1917dac712b3a18cd72f87fa75dbb15bddee374da330e3ce5f691cdbf2"))))
    (list "github.com/ericlagergren/siv/@v/v0.0.0-20220507050439-0b757b3aa5f1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/siv/@v/v0.0.0-20220507050439-0b757b3aa5f1.mod")
          (file-name "go-github.com-ericlagergren-siv-_v-v0.0.0-20220507050439-0b757b3aa5f1.mod")
          (sha256 (base16-string->bytevector "8ac8008bcef585c92bc13675f0459f02a97fb04471c972a3e67cf22ce0b9c700"))))
    (list "github.com/ericlagergren/siv/@v/v0.0.0-20220507050439-0b757b3aa5f1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/siv/@v/v0.0.0-20220507050439-0b757b3aa5f1.zip")
          (file-name "go-github.com-ericlagergren-siv-_v-v0.0.0-20220507050439-0b757b3aa5f1.zip")
          (sha256 (base16-string->bytevector "9ac3191d9dcddc0a05fc64b6798b0ba30e2bbf1814d2c06c55b30d3776dd80e4"))))
    (list "github.com/ericlagergren/subtle/@v/v0.0.0-20220507045147-890d697da010.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/subtle/@v/v0.0.0-20220507045147-890d697da010.info")
          (file-name "go-github.com-ericlagergren-subtle-_v-v0.0.0-20220507045147-890d697da010.info")
          (sha256 (base16-string->bytevector "745e9f4a1a2ed4ef98d88f5dcb47ed633ccebbb0c8a9f2b8699944068a1d8bea"))))
    (list "github.com/ericlagergren/subtle/@v/v0.0.0-20220507045147-890d697da010.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/subtle/@v/v0.0.0-20220507045147-890d697da010.mod")
          (file-name "go-github.com-ericlagergren-subtle-_v-v0.0.0-20220507045147-890d697da010.mod")
          (sha256 (base16-string->bytevector "a01ee592ceb164d6737eda9a0158ac420ae5207cd4f9b8c18345723e5273dfd7"))))
    (list "github.com/ericlagergren/subtle/@v/v0.0.0-20220507045147-890d697da010.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ericlagergren/subtle/@v/v0.0.0-20220507045147-890d697da010.zip")
          (file-name "go-github.com-ericlagergren-subtle-_v-v0.0.0-20220507045147-890d697da010.zip")
          (sha256 (base16-string->bytevector "3d3408d53b90ce6c2a69d456919e1fa5cd3f994582736bcaa7000bb63c139cb9"))))
    (list "github.com/frankban/quicktest/@v/v1.14.6.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/frankban/quicktest/@v/v1.14.6.info")
          (file-name "go-github.com-frankban-quicktest-_v-v1.14.6.info")
          (sha256 (base16-string->bytevector "e68f28b75f0902ab2a00ad3f4ab77378d81a4f927d002622a996024a5b8c921a"))))
    (list "github.com/frankban/quicktest/@v/v1.14.6.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/frankban/quicktest/@v/v1.14.6.zip")
          (file-name "go-github.com-frankban-quicktest-_v-v1.14.6.zip")
          (sha256 (base16-string->bytevector "8c7377023523780b2a6508f3c06bd3bbefd3dda064533ad6ff6724986234988d"))))
    (list "github.com/fsnotify/fsnotify/@v/v1.9.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/fsnotify/fsnotify/@v/v1.9.0.info")
          (file-name "go-github.com-fsnotify-fsnotify-_v-v1.9.0.info")
          (sha256 (base16-string->bytevector "5c1c5e0814ee40dfdca882a0e6314b88ff0e1902261e118d2178710b23e52466"))))
    (list "github.com/fsnotify/fsnotify/@v/v1.9.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/fsnotify/fsnotify/@v/v1.9.0.mod")
          (file-name "go-github.com-fsnotify-fsnotify-_v-v1.9.0.mod")
          (sha256 (base16-string->bytevector "da3713c5c57d252d25520de0e6b397b033858b3aff5dddf21164abe3297c9ff9"))))
    (list "github.com/fsnotify/fsnotify/@v/v1.9.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/fsnotify/fsnotify/@v/v1.9.0.zip")
          (file-name "go-github.com-fsnotify-fsnotify-_v-v1.9.0.zip")
          (sha256 (base16-string->bytevector "94e64824b23591b7aa504e3321d5ec3f57de88f4d49882eaefbbf6820dab746e"))))
    (list "github.com/fxamacker/cbor/v2/@v/v2.9.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/fxamacker/cbor/v2/@v/v2.9.0.info")
          (file-name "go-github.com-fxamacker-cbor-v2-_v-v2.9.0.info")
          (sha256 (base16-string->bytevector "3ad15672a3518a677499eeeee59e17c450f996c83237fe5ebab71922e8d93d1c"))))
    (list "github.com/fxamacker/cbor/v2/@v/v2.9.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/fxamacker/cbor/v2/@v/v2.9.0.mod")
          (file-name "go-github.com-fxamacker-cbor-v2-_v-v2.9.0.mod")
          (sha256 (base16-string->bytevector "d7bbc7167a38275831838773356370c370d2ce3ed28c60486f52cdd5a799c92b"))))
    (list "github.com/fxamacker/cbor/v2/@v/v2.9.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/fxamacker/cbor/v2/@v/v2.9.0.zip")
          (file-name "go-github.com-fxamacker-cbor-v2-_v-v2.9.0.zip")
          (sha256 (base16-string->bytevector "5b0ec6424bd522aeeeab30cbdcad6f40bf976a9a2ddf125ab27b97826140d97a"))))
    (list "github.com/gaukas/godicttls/@v/v0.0.4.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gaukas/godicttls/@v/v0.0.4.info")
          (file-name "go-github.com-gaukas-godicttls-_v-v0.0.4.info")
          (sha256 (base16-string->bytevector "35fc228657e8c2667192810044a0611675469e26b56e2b2a6448a758e8fd8bb7"))))
    (list "github.com/gaukas/godicttls/@v/v0.0.4.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gaukas/godicttls/@v/v0.0.4.mod")
          (file-name "go-github.com-gaukas-godicttls-_v-v0.0.4.mod")
          (sha256 (base16-string->bytevector "2e1a6312e4794bd01d49d1576c26c932dc074c5e0eed2766c6cae7a04ca8e7ef"))))
    (list "github.com/gaukas/godicttls/@v/v0.0.4.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gaukas/godicttls/@v/v0.0.4.zip")
          (file-name "go-github.com-gaukas-godicttls-_v-v0.0.4.zip")
          (sha256 (base16-string->bytevector "6c9bddf1f3fec8b9b3900151e2e7405159a7e4f0c5ba77e7dad859c2789351fe"))))
    (list "github.com/github/fakeca/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/github/fakeca/@v/v0.1.0.info")
          (file-name "go-github.com-github-fakeca-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "99b1919dbfa0f3d3507e236e949bbb71a1da87fa061ef9b5ad51d268a1e9b44b"))))
    (list "github.com/github/fakeca/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/github/fakeca/@v/v0.1.0.zip")
          (file-name "go-github.com-github-fakeca-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "cc72e6e89e80754e89bd034ca2bf5c825713e5525a7b8aee823b4ef012919796"))))
    (list "github.com/go-ole/go-ole/@v/v1.3.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/go-ole/go-ole/@v/v1.3.0.info")
          (file-name "go-github.com-go-ole-go-ole-_v-v1.3.0.info")
          (sha256 (base16-string->bytevector "f3b8797bd95fb9e6ed70e939630196aed46c3c97c14caf34ea6c51eb6391dbc9"))))
    (list "github.com/go-ole/go-ole/@v/v1.3.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/go-ole/go-ole/@v/v1.3.0.mod")
          (file-name "go-github.com-go-ole-go-ole-_v-v1.3.0.mod")
          (sha256 (base16-string->bytevector "fcf0840f2ff50fbc3b5a54b9d4cb240c64d47003ab03e420aeff0057015a8953"))))
    (list "github.com/go-ole/go-ole/@v/v1.3.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/go-ole/go-ole/@v/v1.3.0.zip")
          (file-name "go-github.com-go-ole-go-ole-_v-v1.3.0.zip")
          (sha256 (base16-string->bytevector "bbf5b3bfa227a5daa06eb16ecdecccc0b20e08749bf103afb523fd72764e727a"))))
    (list "github.com/gobwas/httphead/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/httphead/@v/v0.1.0.info")
          (file-name "go-github.com-gobwas-httphead-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "977aef4d50ffb98d7d88cf90880ab862f1a2a760d3a0b2b5ab7951dcacdb9cc3"))))
    (list "github.com/gobwas/httphead/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/httphead/@v/v0.1.0.mod")
          (file-name "go-github.com-gobwas-httphead-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "3d0248b03954819231ecd05dba139ad1b169bd654c3837b1c3d26bb0967928fa"))))
    (list "github.com/gobwas/httphead/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/httphead/@v/v0.1.0.zip")
          (file-name "go-github.com-gobwas-httphead-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "a4646f1d12786fee639c489219e7c667b10f7dc19578a4e7222bd17c5d9bdf8a"))))
    (list "github.com/gobwas/pool/@v/v0.2.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/pool/@v/v0.2.1.info")
          (file-name "go-github.com-gobwas-pool-_v-v0.2.1.info")
          (sha256 (base16-string->bytevector "0580a155022eb38e41b1b19b4887efb3d8f9fe0f634d92af668183939e2779ab"))))
    (list "github.com/gobwas/pool/@v/v0.2.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/pool/@v/v0.2.1.mod")
          (file-name "go-github.com-gobwas-pool-_v-v0.2.1.mod")
          (sha256 (base16-string->bytevector "cd3762f5b971bce0fae059e54445ccb6efc5a5a43ef65711ed407ead049c5633"))))
    (list "github.com/gobwas/pool/@v/v0.2.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/pool/@v/v0.2.1.zip")
          (file-name "go-github.com-gobwas-pool-_v-v0.2.1.zip")
          (sha256 (base16-string->bytevector "79b505a9f42b141affca1eedd2edc87ae922482d052e16e3b6e5e3c9dcec89e1"))))
    (list "github.com/gobwas/ws/@v/v1.4.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/ws/@v/v1.4.0.info")
          (file-name "go-github.com-gobwas-ws-_v-v1.4.0.info")
          (sha256 (base16-string->bytevector "b4087e662b5aa62400b1bbba47b68ef61aada09c33afd8d1d6d780d421d39c62"))))
    (list "github.com/gobwas/ws/@v/v1.4.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/ws/@v/v1.4.0.mod")
          (file-name "go-github.com-gobwas-ws-_v-v1.4.0.mod")
          (sha256 (base16-string->bytevector "899c19b5606de79e3a347e5d1e1f7223960fedae32837612ccceb6c5e58256b2"))))
    (list "github.com/gobwas/ws/@v/v1.4.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gobwas/ws/@v/v1.4.0.zip")
          (file-name "go-github.com-gobwas-ws-_v-v1.4.0.zip")
          (sha256 (base16-string->bytevector "4c8a4b60d07be4c3a95d1840ff249f590503eebf2184f6c869f3a102a7ad4d0a"))))
    (list "github.com/gofrs/uuid/v5/@v/v5.4.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gofrs/uuid/v5/@v/v5.4.0.info")
          (file-name "go-github.com-gofrs-uuid-v5-_v-v5.4.0.info")
          (sha256 (base16-string->bytevector "bd4100620c697c3c8baa1699e11f6fa9f9002e9ae3fad7b870bd29799497ca80"))))
    (list "github.com/gofrs/uuid/v5/@v/v5.4.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gofrs/uuid/v5/@v/v5.4.0.mod")
          (file-name "go-github.com-gofrs-uuid-v5-_v-v5.4.0.mod")
          (sha256 (base16-string->bytevector "2d8f6b63fc9cf37e2aed0a23527e7079a4b1441639177fa7e149afd3f6a73478"))))
    (list "github.com/gofrs/uuid/v5/@v/v5.4.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/gofrs/uuid/v5/@v/v5.4.0.zip")
          (file-name "go-github.com-gofrs-uuid-v5-_v-v5.4.0.zip")
          (sha256 (base16-string->bytevector "3ee3a75fdc02cfdcbf1a44feb0f89ea89aad0cfa38b7730f95e67afb42e06f6c"))))
    (list "github.com/golang/groupcache/@v/v0.0.0-20241129210726-2c02b8208cf8.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/groupcache/@v/v0.0.0-20241129210726-2c02b8208cf8.info")
          (file-name "go-github.com-golang-groupcache-_v-v0.0.0-20241129210726-2c02b8208cf8.info")
          (sha256 (base16-string->bytevector "14cdbd417180018a567d37599705f1c2503c175e7b74cfceec7639ee6248b13e"))))
    (list "github.com/golang/groupcache/@v/v0.0.0-20241129210726-2c02b8208cf8.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/groupcache/@v/v0.0.0-20241129210726-2c02b8208cf8.mod")
          (file-name "go-github.com-golang-groupcache-_v-v0.0.0-20241129210726-2c02b8208cf8.mod")
          (sha256 (base16-string->bytevector "4e019acbe58a7af43d2316b6f825797636072cb48c31ea6ff7aae7d75ad51a89"))))
    (list "github.com/golang/groupcache/@v/v0.0.0-20241129210726-2c02b8208cf8.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/groupcache/@v/v0.0.0-20241129210726-2c02b8208cf8.zip")
          (file-name "go-github.com-golang-groupcache-_v-v0.0.0-20241129210726-2c02b8208cf8.zip")
          (sha256 (base16-string->bytevector "163367355442a630b12b0b452892cd98e99fcfdf7e40b68d358be73479cc1c23"))))
    (list "github.com/golang/protobuf/@v/v1.3.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/protobuf/@v/v1.3.1.mod")
          (file-name "go-github.com-golang-protobuf-_v-v1.3.1.mod")
          (sha256 (base16-string->bytevector "c0a2031bf277087749d8ccc432449f6b1375787eac8641dd2f930074231aafb4"))))
    (list "github.com/golang/snappy/@v/v1.0.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/snappy/@v/v1.0.0.info")
          (file-name "go-github.com-golang-snappy-_v-v1.0.0.info")
          (sha256 (base16-string->bytevector "0d454869876b412ab1f061816b7b061226f7c93231b4e0810ae8e0f2bd6839c5"))))
    (list "github.com/golang/snappy/@v/v1.0.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/snappy/@v/v1.0.0.mod")
          (file-name "go-github.com-golang-snappy-_v-v1.0.0.mod")
          (sha256 (base16-string->bytevector "f56debc9765b8492979fefa31209b67c9627d90e2469c6159c940daf6d249905"))))
    (list "github.com/golang/snappy/@v/v1.0.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/golang/snappy/@v/v1.0.0.zip")
          (file-name "go-github.com-golang-snappy-_v-v1.0.0.zip")
          (sha256 (base16-string->bytevector "d712fef567e361d17e879f80ea53ebfdf529185a6bc74a2aa1996133ddd0a930"))))
    (list "github.com/google/btree/@v/v1.1.3.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/btree/@v/v1.1.3.info")
          (file-name "go-github.com-google-btree-_v-v1.1.3.info")
          (sha256 (base16-string->bytevector "c4706d9dd1f2b284f94c4a6ad1a1ff2f50a5a78f3765948e6d1477e3375fccec"))))
    (list "github.com/google/btree/@v/v1.1.3.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/btree/@v/v1.1.3.mod")
          (file-name "go-github.com-google-btree-_v-v1.1.3.mod")
          (sha256 (base16-string->bytevector "671a2227c5628cbb94ce027ab4232858c4f0dd0cbb98aaa83d7a265d7ec194d7"))))
    (list "github.com/google/btree/@v/v1.1.3.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/btree/@v/v1.1.3.zip")
          (file-name "go-github.com-google-btree-_v-v1.1.3.zip")
          (sha256 (base16-string->bytevector "11b736bc8252b52fecdf346d3707ccf3a2b6d458ba21b4f843616fc12eeb30b2"))))
    (list "github.com/google/go-cmp/@v/v0.6.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/go-cmp/@v/v0.6.0.info")
          (file-name "go-github.com-google-go-cmp-_v-v0.6.0.info")
          (sha256 (base16-string->bytevector "e624a2c1fe53ae5c8cdce4707290e8282c2c89f3143951670eb175957aa9cfa9"))))
    (list "github.com/google/go-cmp/@v/v0.6.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/go-cmp/@v/v0.6.0.mod")
          (file-name "go-github.com-google-go-cmp-_v-v0.6.0.mod")
          (sha256 (base16-string->bytevector "e7c7669d4a1dd589ba3e024ba27f43f293db611fe075ce20d7b884370d63febd"))))
    (list "github.com/google/go-cmp/@v/v0.6.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/go-cmp/@v/v0.6.0.zip")
          (file-name "go-github.com-google-go-cmp-_v-v0.6.0.zip")
          (sha256 (base16-string->bytevector "4b4e9bf6c48211080651b491dfb48d68b736c66a305bcf94605606e1ba2eaa4a"))))
    (list "github.com/google/pprof/@v/v0.0.0-20240727154555-813a5fbdbec8.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/pprof/@v/v0.0.0-20240727154555-813a5fbdbec8.info")
          (file-name "go-github.com-google-pprof-_v-v0.0.0-20240727154555-813a5fbdbec8.info")
          (sha256 (base16-string->bytevector "b4b55d18efd64d39ca27cc4d3759140490e6bae9bd01a6f01de439ed436c7346"))))
    (list "github.com/google/pprof/@v/v0.0.0-20240727154555-813a5fbdbec8.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/pprof/@v/v0.0.0-20240727154555-813a5fbdbec8.mod")
          (file-name "go-github.com-google-pprof-_v-v0.0.0-20240727154555-813a5fbdbec8.mod")
          (sha256 (base16-string->bytevector "efd05edc5b6891f3f29bc1b85618b48731d2bf1dc6bf20b510a4ef5b7a2fc765"))))
    (list "github.com/google/pprof/@v/v0.0.0-20240727154555-813a5fbdbec8.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/pprof/@v/v0.0.0-20240727154555-813a5fbdbec8.zip")
          (file-name "go-github.com-google-pprof-_v-v0.0.0-20240727154555-813a5fbdbec8.zip")
          (sha256 (base16-string->bytevector "22d5ff7b4582b1269199573f80cfc2c1ad251ed7dab03d0ee73b9af166172a52"))))
    (list "github.com/google/tink/go/@v/v1.6.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/tink/go/@v/v1.6.1.info")
          (file-name "go-github.com-google-tink-go-_v-v1.6.1.info")
          (sha256 (base16-string->bytevector "da0c68531a4b7ad75ec3fb50139a07aa7192876732b059515ff182322e759d2d"))))
    (list "github.com/google/tink/go/@v/v1.6.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/google/tink/go/@v/v1.6.1.zip")
          (file-name "go-github.com-google-tink-go-_v-v1.6.1.zip")
          (sha256 (base16-string->bytevector "2acc13f849ff59756f87b620d341427c709ee7d7e5bd79db1885f270c40986b4"))))
    (list "github.com/hashicorp/golang-lru/v2/@v/v2.0.7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/hashicorp/golang-lru/v2/@v/v2.0.7.info")
          (file-name "go-github.com-hashicorp-golang-lru-v2-_v-v2.0.7.info")
          (sha256 (base16-string->bytevector "bc6b4c0c41236c8aaa9ca6473c27e60d1c9c7091e3280e022a01524f3e5a50e0"))))
    (list "github.com/hashicorp/golang-lru/v2/@v/v2.0.7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/hashicorp/golang-lru/v2/@v/v2.0.7.mod")
          (file-name "go-github.com-hashicorp-golang-lru-v2-_v-v2.0.7.mod")
          (sha256 (base16-string->bytevector "c6b886c0242ffeac92b6b6aecf1123bc63c86faee81b16fff3a13273e50f6824"))))
    (list "github.com/hashicorp/golang-lru/v2/@v/v2.0.7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/hashicorp/golang-lru/v2/@v/v2.0.7.zip")
          (file-name "go-github.com-hashicorp-golang-lru-v2-_v-v2.0.7.zip")
          (sha256 (base16-string->bytevector "2eb92ff13970bccd460efae14255bfc03bb51474da0137e477a60f95561acc30"))))
    (list "github.com/insomniacslk/dhcp/@v/v0.0.0-20250109001534-8abf58130905.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/insomniacslk/dhcp/@v/v0.0.0-20250109001534-8abf58130905.info")
          (file-name "go-github.com-insomniacslk-dhcp-_v-v0.0.0-20250109001534-8abf58130905.info")
          (sha256 (base16-string->bytevector "c8ce575cbc992b7c1c4c466d8ec4159d4d020cb9c90d3add8bc577884757faa5"))))
    (list "github.com/insomniacslk/dhcp/@v/v0.0.0-20250109001534-8abf58130905.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/insomniacslk/dhcp/@v/v0.0.0-20250109001534-8abf58130905.mod")
          (file-name "go-github.com-insomniacslk-dhcp-_v-v0.0.0-20250109001534-8abf58130905.mod")
          (sha256 (base16-string->bytevector "3c71433115de459f02d12e50655b324e87acb8bf51034a3f42736bc861e18c84"))))
    (list "github.com/insomniacslk/dhcp/@v/v0.0.0-20250109001534-8abf58130905.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/insomniacslk/dhcp/@v/v0.0.0-20250109001534-8abf58130905.zip")
          (file-name "go-github.com-insomniacslk-dhcp-_v-v0.0.0-20250109001534-8abf58130905.zip")
          (sha256 (base16-string->bytevector "1ab9ca57cc0ab35e6799fcabbcf21fd538129e607444383e66ad3e0b90a6581b"))))
    (list "github.com/josharian/native/@v/v1.0.1-0.20221213033349-c1e37c09b531.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/josharian/native/@v/v1.0.1-0.20221213033349-c1e37c09b531.mod")
          (file-name "go-github.com-josharian-native-_v-v1.0.1-0.20221213033349-c1e37c09b531.mod")
          (sha256 (base16-string->bytevector "ddb36d9a8d9ea5fdf537ad11fe24abcec81131ae3eb2cbe1bc541aada0f61ac9"))))
    (list "github.com/josharian/native/@v/v1.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/josharian/native/@v/v1.1.0.info")
          (file-name "go-github.com-josharian-native-_v-v1.1.0.info")
          (sha256 (base16-string->bytevector "c444b16f56a4a6c60da5b079c2d755484bd7ec96df45e831e298dc55a859f3ea"))))
    (list "github.com/josharian/native/@v/v1.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/josharian/native/@v/v1.1.0.mod")
          (file-name "go-github.com-josharian-native-_v-v1.1.0.mod")
          (sha256 (base16-string->bytevector "ddb36d9a8d9ea5fdf537ad11fe24abcec81131ae3eb2cbe1bc541aada0f61ac9"))))
    (list "github.com/josharian/native/@v/v1.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/josharian/native/@v/v1.1.0.zip")
          (file-name "go-github.com-josharian-native-_v-v1.1.0.zip")
          (sha256 (base16-string->bytevector "6bf490b63ce1b724d1ab0aceb7655648b25b0ae6dc16f7fb1d89127836e71c42"))))
    (list "github.com/jsimonetti/rtnetlink/@v/v1.4.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/jsimonetti/rtnetlink/@v/v1.4.0.info")
          (file-name "go-github.com-jsimonetti-rtnetlink-_v-v1.4.0.info")
          (sha256 (base16-string->bytevector "5aba69f10965aba8c432080843c15c0929127aa701a39deb5fbaeb5505c2460c"))))
    (list "github.com/jsimonetti/rtnetlink/@v/v1.4.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/jsimonetti/rtnetlink/@v/v1.4.0.mod")
          (file-name "go-github.com-jsimonetti-rtnetlink-_v-v1.4.0.mod")
          (sha256 (base16-string->bytevector "45f3bdab328f4ef5f45318f970de6697b17e7e21133f1b3f9ed93034d89544a7"))))
    (list "github.com/jsimonetti/rtnetlink/@v/v1.4.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/jsimonetti/rtnetlink/@v/v1.4.0.zip")
          (file-name "go-github.com-jsimonetti-rtnetlink-_v-v1.4.0.zip")
          (sha256 (base16-string->bytevector "81625291f4d0a08718dfd2170873d1adfd8fc2248657584f520c4de6de9e2e4d"))))
    (list "github.com/klauspost/compress/@v/v1.17.9.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/compress/@v/v1.17.9.info")
          (file-name "go-github.com-klauspost-compress-_v-v1.17.9.info")
          (sha256 (base16-string->bytevector "e527d526a7a4b6994d923afa804ec3f54a3c5904d18ad5cb6f30138d7bfe1596"))))
    (list "github.com/klauspost/compress/@v/v1.17.9.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/compress/@v/v1.17.9.mod")
          (file-name "go-github.com-klauspost-compress-_v-v1.17.9.mod")
          (sha256 (base16-string->bytevector "9ba4064d644e891902ed220e2c0135fd79685f23c6fb0c9b2368fc9173f81f40"))))
    (list "github.com/klauspost/compress/@v/v1.17.9.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/compress/@v/v1.17.9.zip")
          (file-name "go-github.com-klauspost-compress-_v-v1.17.9.zip")
          (sha256 (base16-string->bytevector "a009d53eecbdb9d6b789e9a0662fa41c87a85ab280291b2b5a5d9664bb1c5e8f"))))
    (list "github.com/klauspost/cpuid/v2/@v/v2.2.6.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/cpuid/v2/@v/v2.2.6.info")
          (file-name "go-github.com-klauspost-cpuid-v2-_v-v2.2.6.info")
          (sha256 (base16-string->bytevector "1bdbbf4c17d33af78f5680649718eb7dc9bac935c6f560b606279532f25c2fb7"))))
    (list "github.com/klauspost/cpuid/v2/@v/v2.2.6.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/cpuid/v2/@v/v2.2.6.mod")
          (file-name "go-github.com-klauspost-cpuid-v2-_v-v2.2.6.mod")
          (sha256 (base16-string->bytevector "7c804f82322ccf9927e850e8f7ba8e32f558f35b746d8023133ad8771faa8877"))))
    (list "github.com/klauspost/cpuid/v2/@v/v2.2.6.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/cpuid/v2/@v/v2.2.6.zip")
          (file-name "go-github.com-klauspost-cpuid-v2-_v-v2.2.6.zip")
          (sha256 (base16-string->bytevector "c59cbc93b0f34418e4cfc1f3a9e0d10e649bfc5bc3080be5bd60619625de13c0"))))
    (list "github.com/klauspost/reedsolomon/@v/v1.12.3.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/reedsolomon/@v/v1.12.3.info")
          (file-name "go-github.com-klauspost-reedsolomon-_v-v1.12.3.info")
          (sha256 (base16-string->bytevector "7effa9e65fa965d223f57153a89756da2371d17a5b9b14da161afec654e8552d"))))
    (list "github.com/klauspost/reedsolomon/@v/v1.12.3.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/reedsolomon/@v/v1.12.3.mod")
          (file-name "go-github.com-klauspost-reedsolomon-_v-v1.12.3.mod")
          (sha256 (base16-string->bytevector "abae2e377891e047ba86eb893232651619ae5647c50ced16a0e0a5ed522a4d9b"))))
    (list "github.com/klauspost/reedsolomon/@v/v1.12.3.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/klauspost/reedsolomon/@v/v1.12.3.zip")
          (file-name "go-github.com-klauspost-reedsolomon-_v-v1.12.3.zip")
          (sha256 (base16-string->bytevector "2a94863ba24eb19dd0d8736d9408a9b12d4e2e5f19f48ffc7d04e1b7ad954ee2"))))
    (list "github.com/kr/pretty/@v/v0.3.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/kr/pretty/@v/v0.3.1.info")
          (file-name "go-github.com-kr-pretty-_v-v0.3.1.info")
          (sha256 (base16-string->bytevector "8985c5adc09968b25ac3bc455e4dcd6fd9697f3bd4472b2b4d7a6d478ab39583"))))
    (list "github.com/kr/pretty/@v/v0.3.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/kr/pretty/@v/v0.3.1.zip")
          (file-name "go-github.com-kr-pretty-_v-v0.3.1.zip")
          (sha256 (base16-string->bytevector "ecf5a4af24826c3ad758ce06410ca08e2d58e4d95053be3b9dde2e14852c0cdc"))))
    (list "github.com/kr/text/@v/v0.2.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/kr/text/@v/v0.2.0.info")
          (file-name "go-github.com-kr-text-_v-v0.2.0.info")
          (sha256 (base16-string->bytevector "08b7c0e616c83fc4f9a82cbb4fb22fc14e198ce67c28704a7ce297fbe89fab99"))))
    (list "github.com/kr/text/@v/v0.2.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/kr/text/@v/v0.2.0.zip")
          (file-name "go-github.com-kr-text-_v-v0.2.0.zip")
          (sha256 (base16-string->bytevector "368eb318f91a5b67be905c47032ab5c31a1d49a97848b1011a0d0a2122b30ba4"))))
    (list "github.com/mdlayher/netlink/@v/v1.7.2.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mdlayher/netlink/@v/v1.7.2.info")
          (file-name "go-github.com-mdlayher-netlink-_v-v1.7.2.info")
          (sha256 (base16-string->bytevector "f176434c78e739b0a62b17ff77d062d55e05314a64a9a01b163c61591fe938f4"))))
    (list "github.com/mdlayher/netlink/@v/v1.7.2.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mdlayher/netlink/@v/v1.7.2.mod")
          (file-name "go-github.com-mdlayher-netlink-_v-v1.7.2.mod")
          (sha256 (base16-string->bytevector "6aa6895f3d360fe30fc99b440d566c2604e83aa4c92894327ec91e07839f0e1d"))))
    (list "github.com/mdlayher/netlink/@v/v1.7.2.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mdlayher/netlink/@v/v1.7.2.zip")
          (file-name "go-github.com-mdlayher-netlink-_v-v1.7.2.zip")
          (sha256 (base16-string->bytevector "a21ccaea2a6fb7b946a96c61efc2fff33d717931c20c5bb3a2ec2ce528072dc0"))))
    (list "github.com/mdlayher/socket/@v/v0.5.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mdlayher/socket/@v/v0.5.1.info")
          (file-name "go-github.com-mdlayher-socket-_v-v0.5.1.info")
          (sha256 (base16-string->bytevector "d0e4aedbc1ecb7e3364d7c1e867f642179fb2a30403e450dfdf241f5186cbab1"))))
    (list "github.com/mdlayher/socket/@v/v0.5.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mdlayher/socket/@v/v0.5.1.mod")
          (file-name "go-github.com-mdlayher-socket-_v-v0.5.1.mod")
          (sha256 (base16-string->bytevector "51300f530fe1a249722497df38258c232a53b14d20b97dfe22e93440cb70f4a9"))))
    (list "github.com/mdlayher/socket/@v/v0.5.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mdlayher/socket/@v/v0.5.1.zip")
          (file-name "go-github.com-mdlayher-socket-_v-v0.5.1.zip")
          (sha256 (base16-string->bytevector "f0f07bdd9811f8571c7864cf5e0f06d85cfb3edbb254d6094a31e7f1d427e2a2"))))
    (list "github.com/metacubex/age/@v/v0.0.0-20260603010618-28d156b4ea78.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/age/@v/v0.0.0-20260603010618-28d156b4ea78.info")
          (file-name "go-github.com-metacubex-age-_v-v0.0.0-20260603010618-28d156b4ea78.info")
          (sha256 (base16-string->bytevector "868d10ee5ffbaa14c9ceb2f50ef5c69f13663e28752fd0c80c8d61c6e654b8e1"))))
    (list "github.com/metacubex/age/@v/v0.0.0-20260603010618-28d156b4ea78.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/age/@v/v0.0.0-20260603010618-28d156b4ea78.mod")
          (file-name "go-github.com-metacubex-age-_v-v0.0.0-20260603010618-28d156b4ea78.mod")
          (sha256 (base16-string->bytevector "7d94c77acdd4529b73efe6a92366963e954a2a5e0be6b50f972aa6bc42b92678"))))
    (list "github.com/metacubex/age/@v/v0.0.0-20260603010618-28d156b4ea78.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/age/@v/v0.0.0-20260603010618-28d156b4ea78.zip")
          (file-name "go-github.com-metacubex-age-_v-v0.0.0-20260603010618-28d156b4ea78.zip")
          (sha256 (base16-string->bytevector "f0082f5bb5e49494ffcb9f137676f14ceade3d7cdf7c20ffcc52b9ed99be1589"))))
    (list "github.com/metacubex/amneziawg-go/@v/v0.0.0-20260816073447-736a78668832.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/amneziawg-go/@v/v0.0.0-20260816073447-736a78668832.info")
          (file-name "go-github.com-metacubex-amneziawg-go-_v-v0.0.0-20260816073447-736a78668832.info")
          (sha256 (base16-string->bytevector "d9d0fb465a893864b27761eef01bad26168a56f068e3f407888b631ef6ea939d"))))
    (list "github.com/metacubex/amneziawg-go/@v/v0.0.0-20260816073447-736a78668832.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/amneziawg-go/@v/v0.0.0-20260816073447-736a78668832.mod")
          (file-name "go-github.com-metacubex-amneziawg-go-_v-v0.0.0-20260816073447-736a78668832.mod")
          (sha256 (base16-string->bytevector "23f73549d5ac6376fff5bf60c76a2824594e3864e60a3a4ae281295b7f0cbc01"))))
    (list "github.com/metacubex/amneziawg-go/@v/v0.0.0-20260816073447-736a78668832.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/amneziawg-go/@v/v0.0.0-20260816073447-736a78668832.zip")
          (file-name "go-github.com-metacubex-amneziawg-go-_v-v0.0.0-20260816073447-736a78668832.zip")
          (sha256 (base16-string->bytevector "f5dfb679d94f9c928f2d55414f7a949643911a22340c1e93533ba484eb1306fa"))))
    (list "github.com/metacubex/ascon/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/ascon/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-ascon-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "0921ad1f3e4aa52acff47bb83d5aaa33515b1a99661a71269bf3f590ab41beed"))))
    (list "github.com/metacubex/ascon/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/ascon/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-ascon-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "5fee3385a9ad5d5a873c54e585b375a652396e96f84eb75d74f6935b7ec21e7d"))))
    (list "github.com/metacubex/ascon/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/ascon/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-ascon-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "2be4d6203a4264933422c98cf8d615633f2b34dbac5f287babdcf6e9463e30cd"))))
    (list "github.com/metacubex/bart/@v/v0.29.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/bart/@v/v0.29.0.info")
          (file-name "go-github.com-metacubex-bart-_v-v0.29.0.info")
          (sha256 (base16-string->bytevector "025b55c4837dbbb66ba45832bfa408e350bc3930130f9c6832ea2e52d6b4b09b"))))
    (list "github.com/metacubex/bart/@v/v0.29.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/bart/@v/v0.29.0.mod")
          (file-name "go-github.com-metacubex-bart-_v-v0.29.0.mod")
          (sha256 (base16-string->bytevector "9052fd6d9b880f4e9adab5b55f10fe8f3d1e7db2c7520d5d4247e560acee3583"))))
    (list "github.com/metacubex/bart/@v/v0.29.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/bart/@v/v0.29.0.zip")
          (file-name "go-github.com-metacubex-bart-_v-v0.29.0.zip")
          (sha256 (base16-string->bytevector "3ec696432421003a6e5addcb1e9e3b7d388ab30fc58201b1d6bb857669bf7267"))))
    (list "github.com/metacubex/bbolt/@v/v0.0.0-20260706163408-d4ec34ad7c48.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/bbolt/@v/v0.0.0-20260706163408-d4ec34ad7c48.info")
          (file-name "go-github.com-metacubex-bbolt-_v-v0.0.0-20260706163408-d4ec34ad7c48.info")
          (sha256 (base16-string->bytevector "e2763b000ff4e08c7ba9930b6bed0d60bdc59123f7fe6412a5c58cf0106dc41c"))))
    (list "github.com/metacubex/bbolt/@v/v0.0.0-20260706163408-d4ec34ad7c48.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/bbolt/@v/v0.0.0-20260706163408-d4ec34ad7c48.mod")
          (file-name "go-github.com-metacubex-bbolt-_v-v0.0.0-20260706163408-d4ec34ad7c48.mod")
          (sha256 (base16-string->bytevector "328ccd7224d1eaac56da261f4d76c5bd43d7141c38e083cfbbbffe28bef2044a"))))
    (list "github.com/metacubex/bbolt/@v/v0.0.0-20260706163408-d4ec34ad7c48.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/bbolt/@v/v0.0.0-20260706163408-d4ec34ad7c48.zip")
          (file-name "go-github.com-metacubex-bbolt-_v-v0.0.0-20260706163408-d4ec34ad7c48.zip")
          (sha256 (base16-string->bytevector "1e2e0e847c40bd6a5e00355ac3b200051a8e4b23431f04ad5b3d034fed1cb37d"))))
    (list "github.com/metacubex/blake3/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/blake3/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-blake3-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "b0285e8d32f99dd4dbd4c3b5af6af20c7d8737f5641008742aef0777c566ae80"))))
    (list "github.com/metacubex/blake3/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/blake3/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-blake3-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "50167f3be5430b93948f62ab113b77139f3cf8a50a33ded51b670d4863147528"))))
    (list "github.com/metacubex/blake3/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/blake3/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-blake3-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "c40b750bb9cd949918741862af72696ffb686b85da77bc3fb05dddd5e9b98511"))))
    (list "github.com/metacubex/chacha/@v/v0.1.5.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/chacha/@v/v0.1.5.info")
          (file-name "go-github.com-metacubex-chacha-_v-v0.1.5.info")
          (sha256 (base16-string->bytevector "2e1d0fd00c3f4469fc3daf2aeaa9a18e903bba8ffdd27537c38fa695dd3859ae"))))
    (list "github.com/metacubex/chacha/@v/v0.1.5.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/chacha/@v/v0.1.5.mod")
          (file-name "go-github.com-metacubex-chacha-_v-v0.1.5.mod")
          (sha256 (base16-string->bytevector "d261e0f0cfd306a2b476b6fa1075b80433b2fc2d99ce9781cfff7671119dc55e"))))
    (list "github.com/metacubex/chacha/@v/v0.1.5.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/chacha/@v/v0.1.5.zip")
          (file-name "go-github.com-metacubex-chacha-_v-v0.1.5.zip")
          (sha256 (base16-string->bytevector "558efe2b5c53497277ab7d91b3ab834b7e07fede44078d9b27e4474dd5c88097"))))
    (list "github.com/metacubex/chi/@v/v0.1.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/chi/@v/v0.1.1.info")
          (file-name "go-github.com-metacubex-chi-_v-v0.1.1.info")
          (sha256 (base16-string->bytevector "0871a004088db7f9b181d70b445de382270f10f5f79a16d470a4b9a46217aa19"))))
    (list "github.com/metacubex/chi/@v/v0.1.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/chi/@v/v0.1.1.mod")
          (file-name "go-github.com-metacubex-chi-_v-v0.1.1.mod")
          (sha256 (base16-string->bytevector "6f4ff4106f99c0be9cfa1c675982583c9a68ca6b6acac3e805f81cca488638e9"))))
    (list "github.com/metacubex/chi/@v/v0.1.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/chi/@v/v0.1.1.zip")
          (file-name "go-github.com-metacubex-chi-_v-v0.1.1.zip")
          (sha256 (base16-string->bytevector "d85066fc6e0c6623e141692b1b2e2e30fc7f74e18b4360d084f50171dd45fccd"))))
    (list "github.com/metacubex/connect-ip-go/@v/v0.0.0-20260727083417-67ccdb0cf771.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/connect-ip-go/@v/v0.0.0-20260727083417-67ccdb0cf771.info")
          (file-name "go-github.com-metacubex-connect-ip-go-_v-v0.0.0-20260727083417-67ccdb0cf771.info")
          (sha256 (base16-string->bytevector "624b5f889a2e44058113f96f70cdd949650474599981f4a04aac4e22d7a9d7fc"))))
    (list "github.com/metacubex/connect-ip-go/@v/v0.0.0-20260727083417-67ccdb0cf771.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/connect-ip-go/@v/v0.0.0-20260727083417-67ccdb0cf771.mod")
          (file-name "go-github.com-metacubex-connect-ip-go-_v-v0.0.0-20260727083417-67ccdb0cf771.mod")
          (sha256 (base16-string->bytevector "00d1f0e548239a19792bc724219c0e345761d29ee9906eaef43858d0f5939ac5"))))
    (list "github.com/metacubex/connect-ip-go/@v/v0.0.0-20260727083417-67ccdb0cf771.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/connect-ip-go/@v/v0.0.0-20260727083417-67ccdb0cf771.zip")
          (file-name "go-github.com-metacubex-connect-ip-go-_v-v0.0.0-20260727083417-67ccdb0cf771.zip")
          (sha256 (base16-string->bytevector "335d55a7fb7d0c83c0656cee88803357f9f8b12ec2377418e389945d4e9da8af"))))
    (list "github.com/metacubex/cpu/@v/v0.1.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/cpu/@v/v0.1.1.info")
          (file-name "go-github.com-metacubex-cpu-_v-v0.1.1.info")
          (sha256 (base16-string->bytevector "c18be615ea88f2b808ba15dc46734dc54391de89499d21e2b76af8e3b8e9f7fd"))))
    (list "github.com/metacubex/cpu/@v/v0.1.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/cpu/@v/v0.1.1.mod")
          (file-name "go-github.com-metacubex-cpu-_v-v0.1.1.mod")
          (sha256 (base16-string->bytevector "88b1296d6c3d9b69e31fd16120b2fc6d07ce0469e5cc8d538c556658a89691bf"))))
    (list "github.com/metacubex/cpu/@v/v0.1.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/cpu/@v/v0.1.1.zip")
          (file-name "go-github.com-metacubex-cpu-_v-v0.1.1.zip")
          (sha256 (base16-string->bytevector "8b374f6e99240298cd04f3e0101ae89e87ffbc111706d245effd50629663ccd9"))))
    (list "github.com/metacubex/edwards25519/@v/v1.2.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/edwards25519/@v/v1.2.0.info")
          (file-name "go-github.com-metacubex-edwards25519-_v-v1.2.0.info")
          (sha256 (base16-string->bytevector "4127c4e0caa15e8b7ae3a75442366a5ab1274ff585249f6dea7973ce1a7d0d1b"))))
    (list "github.com/metacubex/edwards25519/@v/v1.2.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/edwards25519/@v/v1.2.0.mod")
          (file-name "go-github.com-metacubex-edwards25519-_v-v1.2.0.mod")
          (sha256 (base16-string->bytevector "5479fd11782da889df2791022d29751398cc4311c6f3835db6eda89fc412449b"))))
    (list "github.com/metacubex/edwards25519/@v/v1.2.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/edwards25519/@v/v1.2.0.zip")
          (file-name "go-github.com-metacubex-edwards25519-_v-v1.2.0.zip")
          (sha256 (base16-string->bytevector "742768d4b0fe0e96c463a0970db7972ebc75b8f30b84c670df258d5242f160c4"))))
    (list "github.com/metacubex/fswatch/@v/v0.1.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/fswatch/@v/v0.1.1.info")
          (file-name "go-github.com-metacubex-fswatch-_v-v0.1.1.info")
          (sha256 (base16-string->bytevector "d3a23a2224a4900e29c70120b3d51ddfa8e4ae7e606ac44e3e73ff1035c56db2"))))
    (list "github.com/metacubex/fswatch/@v/v0.1.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/fswatch/@v/v0.1.1.mod")
          (file-name "go-github.com-metacubex-fswatch-_v-v0.1.1.mod")
          (sha256 (base16-string->bytevector "de8fd8332e1786134d86725e178cf113cf30f5f4e32dc49ac51a470af9ee9248"))))
    (list "github.com/metacubex/fswatch/@v/v0.1.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/fswatch/@v/v0.1.1.zip")
          (file-name "go-github.com-metacubex-fswatch-_v-v0.1.1.zip")
          (sha256 (base16-string->bytevector "8b8eec4a17abfa1141e9c9901392ea5df8219c9c26deb4442a250f7f9931fbbb"))))
    (list "github.com/metacubex/gopacket/@v/v1.1.20-0.20230608035415-7e2f98a3e759.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/gopacket/@v/v1.1.20-0.20230608035415-7e2f98a3e759.info")
          (file-name "go-github.com-metacubex-gopacket-_v-v1.1.20-0.20230608035415-7e2f98a3e759.info")
          (sha256 (base16-string->bytevector "f08b1835849b260e7e8c0addb57bae65ff099515db41697cb10b1120aa5f598f"))))
    (list "github.com/metacubex/gopacket/@v/v1.1.20-0.20230608035415-7e2f98a3e759.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/gopacket/@v/v1.1.20-0.20230608035415-7e2f98a3e759.mod")
          (file-name "go-github.com-metacubex-gopacket-_v-v1.1.20-0.20230608035415-7e2f98a3e759.mod")
          (sha256 (base16-string->bytevector "f074bd0ad211dac3eed3222e09f7b4d0f12d75307b2cc840e4ccc62e87f6e114"))))
    (list "github.com/metacubex/gopacket/@v/v1.1.20-0.20230608035415-7e2f98a3e759.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/gopacket/@v/v1.1.20-0.20230608035415-7e2f98a3e759.zip")
          (file-name "go-github.com-metacubex-gopacket-_v-v1.1.20-0.20230608035415-7e2f98a3e759.zip")
          (sha256 (base16-string->bytevector "566173e7a44816e8e20fd38dc81ce4a002ee536379264504c971939b88850496"))))
    (list "github.com/metacubex/gvisor/@v/v0.0.0-20260810011720-3cc44cf9ac22.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/gvisor/@v/v0.0.0-20260810011720-3cc44cf9ac22.info")
          (file-name "go-github.com-metacubex-gvisor-_v-v0.0.0-20260810011720-3cc44cf9ac22.info")
          (sha256 (base16-string->bytevector "ee86d3b15b617657bc5ac08dded5db4c3169bfb0d469b36ac8ad6a62fc404d29"))))
    (list "github.com/metacubex/gvisor/@v/v0.0.0-20260810011720-3cc44cf9ac22.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/gvisor/@v/v0.0.0-20260810011720-3cc44cf9ac22.mod")
          (file-name "go-github.com-metacubex-gvisor-_v-v0.0.0-20260810011720-3cc44cf9ac22.mod")
          (sha256 (base16-string->bytevector "a946dec28c9ce1980ebd50c6832579dc363291353cfff7b6828ae45e240c0073"))))
    (list "github.com/metacubex/gvisor/@v/v0.0.0-20260810011720-3cc44cf9ac22.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/gvisor/@v/v0.0.0-20260810011720-3cc44cf9ac22.zip")
          (file-name "go-github.com-metacubex-gvisor-_v-v0.0.0-20260810011720-3cc44cf9ac22.zip")
          (sha256 (base16-string->bytevector "8cf60863034aa06f58c523ea5dc4dfcd8647f19a00b83c9691a0ac875d7e5838"))))
    (list "github.com/metacubex/hkdf/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/hkdf/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-hkdf-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "f704d8c073016a64c8d304b74b09cc4c1258a79b312e60d8278a133c5b70108f"))))
    (list "github.com/metacubex/hkdf/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/hkdf/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-hkdf-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "4f2ce5b4b85fbf4d77b70e188350b76358c563b0164672268bbe13c7b1c72ec0"))))
    (list "github.com/metacubex/hkdf/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/hkdf/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-hkdf-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "1e74e68565c112b698aa3329ee531319f843ef6e7607109f8f480291a97d9626"))))
    (list "github.com/metacubex/hpke/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/hpke/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-hpke-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "daa610d6090404c918f247c4281e06338b0935160f495f7a54d853c75f8306bb"))))
    (list "github.com/metacubex/hpke/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/hpke/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-hpke-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "95114eb122fbbe8267bc46ed0597d959c6298aa8102354c777da5fd4f2f89990"))))
    (list "github.com/metacubex/hpke/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/hpke/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-hpke-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "f1d6040487779dce209492c985b7ecb0f208924395e5d30c611f5aff3c82548f"))))
    (list "github.com/metacubex/http/@v/v0.1.7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/http/@v/v0.1.7.info")
          (file-name "go-github.com-metacubex-http-_v-v0.1.7.info")
          (sha256 (base16-string->bytevector "932481824022aeb1973f8603d1b7ed153fb0fca8978b133d851d1b1030e24865"))))
    (list "github.com/metacubex/http/@v/v0.1.7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/http/@v/v0.1.7.mod")
          (file-name "go-github.com-metacubex-http-_v-v0.1.7.mod")
          (sha256 (base16-string->bytevector "e6aab717c63a7a9b1618cd4efe14bd1b055e763728d1cf46ff46536c6854b2f4"))))
    (list "github.com/metacubex/http/@v/v0.1.7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/http/@v/v0.1.7.zip")
          (file-name "go-github.com-metacubex-http-_v-v0.1.7.zip")
          (sha256 (base16-string->bytevector "0b0f5f0cf3ac02373eb5e8de340c7c907bd654407185d22a458dba4919d9dd2e"))))
    (list "github.com/metacubex/jls-quic-go/@v/v0.0.0-20260727080412-732f2fc9a34d.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jls-quic-go/@v/v0.0.0-20260727080412-732f2fc9a34d.info")
          (file-name "go-github.com-metacubex-jls-quic-go-_v-v0.0.0-20260727080412-732f2fc9a34d.info")
          (sha256 (base16-string->bytevector "eaa642c4416bbf064cf559e5be79e6063636d0f7c0bafcb03d53ad39841954bf"))))
    (list "github.com/metacubex/jls-quic-go/@v/v0.0.0-20260727080412-732f2fc9a34d.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jls-quic-go/@v/v0.0.0-20260727080412-732f2fc9a34d.mod")
          (file-name "go-github.com-metacubex-jls-quic-go-_v-v0.0.0-20260727080412-732f2fc9a34d.mod")
          (sha256 (base16-string->bytevector "19a8d80f6843bfb13e6f1b89fcd30c0e037c430cbc11892c7c83f8ba942ebc5b"))))
    (list "github.com/metacubex/jls-quic-go/@v/v0.0.0-20260727080412-732f2fc9a34d.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jls-quic-go/@v/v0.0.0-20260727080412-732f2fc9a34d.zip")
          (file-name "go-github.com-metacubex-jls-quic-go-_v-v0.0.0-20260727080412-732f2fc9a34d.zip")
          (sha256 (base16-string->bytevector "81489b34d2dad8e44c0a7d04f6f0bfe19c52670df84cfbfcb384ddb3d87c3998"))))
    (list "github.com/metacubex/jls-tls/@v/v0.0.0-20260723084315-67adc0e2f796.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jls-tls/@v/v0.0.0-20260723084315-67adc0e2f796.info")
          (file-name "go-github.com-metacubex-jls-tls-_v-v0.0.0-20260723084315-67adc0e2f796.info")
          (sha256 (base16-string->bytevector "3e584ca64492afa672c0e0a694dec29dd90ddced983e72607cabbd682641f04c"))))
    (list "github.com/metacubex/jls-tls/@v/v0.0.0-20260723084315-67adc0e2f796.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jls-tls/@v/v0.0.0-20260723084315-67adc0e2f796.mod")
          (file-name "go-github.com-metacubex-jls-tls-_v-v0.0.0-20260723084315-67adc0e2f796.mod")
          (sha256 (base16-string->bytevector "d87e753842c7d21a7db059ce9c7325ca32b108828f4bfe9da710c7a3aa059aaf"))))
    (list "github.com/metacubex/jls-tls/@v/v0.0.0-20260723084315-67adc0e2f796.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jls-tls/@v/v0.0.0-20260723084315-67adc0e2f796.zip")
          (file-name "go-github.com-metacubex-jls-tls-_v-v0.0.0-20260723084315-67adc0e2f796.zip")
          (sha256 (base16-string->bytevector "afd3fbb2c7c9dc08b452e20295bd4935330e1095f46a4ebd490053fd63cfe08d"))))
    (list "github.com/metacubex/jsonv2/@v/v0.0.0-20260721082349-16b4998c8f89.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jsonv2/@v/v0.0.0-20260721082349-16b4998c8f89.info")
          (file-name "go-github.com-metacubex-jsonv2-_v-v0.0.0-20260721082349-16b4998c8f89.info")
          (sha256 (base16-string->bytevector "1f7bd546dde443c4f452ff6432dcc16b6bb699f973bd25042d0323ebe3c02a69"))))
    (list "github.com/metacubex/jsonv2/@v/v0.0.0-20260721082349-16b4998c8f89.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jsonv2/@v/v0.0.0-20260721082349-16b4998c8f89.mod")
          (file-name "go-github.com-metacubex-jsonv2-_v-v0.0.0-20260721082349-16b4998c8f89.mod")
          (sha256 (base16-string->bytevector "f21b8578506cd28ad59158a084a12571a034aae4cb7be7270df5c74dcfbd0f29"))))
    (list "github.com/metacubex/jsonv2/@v/v0.0.0-20260721082349-16b4998c8f89.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/jsonv2/@v/v0.0.0-20260721082349-16b4998c8f89.zip")
          (file-name "go-github.com-metacubex-jsonv2-_v-v0.0.0-20260721082349-16b4998c8f89.zip")
          (sha256 (base16-string->bytevector "0cb75ff10715d1602b1f61438b38fc785f938a2f1c016fe9f5b3374f1f62e37b"))))
    (list "github.com/metacubex/kcp-go/@v/v0.0.0-20260105040817-550693377604.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/kcp-go/@v/v0.0.0-20260105040817-550693377604.info")
          (file-name "go-github.com-metacubex-kcp-go-_v-v0.0.0-20260105040817-550693377604.info")
          (sha256 (base16-string->bytevector "230b7cfaffc51621b41d46df89994e3099d8794a5b944a8564eda6f770e79420"))))
    (list "github.com/metacubex/kcp-go/@v/v0.0.0-20260105040817-550693377604.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/kcp-go/@v/v0.0.0-20260105040817-550693377604.mod")
          (file-name "go-github.com-metacubex-kcp-go-_v-v0.0.0-20260105040817-550693377604.mod")
          (sha256 (base16-string->bytevector "6567320d003def88b88d3c43be87209d9a70229c5d533ad50525e0ef0cfe988c"))))
    (list "github.com/metacubex/kcp-go/@v/v0.0.0-20260105040817-550693377604.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/kcp-go/@v/v0.0.0-20260105040817-550693377604.zip")
          (file-name "go-github.com-metacubex-kcp-go-_v-v0.0.0-20260105040817-550693377604.zip")
          (sha256 (base16-string->bytevector "e37d0c3923f693cfd7bb9aaa4dc91747a130faae0c3cfe664c047d1c6e8f0125"))))
    (list "github.com/metacubex/mhurl/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mhurl/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-mhurl-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "3bff204d52d50d3b5c961e53bea0b3d276809e71fdbb3390fcfc8afec73f659b"))))
    (list "github.com/metacubex/mhurl/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mhurl/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-mhurl-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "754ccfe17992597c700d3fc2324301a0526e3bc2f6d6fa11a4fb53d6c124c20a"))))
    (list "github.com/metacubex/mhurl/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mhurl/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-mhurl-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "4fdc6e3f4922fb233f640e7078c0504b9d8f39b37d2a24fae795a64bd859b512"))))
    (list "github.com/metacubex/mipstack/@v/v0.0.0-20260816065001-b7038299fe13.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mipstack/@v/v0.0.0-20260816065001-b7038299fe13.info")
          (file-name "go-github.com-metacubex-mipstack-_v-v0.0.0-20260816065001-b7038299fe13.info")
          (sha256 (base16-string->bytevector "b6426fa0486b4d65c81939509ae22f884a4172227603a4503ace665750c61773"))))
    (list "github.com/metacubex/mipstack/@v/v0.0.0-20260816065001-b7038299fe13.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mipstack/@v/v0.0.0-20260816065001-b7038299fe13.mod")
          (file-name "go-github.com-metacubex-mipstack-_v-v0.0.0-20260816065001-b7038299fe13.mod")
          (sha256 (base16-string->bytevector "f2f7f648a84ce4b816c7b59813113f26b5f06bda8f28cb80478dc6704ded5655"))))
    (list "github.com/metacubex/mipstack/@v/v0.0.0-20260816065001-b7038299fe13.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mipstack/@v/v0.0.0-20260816065001-b7038299fe13.zip")
          (file-name "go-github.com-metacubex-mipstack-_v-v0.0.0-20260816065001-b7038299fe13.zip")
          (sha256 (base16-string->bytevector "1f32050467ed260ab4748f733c8997f8b06ce8012da4be91e293c844c6cc4402"))))
    (list "github.com/metacubex/mlkem/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mlkem/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-mlkem-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "6edf9bb7d14ec67ba96013349404e28e6b18bd65065c61ca4beb8d28bd96ed2f"))))
    (list "github.com/metacubex/mlkem/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mlkem/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-mlkem-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "280cb0df08687eb9c7d4caf957945e33d33a49d8074fea6f8b221b666501d71a"))))
    (list "github.com/metacubex/mlkem/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/mlkem/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-mlkem-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "66b22000ed184b11565fa51cd12d581b655d13c78143c91ef387f707032381ab"))))
    (list "github.com/metacubex/nftables/@v/v0.0.0-20260426003805-208c2c1ba2cb.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/nftables/@v/v0.0.0-20260426003805-208c2c1ba2cb.info")
          (file-name "go-github.com-metacubex-nftables-_v-v0.0.0-20260426003805-208c2c1ba2cb.info")
          (sha256 (base16-string->bytevector "22c637d5aa3531c6494b0c955d48b1a74d95beb1563f55b96cb5b147c4cbf405"))))
    (list "github.com/metacubex/nftables/@v/v0.0.0-20260426003805-208c2c1ba2cb.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/nftables/@v/v0.0.0-20260426003805-208c2c1ba2cb.mod")
          (file-name "go-github.com-metacubex-nftables-_v-v0.0.0-20260426003805-208c2c1ba2cb.mod")
          (sha256 (base16-string->bytevector "a8d8bd1298609e22fcbebac759759d8b8d2a2801e8032ec92ebe3445d57e4a0e"))))
    (list "github.com/metacubex/nftables/@v/v0.0.0-20260426003805-208c2c1ba2cb.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/nftables/@v/v0.0.0-20260426003805-208c2c1ba2cb.zip")
          (file-name "go-github.com-metacubex-nftables-_v-v0.0.0-20260426003805-208c2c1ba2cb.zip")
          (sha256 (base16-string->bytevector "43adabd17e52ffed77130b4bfeaf2b8a2adcc3459a47abab813b6cf43f4e2bef"))))
    (list "github.com/metacubex/protobuf-go/@v/v0.0.0-20260306035419-7ceee0674686.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/protobuf-go/@v/v0.0.0-20260306035419-7ceee0674686.info")
          (file-name "go-github.com-metacubex-protobuf-go-_v-v0.0.0-20260306035419-7ceee0674686.info")
          (sha256 (base16-string->bytevector "c09d4a5df5decdd0f12279c6de19c217fee133b7a74544c7d6273614b17bf4d0"))))
    (list "github.com/metacubex/protobuf-go/@v/v0.0.0-20260306035419-7ceee0674686.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/protobuf-go/@v/v0.0.0-20260306035419-7ceee0674686.mod")
          (file-name "go-github.com-metacubex-protobuf-go-_v-v0.0.0-20260306035419-7ceee0674686.mod")
          (sha256 (base16-string->bytevector "5194f33a32bf40793e5c2f0180806171c147638f91ec89c7b1cd90df4cf1f075"))))
    (list "github.com/metacubex/protobuf-go/@v/v0.0.0-20260306035419-7ceee0674686.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/protobuf-go/@v/v0.0.0-20260306035419-7ceee0674686.zip")
          (file-name "go-github.com-metacubex-protobuf-go-_v-v0.0.0-20260306035419-7ceee0674686.zip")
          (sha256 (base16-string->bytevector "ccb778707cdc9ef356cf8a3134bcc85e19be8bea3901870a3cd8b8c762410b91"))))
    (list "github.com/metacubex/qpack/@v/v0.6.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/qpack/@v/v0.6.0.info")
          (file-name "go-github.com-metacubex-qpack-_v-v0.6.0.info")
          (sha256 (base16-string->bytevector "7a7d0edda79a6ec7964198d5b689230b5d71ddb08654e8d7a795f0077db65acb"))))
    (list "github.com/metacubex/qpack/@v/v0.6.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/qpack/@v/v0.6.0.mod")
          (file-name "go-github.com-metacubex-qpack-_v-v0.6.0.mod")
          (sha256 (base16-string->bytevector "2872989657a70de7f1b056ca8fce8d5095e07b6c15978210ab4910e3158301c1"))))
    (list "github.com/metacubex/qpack/@v/v0.6.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/qpack/@v/v0.6.0.zip")
          (file-name "go-github.com-metacubex-qpack-_v-v0.6.0.zip")
          (sha256 (base16-string->bytevector "65e1f7f8895d2697bc105987776898e76261f36322c0e7d6cc0729891f41d8cb"))))
    (list "github.com/metacubex/quic-go/@v/v0.61.1-0.20260727080200-2548683b76f4.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/quic-go/@v/v0.61.1-0.20260727080200-2548683b76f4.info")
          (file-name "go-github.com-metacubex-quic-go-_v-v0.61.1-0.20260727080200-2548683b76f4.info")
          (sha256 (base16-string->bytevector "dc4c4752ec42656fa673deeb7fb13268e49f40c4bbd0509791716fe9cdf99534"))))
    (list "github.com/metacubex/quic-go/@v/v0.61.1-0.20260727080200-2548683b76f4.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/quic-go/@v/v0.61.1-0.20260727080200-2548683b76f4.mod")
          (file-name "go-github.com-metacubex-quic-go-_v-v0.61.1-0.20260727080200-2548683b76f4.mod")
          (sha256 (base16-string->bytevector "67084b9920182a1afafef32b19c71403fea260ff637f285a2a630560fa38781a"))))
    (list "github.com/metacubex/quic-go/@v/v0.61.1-0.20260727080200-2548683b76f4.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/quic-go/@v/v0.61.1-0.20260727080200-2548683b76f4.zip")
          (file-name "go-github.com-metacubex-quic-go-_v-v0.61.1-0.20260727080200-2548683b76f4.zip")
          (sha256 (base16-string->bytevector "d1f53a9e9e6eb502b5738de6d8a95c32b36675f95418ff92a0b5deb67dfc73b5"))))
    (list "github.com/metacubex/randv2/@v/v0.2.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/randv2/@v/v0.2.0.info")
          (file-name "go-github.com-metacubex-randv2-_v-v0.2.0.info")
          (sha256 (base16-string->bytevector "8d57d0f598a137024919414dbfac25b7ddeae9250d460ce3a5366aa4b18efcda"))))
    (list "github.com/metacubex/randv2/@v/v0.2.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/randv2/@v/v0.2.0.mod")
          (file-name "go-github.com-metacubex-randv2-_v-v0.2.0.mod")
          (sha256 (base16-string->bytevector "b8ecd78a9c64dd4bb5d3c6aca72248146f59cd287dd858d8a4ab112a5631e778"))))
    (list "github.com/metacubex/randv2/@v/v0.2.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/randv2/@v/v0.2.0.zip")
          (file-name "go-github.com-metacubex-randv2-_v-v0.2.0.zip")
          (sha256 (base16-string->bytevector "e71e838b8b6679124e88c987f72351c5640023fbf3e664d0cd13acbd8750e8ff"))))
    (list "github.com/metacubex/restls-client-go/@v/v0.1.9.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/restls-client-go/@v/v0.1.9.info")
          (file-name "go-github.com-metacubex-restls-client-go-_v-v0.1.9.info")
          (sha256 (base16-string->bytevector "8f23f5bd6232e7750445780336093070ede09e5bf591b4cc2cbf5fb8de4a4f22"))))
    (list "github.com/metacubex/restls-client-go/@v/v0.1.9.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/restls-client-go/@v/v0.1.9.mod")
          (file-name "go-github.com-metacubex-restls-client-go-_v-v0.1.9.mod")
          (sha256 (base16-string->bytevector "427f09887b8b4d0c4256a3f6566aee3d74bed616f65af5ba1c5b6904cd5b2948"))))
    (list "github.com/metacubex/restls-client-go/@v/v0.1.9.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/restls-client-go/@v/v0.1.9.zip")
          (file-name "go-github.com-metacubex-restls-client-go-_v-v0.1.9.zip")
          (sha256 (base16-string->bytevector "c79c9f40ddb880f84d0681377688d1ab8ae99063892d59cb9da06ed12808b611"))))
    (list "github.com/metacubex/sevenzip/@v/v1.6.4.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sevenzip/@v/v1.6.4.info")
          (file-name "go-github.com-metacubex-sevenzip-_v-v1.6.4.info")
          (sha256 (base16-string->bytevector "cbc2eb2d0ee5d5b8ad21bf727616822b7d1bbaebb8283f68d630b7e15b541f5d"))))
    (list "github.com/metacubex/sevenzip/@v/v1.6.4.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sevenzip/@v/v1.6.4.mod")
          (file-name "go-github.com-metacubex-sevenzip-_v-v1.6.4.mod")
          (sha256 (base16-string->bytevector "7603945973fbbad85eb08c53e292e59cc9e8eda02b216043ca3f2923c77b4818"))))
    (list "github.com/metacubex/sevenzip/@v/v1.6.4.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sevenzip/@v/v1.6.4.zip")
          (file-name "go-github.com-metacubex-sevenzip-_v-v1.6.4.zip")
          (sha256 (base16-string->bytevector "13d455788855dbe843ebdcbec75ab83a634d086a01ee54b72469defe5307e51f"))))
    (list "github.com/metacubex/sing/@v/v0.5.7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing/@v/v0.5.7.info")
          (file-name "go-github.com-metacubex-sing-_v-v0.5.7.info")
          (sha256 (base16-string->bytevector "40294a8394f1b435add9666db002c74d652161054e97764d31a3e33bcf283f6f"))))
    (list "github.com/metacubex/sing/@v/v0.5.7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing/@v/v0.5.7.mod")
          (file-name "go-github.com-metacubex-sing-_v-v0.5.7.mod")
          (sha256 (base16-string->bytevector "952bd844b36021852c29dc8e28cc201b7654a8ca179d3e884c8b51b55070bf86"))))
    (list "github.com/metacubex/sing/@v/v0.5.7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing/@v/v0.5.7.zip")
          (file-name "go-github.com-metacubex-sing-_v-v0.5.7.zip")
          (sha256 (base16-string->bytevector "76ab6ca3df0c68e1257db8ae043b0c3bd571086352a43ed9523d1755b4bcdd4c"))))
    (list "github.com/metacubex/sing-mux/@v/v0.3.10.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-mux/@v/v0.3.10.info")
          (file-name "go-github.com-metacubex-sing-mux-_v-v0.3.10.info")
          (sha256 (base16-string->bytevector "b2f8f426d634375e98b8f40634329fe7d06b8f0afdfc34d44ed73da94dd5979c"))))
    (list "github.com/metacubex/sing-mux/@v/v0.3.10.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-mux/@v/v0.3.10.mod")
          (file-name "go-github.com-metacubex-sing-mux-_v-v0.3.10.mod")
          (sha256 (base16-string->bytevector "bf73d4a0ee85e7324b0ae42ed0d9dbf2c841400785cf39213004463eefe8de98"))))
    (list "github.com/metacubex/sing-mux/@v/v0.3.10.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-mux/@v/v0.3.10.zip")
          (file-name "go-github.com-metacubex-sing-mux-_v-v0.3.10.zip")
          (sha256 (base16-string->bytevector "6bdcbfa25649e3e893ea4601a3385dc7fb22fc6a7fbcc4978d9ababf61acd0d0"))))
    (list "github.com/metacubex/sing-quic/@v/v0.0.0-20260726014900-38b0e9295f51.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-quic/@v/v0.0.0-20260726014900-38b0e9295f51.info")
          (file-name "go-github.com-metacubex-sing-quic-_v-v0.0.0-20260726014900-38b0e9295f51.info")
          (sha256 (base16-string->bytevector "e9e88b337ffc46660276a75a6703d622668add798161a75ff299c2445c2dfd2a"))))
    (list "github.com/metacubex/sing-quic/@v/v0.0.0-20260726014900-38b0e9295f51.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-quic/@v/v0.0.0-20260726014900-38b0e9295f51.mod")
          (file-name "go-github.com-metacubex-sing-quic-_v-v0.0.0-20260726014900-38b0e9295f51.mod")
          (sha256 (base16-string->bytevector "24e72d7ac96de0f36793f0f8d957ae0480cfd2e83b180708b0bff13901520672"))))
    (list "github.com/metacubex/sing-quic/@v/v0.0.0-20260726014900-38b0e9295f51.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-quic/@v/v0.0.0-20260726014900-38b0e9295f51.zip")
          (file-name "go-github.com-metacubex-sing-quic-_v-v0.0.0-20260726014900-38b0e9295f51.zip")
          (sha256 (base16-string->bytevector "3767745a21bd53afb1901225d3a3de3694138ab79d1dabc19c0763d387732d87"))))
    (list "github.com/metacubex/sing-shadowsocks/@v/v0.2.12.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-shadowsocks/@v/v0.2.12.info")
          (file-name "go-github.com-metacubex-sing-shadowsocks-_v-v0.2.12.info")
          (sha256 (base16-string->bytevector "9ed2c1c0d276925cd242aaf47407aef3163c32e579ef06265ecb9e31b74afd8b"))))
    (list "github.com/metacubex/sing-shadowsocks/@v/v0.2.12.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-shadowsocks/@v/v0.2.12.mod")
          (file-name "go-github.com-metacubex-sing-shadowsocks-_v-v0.2.12.mod")
          (sha256 (base16-string->bytevector "8ec97d0eca2b1ce6988ba8fbf24449ce3879f7ef75c12f4063fab8ee11ebdbce"))))
    (list "github.com/metacubex/sing-shadowsocks/@v/v0.2.12.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-shadowsocks/@v/v0.2.12.zip")
          (file-name "go-github.com-metacubex-sing-shadowsocks-_v-v0.2.12.zip")
          (sha256 (base16-string->bytevector "0c72604a42b52f3b49c055e852576f4bb538f6ee2fac9d637a4be0906356afcc"))))
    (list "github.com/metacubex/sing-shadowsocks2/@v/v0.2.7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-shadowsocks2/@v/v0.2.7.info")
          (file-name "go-github.com-metacubex-sing-shadowsocks2-_v-v0.2.7.info")
          (sha256 (base16-string->bytevector "645a5ee06fecec4d72db690ed71fb5435f5ea72696075a2336fb48fc9b4a79e7"))))
    (list "github.com/metacubex/sing-shadowsocks2/@v/v0.2.7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-shadowsocks2/@v/v0.2.7.mod")
          (file-name "go-github.com-metacubex-sing-shadowsocks2-_v-v0.2.7.mod")
          (sha256 (base16-string->bytevector "6cbe3c0fa89430fcc1bf99e5b2b4ebfd4c8d8b118212db5e8577b5a45f9962bb"))))
    (list "github.com/metacubex/sing-shadowsocks2/@v/v0.2.7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-shadowsocks2/@v/v0.2.7.zip")
          (file-name "go-github.com-metacubex-sing-shadowsocks2-_v-v0.2.7.zip")
          (sha256 (base16-string->bytevector "fd6b0d12cc7420283944983f6f7b382bff1b69007aeb73e8f881fb1dc93a303e"))))
    (list "github.com/metacubex/sing-tun/@v/v0.4.22.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-tun/@v/v0.4.22.info")
          (file-name "go-github.com-metacubex-sing-tun-_v-v0.4.22.info")
          (sha256 (base16-string->bytevector "eeb1cb27a4aea13b215ed6d2815eeae74ebba81d4aca396454ba08bffe98ecfc"))))
    (list "github.com/metacubex/sing-tun/@v/v0.4.22.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-tun/@v/v0.4.22.mod")
          (file-name "go-github.com-metacubex-sing-tun-_v-v0.4.22.mod")
          (sha256 (base16-string->bytevector "b464e6b73a2000699e72b5b0857cb42503d727f03e0344beae88ac1dc0acd4a8"))))
    (list "github.com/metacubex/sing-tun/@v/v0.4.22.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-tun/@v/v0.4.22.zip")
          (file-name "go-github.com-metacubex-sing-tun-_v-v0.4.22.zip")
          (sha256 (base16-string->bytevector "90cbc631e31cbe66585474e7708cddecaaa98b53342c3be4f164920d6a251b5c"))))
    (list "github.com/metacubex/sing-vmess/@v/v0.2.5.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-vmess/@v/v0.2.5.info")
          (file-name "go-github.com-metacubex-sing-vmess-_v-v0.2.5.info")
          (sha256 (base16-string->bytevector "2577604cfc210ac5c05a4e9a932108884a25ac9695382c8a90ffd2dedfd42993"))))
    (list "github.com/metacubex/sing-vmess/@v/v0.2.5.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-vmess/@v/v0.2.5.mod")
          (file-name "go-github.com-metacubex-sing-vmess-_v-v0.2.5.mod")
          (sha256 (base16-string->bytevector "23b3e3d6114ade48637c2cbc67e1646b66caf00d4c03996f28b28f19a83f3145"))))
    (list "github.com/metacubex/sing-vmess/@v/v0.2.5.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-vmess/@v/v0.2.5.zip")
          (file-name "go-github.com-metacubex-sing-vmess-_v-v0.2.5.zip")
          (sha256 (base16-string->bytevector "366ce3b3c3e65aad5a76079330a6a8186648d8e44f23f4c22b096e5bb5dd70bc"))))
    (list "github.com/metacubex/sing-wireguard/@v/v0.0.0-20260810013230-110eac03c3f0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-wireguard/@v/v0.0.0-20260810013230-110eac03c3f0.info")
          (file-name "go-github.com-metacubex-sing-wireguard-_v-v0.0.0-20260810013230-110eac03c3f0.info")
          (sha256 (base16-string->bytevector "2eec6cf10e1303148bc4740b1208e0a5a277a2de68ac88ad8fd95f1b1101dcbb"))))
    (list "github.com/metacubex/sing-wireguard/@v/v0.0.0-20260810013230-110eac03c3f0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-wireguard/@v/v0.0.0-20260810013230-110eac03c3f0.mod")
          (file-name "go-github.com-metacubex-sing-wireguard-_v-v0.0.0-20260810013230-110eac03c3f0.mod")
          (sha256 (base16-string->bytevector "2c794c2a8eac5940421be1d7fc9929c5bb3d496ab8b3cb54fe7287811390c491"))))
    (list "github.com/metacubex/sing-wireguard/@v/v0.0.0-20260810013230-110eac03c3f0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/sing-wireguard/@v/v0.0.0-20260810013230-110eac03c3f0.zip")
          (file-name "go-github.com-metacubex-sing-wireguard-_v-v0.0.0-20260810013230-110eac03c3f0.zip")
          (sha256 (base16-string->bytevector "10ac707639646549bb075024ba81b32b06fb344201048c0acaba9bd3ec640d54"))))
    (list "github.com/metacubex/smux/@v/v0.0.0-20260105030934-d0c8756d3141.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/smux/@v/v0.0.0-20260105030934-d0c8756d3141.info")
          (file-name "go-github.com-metacubex-smux-_v-v0.0.0-20260105030934-d0c8756d3141.info")
          (sha256 (base16-string->bytevector "3551ff13a69dc8913066bfe6564409cb4130f1d771f92eb8cbe967d39efc7b1b"))))
    (list "github.com/metacubex/smux/@v/v0.0.0-20260105030934-d0c8756d3141.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/smux/@v/v0.0.0-20260105030934-d0c8756d3141.mod")
          (file-name "go-github.com-metacubex-smux-_v-v0.0.0-20260105030934-d0c8756d3141.mod")
          (sha256 (base16-string->bytevector "18284aaba5f728ad9d18fc262293b52599044c9cc2076915f0bccabe890eb026"))))
    (list "github.com/metacubex/smux/@v/v0.0.0-20260105030934-d0c8756d3141.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/smux/@v/v0.0.0-20260105030934-d0c8756d3141.zip")
          (file-name "go-github.com-metacubex-smux-_v-v0.0.0-20260105030934-d0c8756d3141.zip")
          (sha256 (base16-string->bytevector "c1de3e665d701bb04b67ff379b118a6554f4ecd1d2221cc78131006439eba106"))))
    (list "github.com/metacubex/ssh/@v/v0.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/ssh/@v/v0.1.0.info")
          (file-name "go-github.com-metacubex-ssh-_v-v0.1.0.info")
          (sha256 (base16-string->bytevector "88b6be6255354973b625318e93ad427f55e348c1af8bd6933bdd1dcfc8696a45"))))
    (list "github.com/metacubex/ssh/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/ssh/@v/v0.1.0.mod")
          (file-name "go-github.com-metacubex-ssh-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "1a81c8c02956c46ed8427c4c2ce8573ea162c29d6da5303bc7a7e85e91681b32"))))
    (list "github.com/metacubex/ssh/@v/v0.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/ssh/@v/v0.1.0.zip")
          (file-name "go-github.com-metacubex-ssh-_v-v0.1.0.zip")
          (sha256 (base16-string->bytevector "f06b3d41029c0453478cc7722dcf3cf1da083f6b153d7b210d0e5e7b4196a5df"))))
    (list "github.com/metacubex/tailscale/@v/v0.0.0-20260807072706-a4fb5feabcbb.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tailscale/@v/v0.0.0-20260807072706-a4fb5feabcbb.info")
          (file-name "go-github.com-metacubex-tailscale-_v-v0.0.0-20260807072706-a4fb5feabcbb.info")
          (sha256 (base16-string->bytevector "14f743a5d9ac8e60719474cabba98efe081170335046e1c541a788ee7f4c5d46"))))
    (list "github.com/metacubex/tailscale/@v/v0.0.0-20260807072706-a4fb5feabcbb.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tailscale/@v/v0.0.0-20260807072706-a4fb5feabcbb.mod")
          (file-name "go-github.com-metacubex-tailscale-_v-v0.0.0-20260807072706-a4fb5feabcbb.mod")
          (sha256 (base16-string->bytevector "f60704ae875bf3419055c2eae424650d9744f4d261d2613d67f88d91cadf8eaa"))))
    (list "github.com/metacubex/tailscale/@v/v0.0.0-20260807072706-a4fb5feabcbb.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tailscale/@v/v0.0.0-20260807072706-a4fb5feabcbb.zip")
          (file-name "go-github.com-metacubex-tailscale-_v-v0.0.0-20260807072706-a4fb5feabcbb.zip")
          (sha256 (base16-string->bytevector "d401466db99eec00ab8f4c391da2b267bbee6533305ae033d72af423c0423856"))))
    (list "github.com/metacubex/tailscale-wireguard-go/@v/v0.0.0-20260725073821-e61ab99cede2.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tailscale-wireguard-go/@v/v0.0.0-20260725073821-e61ab99cede2.info")
          (file-name "go-github.com-metacubex-tailscale-wireguard-go-_v-v0.0.0-20260725073821-e61ab99cede2.info")
          (sha256 (base16-string->bytevector "32709f602f36d62ae7bf471ba6e9d58b48f1dddcd7af300a94b344b3f30163ef"))))
    (list "github.com/metacubex/tailscale-wireguard-go/@v/v0.0.0-20260725073821-e61ab99cede2.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tailscale-wireguard-go/@v/v0.0.0-20260725073821-e61ab99cede2.mod")
          (file-name "go-github.com-metacubex-tailscale-wireguard-go-_v-v0.0.0-20260725073821-e61ab99cede2.mod")
          (sha256 (base16-string->bytevector "b751a573f6bd99096591e1dbd207c8686e1417373c6f0b2ce0db785d4f4507f4"))))
    (list "github.com/metacubex/tailscale-wireguard-go/@v/v0.0.0-20260725073821-e61ab99cede2.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tailscale-wireguard-go/@v/v0.0.0-20260725073821-e61ab99cede2.zip")
          (file-name "go-github.com-metacubex-tailscale-wireguard-go-_v-v0.0.0-20260725073821-e61ab99cede2.zip")
          (sha256 (base16-string->bytevector "7daac962a2493b9a63b581f85167608dde2c7fe5c5f07c80130b26972cdfddea"))))
    (list "github.com/metacubex/tfo-go/@v/v0.0.0-20260623020846-376a77860b8c.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tfo-go/@v/v0.0.0-20260623020846-376a77860b8c.info")
          (file-name "go-github.com-metacubex-tfo-go-_v-v0.0.0-20260623020846-376a77860b8c.info")
          (sha256 (base16-string->bytevector "67da807cb1d49f13c4cff3fc6e1659369358bafe85f4251dbce8cf198c74f442"))))
    (list "github.com/metacubex/tfo-go/@v/v0.0.0-20260623020846-376a77860b8c.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tfo-go/@v/v0.0.0-20260623020846-376a77860b8c.mod")
          (file-name "go-github.com-metacubex-tfo-go-_v-v0.0.0-20260623020846-376a77860b8c.mod")
          (sha256 (base16-string->bytevector "b784cd45c2890f99c1d8c69293c435c4669b356ae466ca7dbe2be452093469d4"))))
    (list "github.com/metacubex/tfo-go/@v/v0.0.0-20260623020846-376a77860b8c.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tfo-go/@v/v0.0.0-20260623020846-376a77860b8c.zip")
          (file-name "go-github.com-metacubex-tfo-go-_v-v0.0.0-20260623020846-376a77860b8c.zip")
          (sha256 (base16-string->bytevector "4c1552308aadbf371a0ea63000b5e960b526d08ced85250617e8cab126ed6882"))))
    (list "github.com/metacubex/tls/@v/v0.1.8.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tls/@v/v0.1.8.info")
          (file-name "go-github.com-metacubex-tls-_v-v0.1.8.info")
          (sha256 (base16-string->bytevector "b33ecb2baa84412742de5717bbfff0a55947e97b060f501562d6e78d1f23c6a2"))))
    (list "github.com/metacubex/tls/@v/v0.1.8.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tls/@v/v0.1.8.mod")
          (file-name "go-github.com-metacubex-tls-_v-v0.1.8.mod")
          (sha256 (base16-string->bytevector "d1f67c2cfbb94e66ac0d6364d66c90ba42b87a08f3d76857b331460c0804f053"))))
    (list "github.com/metacubex/tls/@v/v0.1.8.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/tls/@v/v0.1.8.zip")
          (file-name "go-github.com-metacubex-tls-_v-v0.1.8.zip")
          (sha256 (base16-string->bytevector "af492a51d3085e0e8f521dda331b6a649eca7163f47439905f247563fa976c5e"))))
    (list "github.com/metacubex/utls/@v/v1.8.7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/utls/@v/v1.8.7.info")
          (file-name "go-github.com-metacubex-utls-_v-v1.8.7.info")
          (sha256 (base16-string->bytevector "28f311bb59b58f11c2ce4250f8279a0851c3b930854a10245f86b37c26d5c422"))))
    (list "github.com/metacubex/utls/@v/v1.8.7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/utls/@v/v1.8.7.mod")
          (file-name "go-github.com-metacubex-utls-_v-v1.8.7.mod")
          (sha256 (base16-string->bytevector "bcc0b7db23cdf8aa9c84bacc13f8651b2bda1d8b6ff3dbc430221d801f0f02a1"))))
    (list "github.com/metacubex/utls/@v/v1.8.7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/utls/@v/v1.8.7.zip")
          (file-name "go-github.com-metacubex-utls-_v-v1.8.7.zip")
          (sha256 (base16-string->bytevector "2c29de950b4778b9d47b0a3cb02b8a50766c2cc3de622a5f12fdf9f5a785711e"))))
    (list "github.com/metacubex/wireguard-go/@v/v0.0.0-20250820062549-a6cecdd7f57f.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/wireguard-go/@v/v0.0.0-20250820062549-a6cecdd7f57f.info")
          (file-name "go-github.com-metacubex-wireguard-go-_v-v0.0.0-20250820062549-a6cecdd7f57f.info")
          (sha256 (base16-string->bytevector "9488493b95862e67fa8dd4275a994bad4f08ea8981930ef5a6514d968ed796a4"))))
    (list "github.com/metacubex/wireguard-go/@v/v0.0.0-20250820062549-a6cecdd7f57f.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/wireguard-go/@v/v0.0.0-20250820062549-a6cecdd7f57f.mod")
          (file-name "go-github.com-metacubex-wireguard-go-_v-v0.0.0-20250820062549-a6cecdd7f57f.mod")
          (sha256 (base16-string->bytevector "124ae70d844e4a786e71955bced5111852b0c470bf55ebbd33a61798350a30fd"))))
    (list "github.com/metacubex/wireguard-go/@v/v0.0.0-20250820062549-a6cecdd7f57f.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/wireguard-go/@v/v0.0.0-20250820062549-a6cecdd7f57f.zip")
          (file-name "go-github.com-metacubex-wireguard-go-_v-v0.0.0-20250820062549-a6cecdd7f57f.zip")
          (sha256 (base16-string->bytevector "64365aae87e5a4845a64897cfd30ad51f28e1d34986bfd70f57827d94f334ae7"))))
    (list "github.com/metacubex/yamux/@v/v0.0.0-20250918083631-dd5f17c0be49.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/yamux/@v/v0.0.0-20250918083631-dd5f17c0be49.info")
          (file-name "go-github.com-metacubex-yamux-_v-v0.0.0-20250918083631-dd5f17c0be49.info")
          (sha256 (base16-string->bytevector "abd93e1577906b3851953c8c025fcc65c48cdc939a9390bc6200fdbce2f63a32"))))
    (list "github.com/metacubex/yamux/@v/v0.0.0-20250918083631-dd5f17c0be49.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/yamux/@v/v0.0.0-20250918083631-dd5f17c0be49.mod")
          (file-name "go-github.com-metacubex-yamux-_v-v0.0.0-20250918083631-dd5f17c0be49.mod")
          (sha256 (base16-string->bytevector "c0271215206a9a990635bf803ac6d6d914eb3bf08f13b34b49694c56905913ed"))))
    (list "github.com/metacubex/yamux/@v/v0.0.0-20250918083631-dd5f17c0be49.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/yamux/@v/v0.0.0-20250918083631-dd5f17c0be49.zip")
          (file-name "go-github.com-metacubex-yamux-_v-v0.0.0-20250918083631-dd5f17c0be49.zip")
          (sha256 (base16-string->bytevector "0aaaea640061b16df9ba66948031a6453c4eb53ac74f43c1a75d4432a35dc050"))))
    (list "github.com/metacubex/zerotier-go/@v/v0.0.0-20260813124750-13fa6f45da5f.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/zerotier-go/@v/v0.0.0-20260813124750-13fa6f45da5f.info")
          (file-name "go-github.com-metacubex-zerotier-go-_v-v0.0.0-20260813124750-13fa6f45da5f.info")
          (sha256 (base16-string->bytevector "2f5541f1b5beb472f9c87d2befd058a5a1cdf066613ceca78121ef36a7e70bc4"))))
    (list "github.com/metacubex/zerotier-go/@v/v0.0.0-20260813124750-13fa6f45da5f.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/zerotier-go/@v/v0.0.0-20260813124750-13fa6f45da5f.mod")
          (file-name "go-github.com-metacubex-zerotier-go-_v-v0.0.0-20260813124750-13fa6f45da5f.mod")
          (sha256 (base16-string->bytevector "a395ea370ea3b4e5194cc11c27a0385bcede5cc6d655c077e4708e10fa3d62ea"))))
    (list "github.com/metacubex/zerotier-go/@v/v0.0.0-20260813124750-13fa6f45da5f.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/metacubex/zerotier-go/@v/v0.0.0-20260813124750-13fa6f45da5f.zip")
          (file-name "go-github.com-metacubex-zerotier-go-_v-v0.0.0-20260813124750-13fa6f45da5f.zip")
          (sha256 (base16-string->bytevector "cfe7cd4a6ec5c2649d2866b31f9cf1d5409170016a71d3aa96a8f79171713a06"))))
    (list "github.com/miekg/dns/@v/v1.1.63.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/miekg/dns/@v/v1.1.63.info")
          (file-name "go-github.com-miekg-dns-_v-v1.1.63.info")
          (sha256 (base16-string->bytevector "2107e06f3a89dc327db1ad76cb0af965a11b3a7c0b16c87eab6fbbbe8f33708d"))))
    (list "github.com/miekg/dns/@v/v1.1.63.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/miekg/dns/@v/v1.1.63.mod")
          (file-name "go-github.com-miekg-dns-_v-v1.1.63.mod")
          (sha256 (base16-string->bytevector "29b69b8746ae29ed3240df3965221d1abb944dbc31748fee7ce3411311af5a5e"))))
    (list "github.com/miekg/dns/@v/v1.1.63.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/miekg/dns/@v/v1.1.63.zip")
          (file-name "go-github.com-miekg-dns-_v-v1.1.63.zip")
          (sha256 (base16-string->bytevector "8d0268cc9e6399c264dd4cb632fb76ed4e389330db0c4b311ba6ae1f46923eeb"))))
    (list "github.com/mitchellh/go-ps/@v/v1.0.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mitchellh/go-ps/@v/v1.0.0.info")
          (file-name "go-github.com-mitchellh-go-ps-_v-v1.0.0.info")
          (sha256 (base16-string->bytevector "4de400318013406652d87ea6911388a59a820d13bf59dd2ed2162397bdc63d9a"))))
    (list "github.com/mitchellh/go-ps/@v/v1.0.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mitchellh/go-ps/@v/v1.0.0.mod")
          (file-name "go-github.com-mitchellh-go-ps-_v-v1.0.0.mod")
          (sha256 (base16-string->bytevector "4c9cf17f3fdf28ca0f95c15e1bf976e3b5065bebec1e76a8052373f32a9846c4"))))
    (list "github.com/mitchellh/go-ps/@v/v1.0.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mitchellh/go-ps/@v/v1.0.0.zip")
          (file-name "go-github.com-mitchellh-go-ps-_v-v1.0.0.zip")
          (sha256 (base16-string->bytevector "f2f0400b1d5e136419daed275c27a930b0f5447ac12bb8acd3ddbe39547b2834"))))
    (list "github.com/mroth/weightedrand/v2/@v/v2.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mroth/weightedrand/v2/@v/v2.1.0.info")
          (file-name "go-github.com-mroth-weightedrand-v2-_v-v2.1.0.info")
          (sha256 (base16-string->bytevector "062b024b2dba8710d1b94904ddb9c8847194e8d800576aebc003788ad8f16198"))))
    (list "github.com/mroth/weightedrand/v2/@v/v2.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mroth/weightedrand/v2/@v/v2.1.0.mod")
          (file-name "go-github.com-mroth-weightedrand-v2-_v-v2.1.0.mod")
          (sha256 (base16-string->bytevector "1a1309a94a188255c3a2ae13ffc14727ba5b72608f4befb42d37cdca16f2bd3d"))))
    (list "github.com/mroth/weightedrand/v2/@v/v2.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/mroth/weightedrand/v2/@v/v2.1.0.zip")
          (file-name "go-github.com-mroth-weightedrand-v2-_v-v2.1.0.zip")
          (sha256 (base16-string->bytevector "ab726e329007198fa87b9e4489ecaccf0fcde4da537951e6237946e9d062669d"))))
    (list "github.com/oasisprotocol/deoxysii/@v/v0.0.0-20220228165953-2091330c22b7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/oasisprotocol/deoxysii/@v/v0.0.0-20220228165953-2091330c22b7.info")
          (file-name "go-github.com-oasisprotocol-deoxysii-_v-v0.0.0-20220228165953-2091330c22b7.info")
          (sha256 (base16-string->bytevector "2d07bc24134485d3ef6234f55312a7052fac8afb55afa12376151f17fc327886"))))
    (list "github.com/oasisprotocol/deoxysii/@v/v0.0.0-20220228165953-2091330c22b7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/oasisprotocol/deoxysii/@v/v0.0.0-20220228165953-2091330c22b7.mod")
          (file-name "go-github.com-oasisprotocol-deoxysii-_v-v0.0.0-20220228165953-2091330c22b7.mod")
          (sha256 (base16-string->bytevector "405ae7fe9974f2c1b9118585dcfd3b9754b63a8e1ca807ccc117e21c8dab58b4"))))
    (list "github.com/oasisprotocol/deoxysii/@v/v0.0.0-20220228165953-2091330c22b7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/oasisprotocol/deoxysii/@v/v0.0.0-20220228165953-2091330c22b7.zip")
          (file-name "go-github.com-oasisprotocol-deoxysii-_v-v0.0.0-20220228165953-2091330c22b7.zip")
          (sha256 (base16-string->bytevector "8c79b7068e42ff035ec81f4bf898150283317a702a25b91b23edf0709139171c"))))
    (list "github.com/openacid/errors/@v/v0.8.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/openacid/errors/@v/v0.8.1.mod")
          (file-name "go-github.com-openacid-errors-_v-v0.8.1.mod")
          (sha256 (base16-string->bytevector "616aa6f7aa9b569070f65489467f52968e69bcff93d93a65f8ac86e65b82a5ac"))))
    (list "github.com/openacid/low/@v/v0.1.21.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/openacid/low/@v/v0.1.21.info")
          (file-name "go-github.com-openacid-low-_v-v0.1.21.info")
          (sha256 (base16-string->bytevector "3dbbc0d832dc9e60e5f4125e8e3f4d6dbce374343c4170aad7a8ea636be41682"))))
    (list "github.com/openacid/low/@v/v0.1.21.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/openacid/low/@v/v0.1.21.mod")
          (file-name "go-github.com-openacid-low-_v-v0.1.21.mod")
          (sha256 (base16-string->bytevector "625be7fb687d0f89aa2cf45c7693de1630d898958c7f7739a44ded646f62af92"))))
    (list "github.com/openacid/low/@v/v0.1.21.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/openacid/low/@v/v0.1.21.zip")
          (file-name "go-github.com-openacid-low-_v-v0.1.21.zip")
          (sha256 (base16-string->bytevector "d1b56672b1131e40a9894cb4b531231a0d4156933783e5182dbecac1329b04b5"))))
    (list "github.com/openacid/must/@v/v0.1.3.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/openacid/must/@v/v0.1.3.mod")
          (file-name "go-github.com-openacid-must-_v-v0.1.3.mod")
          (sha256 (base16-string->bytevector "332e340ee6d00e1d1a4e8f8decc5d91dbb59da61d9c136d6f119df9f0166d66f"))))
    (list "github.com/openacid/testkeys/@v/v0.1.6.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/openacid/testkeys/@v/v0.1.6.mod")
          (file-name "go-github.com-openacid-testkeys-_v-v0.1.6.mod")
          (sha256 (base16-string->bytevector "f202b075e5cd77ca85fdd6cf89ab5061b933d92713fe1ef248766a9572b64a9c"))))
    (list "github.com/oschwald/maxminddb-golang/@v/v1.12.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/oschwald/maxminddb-golang/@v/v1.12.0.info")
          (file-name "go-github.com-oschwald-maxminddb-golang-_v-v1.12.0.info")
          (sha256 (base16-string->bytevector "6df2a44ff833d64fa431dd07b71201aab379b050bcd1d79d871224a1e161d8e9"))))
    (list "github.com/oschwald/maxminddb-golang/@v/v1.12.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/oschwald/maxminddb-golang/@v/v1.12.0.mod")
          (file-name "go-github.com-oschwald-maxminddb-golang-_v-v1.12.0.mod")
          (sha256 (base16-string->bytevector "45b76ac6efdd858450bdf00ab8c1d3adbfbed419d42d6ae15441646baeeac07e"))))
    (list "github.com/oschwald/maxminddb-golang/@v/v1.12.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/oschwald/maxminddb-golang/@v/v1.12.0.zip")
          (file-name "go-github.com-oschwald-maxminddb-golang-_v-v1.12.0.zip")
          (sha256 (base16-string->bytevector "160a3e324bd889247553c362405f405800c955046499d5fa5d69c149218d9206"))))
    (list "github.com/pierrec/lz4/v4/@v/v4.1.14.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pierrec/lz4/v4/@v/v4.1.14.mod")
          (file-name "go-github.com-pierrec-lz4-v4-_v-v4.1.14.mod")
          (sha256 (base16-string->bytevector "2c89e56a6db7a7760fa45f2494631d9202e10d9c5c4cb8e7377c37212d7cb975"))))
    (list "github.com/pierrec/lz4/v4/@v/v4.1.27.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pierrec/lz4/v4/@v/v4.1.27.info")
          (file-name "go-github.com-pierrec-lz4-v4-_v-v4.1.27.info")
          (sha256 (base16-string->bytevector "19ae29cd560696c510b874faa82cc82049df4e087a06d6a683e078363bf7f6ea"))))
    (list "github.com/pierrec/lz4/v4/@v/v4.1.27.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pierrec/lz4/v4/@v/v4.1.27.mod")
          (file-name "go-github.com-pierrec-lz4-v4-_v-v4.1.27.mod")
          (sha256 (base16-string->bytevector "d32329505d5af04449fe6ba227a97d170e0c98a99c123bf7908ac4ff44ae0f4b"))))
    (list "github.com/pierrec/lz4/v4/@v/v4.1.27.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pierrec/lz4/v4/@v/v4.1.27.zip")
          (file-name "go-github.com-pierrec-lz4-v4-_v-v4.1.27.zip")
          (sha256 (base16-string->bytevector "702ad206ffeec8d3ac8bc1ce7e2d0b201fbc7683c8ab8758210172c54f03353f"))))
    (list "github.com/pires/go-proxyproto/@v/v0.8.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pires/go-proxyproto/@v/v0.8.0.info")
          (file-name "go-github.com-pires-go-proxyproto-_v-v0.8.0.info")
          (sha256 (base16-string->bytevector "86ec24aae5c9377c2f15c79f87a0b8f67f2ef6ee7b705112189611c0783ab2e5"))))
    (list "github.com/pires/go-proxyproto/@v/v0.8.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pires/go-proxyproto/@v/v0.8.0.mod")
          (file-name "go-github.com-pires-go-proxyproto-_v-v0.8.0.mod")
          (sha256 (base16-string->bytevector "7bc5969f2bc13ed2aacc2a1dd779815106631c0e92cce691264042527b8ffad2"))))
    (list "github.com/pires/go-proxyproto/@v/v0.8.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pires/go-proxyproto/@v/v0.8.0.zip")
          (file-name "go-github.com-pires-go-proxyproto-_v-v0.8.0.zip")
          (sha256 (base16-string->bytevector "ca2a97733046c704fdfcc4666802bb82ea231d42338ffdd52a80a636b6c456bb"))))
    (list "github.com/pkg/errors/@v/v0.9.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pkg/errors/@v/v0.9.1.mod")
          (file-name "go-github.com-pkg-errors-_v-v0.9.1.mod")
          (sha256 (base16-string->bytevector "df28c6a823f181d76179697177c0c5943c6ffb38f3c10b2dc53be360ee7d4589"))))
    (list "github.com/pmezard/go-difflib/@v/v1.0.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pmezard/go-difflib/@v/v1.0.0.info")
          (file-name "go-github.com-pmezard-go-difflib-_v-v1.0.0.info")
          (sha256 (base16-string->bytevector "97cbb0239d80e5221efd1f0aa645d120272bd3ee7975bd654f07a8ed0c2c2adc"))))
    (list "github.com/pmezard/go-difflib/@v/v1.0.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pmezard/go-difflib/@v/v1.0.0.mod")
          (file-name "go-github.com-pmezard-go-difflib-_v-v1.0.0.mod")
          (sha256 (base16-string->bytevector "74b2e766eb215377864d587badf57e95521f692d2a7860b3c7759093f9c9bec2"))))
    (list "github.com/pmezard/go-difflib/@v/v1.0.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/pmezard/go-difflib/@v/v1.0.0.zip")
          (file-name "go-github.com-pmezard-go-difflib-_v-v1.0.0.zip")
          (sha256 (base16-string->bytevector "de04cecc1a4b8d53e4357051026794bcbc54f2e6a260cfac508ce69d5d6457a0"))))
    (list "github.com/prashantv/gostub/@v/v1.1.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/prashantv/gostub/@v/v1.1.0.info")
          (file-name "go-github.com-prashantv-gostub-_v-v1.1.0.info")
          (sha256 (base16-string->bytevector "e90032aba3ad194012bfcc7668416e1d7eb8bfb8c8279b5df0e8295d8153c303"))))
    (list "github.com/prashantv/gostub/@v/v1.1.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/prashantv/gostub/@v/v1.1.0.zip")
          (file-name "go-github.com-prashantv-gostub-_v-v1.1.0.zip")
          (sha256 (base16-string->bytevector "9a56047ad14092b80489df340d6ff1adbb7db588f1558714dd5584f4d163d41e"))))
    (list "github.com/rasky/go-lzo/@v/v0.0.0-20200203143853-96a758eda86e.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/rasky/go-lzo/@v/v0.0.0-20200203143853-96a758eda86e.info")
          (file-name "go-github.com-rasky-go-lzo-_v-v0.0.0-20200203143853-96a758eda86e.info")
          (sha256 (base16-string->bytevector "96494d2c50f6cdbb97567ddd5cb07262ace7264fbd766eb6f42d9fd338630773"))))
    (list "github.com/rasky/go-lzo/@v/v0.0.0-20200203143853-96a758eda86e.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/rasky/go-lzo/@v/v0.0.0-20200203143853-96a758eda86e.mod")
          (file-name "go-github.com-rasky-go-lzo-_v-v0.0.0-20200203143853-96a758eda86e.mod")
          (sha256 (base16-string->bytevector "dacb3a6e58355f2409b8f6dd3d38ba8b9b9bec722a5b57cc8579060be88c3888"))))
    (list "github.com/rasky/go-lzo/@v/v0.0.0-20200203143853-96a758eda86e.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/rasky/go-lzo/@v/v0.0.0-20200203143853-96a758eda86e.zip")
          (file-name "go-github.com-rasky-go-lzo-_v-v0.0.0-20200203143853-96a758eda86e.zip")
          (sha256 (base16-string->bytevector "0ac65ffc1638da5f12da18c4d8b78e22dec14ff3ff5807410ed1bcaebe24168d"))))
    (list "github.com/rogpeppe/go-internal/@v/v1.12.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/rogpeppe/go-internal/@v/v1.12.0.info")
          (file-name "go-github.com-rogpeppe-go-internal-_v-v1.12.0.info")
          (sha256 (base16-string->bytevector "5bd71e8b7662bda7c814bfc94942bdc3f0b395706d45eae66b6efb39f673d9ee"))))
    (list "github.com/rogpeppe/go-internal/@v/v1.12.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/rogpeppe/go-internal/@v/v1.12.0.zip")
          (file-name "go-github.com-rogpeppe-go-internal-_v-v1.12.0.zip")
          (sha256 (base16-string->bytevector "d4539e716c2b7f2824584e4c4a17f64c508bd6e5359106a406a7e23e77109cde"))))
    (list "github.com/safchain/ethtool/@v/v0.3.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/safchain/ethtool/@v/v0.3.0.info")
          (file-name "go-github.com-safchain-ethtool-_v-v0.3.0.info")
          (sha256 (base16-string->bytevector "b9fd908d826ea57531841697b8f8cbfd6fb45f346cdbec81501e02158e19cfec"))))
    (list "github.com/safchain/ethtool/@v/v0.3.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/safchain/ethtool/@v/v0.3.0.mod")
          (file-name "go-github.com-safchain-ethtool-_v-v0.3.0.mod")
          (sha256 (base16-string->bytevector "97bf7dcec80aab57bb5dcaa846394a8701a5c2c6ff87af0486e41dfcb011fb5c"))))
    (list "github.com/safchain/ethtool/@v/v0.3.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/safchain/ethtool/@v/v0.3.0.zip")
          (file-name "go-github.com-safchain-ethtool-_v-v0.3.0.zip")
          (sha256 (base16-string->bytevector "bfa1a3fe314a3f2ac4c4385a6c4694708e4881bfd86c34668eca92656e398590"))))
    (list "github.com/sagernet/netlink/@v/v0.0.0-20240612041022-b9a21c07ac6a.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sagernet/netlink/@v/v0.0.0-20240612041022-b9a21c07ac6a.info")
          (file-name "go-github.com-sagernet-netlink-_v-v0.0.0-20240612041022-b9a21c07ac6a.info")
          (sha256 (base16-string->bytevector "9d3b5b1d71bdadf76056d1cb0b1b54a5d0efb6c96824d0eb77c18ecd93d60f54"))))
    (list "github.com/sagernet/netlink/@v/v0.0.0-20240612041022-b9a21c07ac6a.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sagernet/netlink/@v/v0.0.0-20240612041022-b9a21c07ac6a.mod")
          (file-name "go-github.com-sagernet-netlink-_v-v0.0.0-20240612041022-b9a21c07ac6a.mod")
          (sha256 (base16-string->bytevector "43e97dc4045dd409cea4b36c8de8f02e0bf6fe1e3eddfdc1a3a4585f747c2d2e"))))
    (list "github.com/sagernet/netlink/@v/v0.0.0-20240612041022-b9a21c07ac6a.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sagernet/netlink/@v/v0.0.0-20240612041022-b9a21c07ac6a.zip")
          (file-name "go-github.com-sagernet-netlink-_v-v0.0.0-20240612041022-b9a21c07ac6a.zip")
          (sha256 (base16-string->bytevector "895c0dbc63c8f45e072cb5af2da65755d6a0221a8958fb82822cc4135e035af5"))))
    (list "github.com/samber/lo/@v/v1.53.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/samber/lo/@v/v1.53.0.info")
          (file-name "go-github.com-samber-lo-_v-v1.53.0.info")
          (sha256 (base16-string->bytevector "67383979d5f887925e4ad50d8c4850672d6a07787a4f5593b0f1e9b623f20a1c"))))
    (list "github.com/samber/lo/@v/v1.53.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/samber/lo/@v/v1.53.0.mod")
          (file-name "go-github.com-samber-lo-_v-v1.53.0.mod")
          (sha256 (base16-string->bytevector "28308b11ace5b7f1f940ab42b5360fecd5285cdf1b183f3067b02a8a5972fe2f"))))
    (list "github.com/samber/lo/@v/v1.53.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/samber/lo/@v/v1.53.0.zip")
          (file-name "go-github.com-samber-lo-_v-v1.53.0.zip")
          (sha256 (base16-string->bytevector "4969cf0094a1736a16ca0f89c42dea92369ba0ebacdbd9b22f1299ff7fe1f579"))))
    (list "github.com/sina-ghaderi/poly1305/@v/v0.0.0-20220724002748-c5926b03988b.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/poly1305/@v/v0.0.0-20220724002748-c5926b03988b.info")
          (file-name "go-github.com-sina-ghaderi-poly1305-_v-v0.0.0-20220724002748-c5926b03988b.info")
          (sha256 (base16-string->bytevector "ad35b927cd0e14ba435daa50d66902040b99c70659bc29eb3d8fccd7cf768912"))))
    (list "github.com/sina-ghaderi/poly1305/@v/v0.0.0-20220724002748-c5926b03988b.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/poly1305/@v/v0.0.0-20220724002748-c5926b03988b.mod")
          (file-name "go-github.com-sina-ghaderi-poly1305-_v-v0.0.0-20220724002748-c5926b03988b.mod")
          (sha256 (base16-string->bytevector "1192fda08fc6f6a932aaf99b9a4bdeb3342e04d16350faa4ea94373eda510429"))))
    (list "github.com/sina-ghaderi/poly1305/@v/v0.0.0-20220724002748-c5926b03988b.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/poly1305/@v/v0.0.0-20220724002748-c5926b03988b.zip")
          (file-name "go-github.com-sina-ghaderi-poly1305-_v-v0.0.0-20220724002748-c5926b03988b.zip")
          (sha256 (base16-string->bytevector "2f318147c0b181ce18942aa5c67a94bddf8bf964c31ef57da4a5bb3369700ed9"))))
    (list "github.com/sina-ghaderi/rabaead/@v/v0.0.0-20220730151906-ab6e06b96e8c.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/rabaead/@v/v0.0.0-20220730151906-ab6e06b96e8c.info")
          (file-name "go-github.com-sina-ghaderi-rabaead-_v-v0.0.0-20220730151906-ab6e06b96e8c.info")
          (sha256 (base16-string->bytevector "42a80ab3785e3ecbd86d45dd28eb72116fa2852ec4fb8ef25e646248a267943f"))))
    (list "github.com/sina-ghaderi/rabaead/@v/v0.0.0-20220730151906-ab6e06b96e8c.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/rabaead/@v/v0.0.0-20220730151906-ab6e06b96e8c.mod")
          (file-name "go-github.com-sina-ghaderi-rabaead-_v-v0.0.0-20220730151906-ab6e06b96e8c.mod")
          (sha256 (base16-string->bytevector "3de30f2283959f2ebc32d772e3ad0a03c98027bbae9af87042b2efdd0bbbc427"))))
    (list "github.com/sina-ghaderi/rabaead/@v/v0.0.0-20220730151906-ab6e06b96e8c.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/rabaead/@v/v0.0.0-20220730151906-ab6e06b96e8c.zip")
          (file-name "go-github.com-sina-ghaderi-rabaead-_v-v0.0.0-20220730151906-ab6e06b96e8c.zip")
          (sha256 (base16-string->bytevector "d5785f695cc1e99449e3355ff460ece1f8d0ff6ab72c6f48eb76d7f8c644f66e"))))
    (list "github.com/sina-ghaderi/rabbitio/@v/v0.0.0-20220730151941-9ce26f4f872e.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/rabbitio/@v/v0.0.0-20220730151941-9ce26f4f872e.info")
          (file-name "go-github.com-sina-ghaderi-rabbitio-_v-v0.0.0-20220730151941-9ce26f4f872e.info")
          (sha256 (base16-string->bytevector "f9003d035077a0184d9d1c0bf71ea53fc58d649862d6b4ff83d1f75ddd6cf05f"))))
    (list "github.com/sina-ghaderi/rabbitio/@v/v0.0.0-20220730151941-9ce26f4f872e.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/rabbitio/@v/v0.0.0-20220730151941-9ce26f4f872e.mod")
          (file-name "go-github.com-sina-ghaderi-rabbitio-_v-v0.0.0-20220730151941-9ce26f4f872e.mod")
          (sha256 (base16-string->bytevector "322e4dbc6943bd78df9fae33f38667bc92409d42260fbb2a9e7a327c28004a43"))))
    (list "github.com/sina-ghaderi/rabbitio/@v/v0.0.0-20220730151941-9ce26f4f872e.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sina-ghaderi/rabbitio/@v/v0.0.0-20220730151941-9ce26f4f872e.zip")
          (file-name "go-github.com-sina-ghaderi-rabbitio-_v-v0.0.0-20220730151941-9ce26f4f872e.zip")
          (sha256 (base16-string->bytevector "702ff9c3964ac8ce8516a52b5e52c6246940cd3ecf1c382b1d12fd76c4c9938c"))))
    (list "github.com/sirupsen/logrus/@v/v1.9.4.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sirupsen/logrus/@v/v1.9.4.info")
          (file-name "go-github.com-sirupsen-logrus-_v-v1.9.4.info")
          (sha256 (base16-string->bytevector "e06eb2267b8acbbd7f32d1401c238bcf73a0b6f60aba69ca6219734b5de63185"))))
    (list "github.com/sirupsen/logrus/@v/v1.9.4.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sirupsen/logrus/@v/v1.9.4.mod")
          (file-name "go-github.com-sirupsen-logrus-_v-v1.9.4.mod")
          (sha256 (base16-string->bytevector "65bd5913b818d483bd0c92041e39a4ec17766f8907318aea02df8658f46324e8"))))
    (list "github.com/sirupsen/logrus/@v/v1.9.4.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/sirupsen/logrus/@v/v1.9.4.zip")
          (file-name "go-github.com-sirupsen-logrus-_v-v1.9.4.zip")
          (sha256 (base16-string->bytevector "3847d00c5ee6948f1ff0d0120bc343c55ce852becb7720f8f08f53eecfe9e437"))))
    (list "github.com/stangelandcl/ppmd/@v/v0.1.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stangelandcl/ppmd/@v/v0.1.1.info")
          (file-name "go-github.com-stangelandcl-ppmd-_v-v0.1.1.info")
          (sha256 (base16-string->bytevector "f2d42435ec6faeaf2c1a2aad89b73c6599ee2700b8dd3901b2e221b4fb7ac17b"))))
    (list "github.com/stangelandcl/ppmd/@v/v0.1.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stangelandcl/ppmd/@v/v0.1.1.mod")
          (file-name "go-github.com-stangelandcl-ppmd-_v-v0.1.1.mod")
          (sha256 (base16-string->bytevector "361fecdf477b4c1cdfcbb417e9b467196ed59b036425f0d84bf4b5c0c6db50ad"))))
    (list "github.com/stangelandcl/ppmd/@v/v0.1.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stangelandcl/ppmd/@v/v0.1.1.zip")
          (file-name "go-github.com-stangelandcl-ppmd-_v-v0.1.1.zip")
          (sha256 (base16-string->bytevector "e832489fca0e2a2455bc76235c9681509b3666b89f154afcd994814929a9081b"))))
    (list "github.com/stretchr/objx/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/objx/@v/v0.1.0.mod")
          (file-name "go-github.com-stretchr-objx-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "1350354d52d2287a62336ecc0d56232d4c47699af9bba49c67c2b48254da98f1"))))
    (list "github.com/stretchr/objx/@v/v0.4.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/objx/@v/v0.4.0.mod")
          (file-name "go-github.com-stretchr-objx-_v-v0.4.0.mod")
          (sha256 (base16-string->bytevector "31b2fdcdee870f0f61bffafafb96220967e5bca08a76a920d574216fc1f91355"))))
    (list "github.com/stretchr/objx/@v/v0.5.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/objx/@v/v0.5.0.mod")
          (file-name "go-github.com-stretchr-objx-_v-v0.5.0.mod")
          (sha256 (base16-string->bytevector "cb326540efcb1274a6e4e970d7fc9de2e8062f08a058fc296d859025e62e807a"))))
    (list "github.com/stretchr/objx/@v/v0.5.2.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/objx/@v/v0.5.2.info")
          (file-name "go-github.com-stretchr-objx-_v-v0.5.2.info")
          (sha256 (base16-string->bytevector "f42110f866bda5a125d228edaec5fe8c05eadf9a381947f40e94b0352498c52e"))))
    (list "github.com/stretchr/objx/@v/v0.5.2.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/objx/@v/v0.5.2.zip")
          (file-name "go-github.com-stretchr-objx-_v-v0.5.2.zip")
          (sha256 (base16-string->bytevector "3c22c1d1c4c4024eb16a12f0187775640bf35d51b0a06649febc7797119451c0"))))
    (list "github.com/stretchr/testify/@v/v1.11.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.11.1.info")
          (file-name "go-github.com-stretchr-testify-_v-v1.11.1.info")
          (sha256 (base16-string->bytevector "7441e645d8c2dfa05c19b8804129ff51c7df268b09de4c44bbcb2bdcfd959888"))))
    (list "github.com/stretchr/testify/@v/v1.11.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.11.1.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.11.1.mod")
          (sha256 (base16-string->bytevector "5846af204043f29df285026109bf32db6519c3d7e1d5c3a65fefb174f9d81d33"))))
    (list "github.com/stretchr/testify/@v/v1.11.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.11.1.zip")
          (file-name "go-github.com-stretchr-testify-_v-v1.11.1.zip")
          (sha256 (base16-string->bytevector "b7325b561ead5304b72b9f32aebc871ff49b3823667d530a49fd6c8f3adfc96e"))))
    (list "github.com/stretchr/testify/@v/v1.3.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.3.0.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.3.0.mod")
          (sha256 (base16-string->bytevector "ab063d5154a8e8730bced4c52698e5770eb50bfae347bebc35eca488b8e3f6e3"))))
    (list "github.com/stretchr/testify/@v/v1.6.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.6.1.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.6.1.mod")
          (sha256 (base16-string->bytevector "fff8168d98e6a07156c454a1b6e925509f3177e96c155516d7f96b4079cca3bf"))))
    (list "github.com/stretchr/testify/@v/v1.7.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.7.0.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.7.0.mod")
          (sha256 (base16-string->bytevector "fff8168d98e6a07156c454a1b6e925509f3177e96c155516d7f96b4079cca3bf"))))
    (list "github.com/stretchr/testify/@v/v1.7.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.7.1.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.7.1.mod")
          (sha256 (base16-string->bytevector "fff8168d98e6a07156c454a1b6e925509f3177e96c155516d7f96b4079cca3bf"))))
    (list "github.com/stretchr/testify/@v/v1.8.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.8.0.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.8.0.mod")
          (sha256 (base16-string->bytevector "e076074c1560ad1dda98b8b00fea6308c4b6ccd06ddd088d22db4626ed68f738"))))
    (list "github.com/stretchr/testify/@v/v1.8.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/stretchr/testify/@v/v1.8.1.mod")
          (file-name "go-github.com-stretchr-testify-_v-v1.8.1.mod")
          (sha256 (base16-string->bytevector "af1a5dcb331ace7a3f9fc1b5d7eee9c0bc82b4a2a182fe4cec2add217e2853d6"))))
    (list "github.com/tailscale/certstore/@v/v0.1.1-0.20260409135935-3638fb84b77d.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/certstore/@v/v0.1.1-0.20260409135935-3638fb84b77d.info")
          (file-name "go-github.com-tailscale-certstore-_v-v0.1.1-0.20260409135935-3638fb84b77d.info")
          (sha256 (base16-string->bytevector "403964fce6a1de7dd994557298d8466469b165e4f786f63ef701ad0590b0ca67"))))
    (list "github.com/tailscale/certstore/@v/v0.1.1-0.20260409135935-3638fb84b77d.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/certstore/@v/v0.1.1-0.20260409135935-3638fb84b77d.mod")
          (file-name "go-github.com-tailscale-certstore-_v-v0.1.1-0.20260409135935-3638fb84b77d.mod")
          (sha256 (base16-string->bytevector "1f781c8aa9d260e9b57e0c5ed96e559e30c32a0baa759ff54374e8d9cc9c0b07"))))
    (list "github.com/tailscale/certstore/@v/v0.1.1-0.20260409135935-3638fb84b77d.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/certstore/@v/v0.1.1-0.20260409135935-3638fb84b77d.zip")
          (file-name "go-github.com-tailscale-certstore-_v-v0.1.1-0.20260409135935-3638fb84b77d.zip")
          (sha256 (base16-string->bytevector "28121a4e30fe7a4d4b566366d6923cdc69afc7f0b3485e94400581d0e1cf4826"))))
    (list "github.com/tailscale/go-winio/@v/v0.0.0-20231025203758-c4f33415bf55.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/go-winio/@v/v0.0.0-20231025203758-c4f33415bf55.info")
          (file-name "go-github.com-tailscale-go-winio-_v-v0.0.0-20231025203758-c4f33415bf55.info")
          (sha256 (base16-string->bytevector "8e7bcb2da9611deba8b0d31cc79f434785ad3f04a3d0941dfd5025b74ecb644b"))))
    (list "github.com/tailscale/go-winio/@v/v0.0.0-20231025203758-c4f33415bf55.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/go-winio/@v/v0.0.0-20231025203758-c4f33415bf55.mod")
          (file-name "go-github.com-tailscale-go-winio-_v-v0.0.0-20231025203758-c4f33415bf55.mod")
          (sha256 (base16-string->bytevector "59b8af0e2c194f529160ee1c95242811281d7e9bfe60e20a446d9d1b3061354b"))))
    (list "github.com/tailscale/go-winio/@v/v0.0.0-20231025203758-c4f33415bf55.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/go-winio/@v/v0.0.0-20231025203758-c4f33415bf55.zip")
          (file-name "go-github.com-tailscale-go-winio-_v-v0.0.0-20231025203758-c4f33415bf55.zip")
          (sha256 (base16-string->bytevector "0433037071e067ec3cc0600db97a31b2296b852ade8688b4aad990f7ecbd1a37"))))
    (list "github.com/tailscale/hujson/@v/v0.0.0-20221223112325-20486734a56a.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/hujson/@v/v0.0.0-20221223112325-20486734a56a.info")
          (file-name "go-github.com-tailscale-hujson-_v-v0.0.0-20221223112325-20486734a56a.info")
          (sha256 (base16-string->bytevector "b1fe4fbc10808758e649a3f9f7496d479291e14ab25f0c92d3a3ff3660503293"))))
    (list "github.com/tailscale/hujson/@v/v0.0.0-20221223112325-20486734a56a.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/hujson/@v/v0.0.0-20221223112325-20486734a56a.mod")
          (file-name "go-github.com-tailscale-hujson-_v-v0.0.0-20221223112325-20486734a56a.mod")
          (sha256 (base16-string->bytevector "2f88563ee5f4c64fdcc73703897437f0da0f34fb5d3f75d57642474080f4ae89"))))
    (list "github.com/tailscale/hujson/@v/v0.0.0-20221223112325-20486734a56a.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/hujson/@v/v0.0.0-20221223112325-20486734a56a.zip")
          (file-name "go-github.com-tailscale-hujson-_v-v0.0.0-20221223112325-20486734a56a.zip")
          (sha256 (base16-string->bytevector "8e65bacebfc0a1edc067fd97f839fcfeb93c1e7b8cc0186d1773cff4e125d9d5"))))
    (list "github.com/tailscale/peercred/@v/v0.0.0-20250107143737-35a0c7bd7edc.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/peercred/@v/v0.0.0-20250107143737-35a0c7bd7edc.info")
          (file-name "go-github.com-tailscale-peercred-_v-v0.0.0-20250107143737-35a0c7bd7edc.info")
          (sha256 (base16-string->bytevector "c1d5571be27e6d47f148ab4f54ed16024bc796dcd6d3765e83176e0295d92d75"))))
    (list "github.com/tailscale/peercred/@v/v0.0.0-20250107143737-35a0c7bd7edc.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/peercred/@v/v0.0.0-20250107143737-35a0c7bd7edc.mod")
          (file-name "go-github.com-tailscale-peercred-_v-v0.0.0-20250107143737-35a0c7bd7edc.mod")
          (sha256 (base16-string->bytevector "01f3d17cce127160210b43d5edada3fa84ac705f7ed1147f8fe4efdf765eb95b"))))
    (list "github.com/tailscale/peercred/@v/v0.0.0-20250107143737-35a0c7bd7edc.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/tailscale/peercred/@v/v0.0.0-20250107143737-35a0c7bd7edc.zip")
          (file-name "go-github.com-tailscale-peercred-_v-v0.0.0-20250107143737-35a0c7bd7edc.zip")
          (sha256 (base16-string->bytevector "87d0f4f3b1d59ea45c9a87b775b615bebd721a5870dafedc63cc860ec4aac281"))))
    (list "github.com/u-root/uio/@v/v0.0.0-20230220225925-ffce2a382923.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/u-root/uio/@v/v0.0.0-20230220225925-ffce2a382923.info")
          (file-name "go-github.com-u-root-uio-_v-v0.0.0-20230220225925-ffce2a382923.info")
          (sha256 (base16-string->bytevector "522d12abb060674138e333442423b18e879f2318168d3a8f358db841285aa772"))))
    (list "github.com/u-root/uio/@v/v0.0.0-20230220225925-ffce2a382923.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/u-root/uio/@v/v0.0.0-20230220225925-ffce2a382923.mod")
          (file-name "go-github.com-u-root-uio-_v-v0.0.0-20230220225925-ffce2a382923.mod")
          (sha256 (base16-string->bytevector "e75dd44144deaa541e2fb75476db54facd19a1dcbe293a225a7454b9d0b0065a"))))
    (list "github.com/u-root/uio/@v/v0.0.0-20230220225925-ffce2a382923.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/u-root/uio/@v/v0.0.0-20230220225925-ffce2a382923.zip")
          (file-name "go-github.com-u-root-uio-_v-v0.0.0-20230220225925-ffce2a382923.zip")
          (sha256 (base16-string->bytevector "663715655a8e46662f75e9156b7e4175beefb70caae61e934cfb6fb849dfd1ee"))))
    (list "github.com/ulikunitz/xz/@v/v0.5.15.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ulikunitz/xz/@v/v0.5.15.info")
          (file-name "go-github.com-ulikunitz-xz-_v-v0.5.15.info")
          (sha256 (base16-string->bytevector "4e5be621ec758a1d98145a6ef6142aff18dba7758d8247c5efb982c63d5b4e69"))))
    (list "github.com/ulikunitz/xz/@v/v0.5.15.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ulikunitz/xz/@v/v0.5.15.mod")
          (file-name "go-github.com-ulikunitz-xz-_v-v0.5.15.mod")
          (sha256 (base16-string->bytevector "393876046d63d90f35f21c1bb4651b0985e76d8f14a48a7279ff947b96956e7b"))))
    (list "github.com/ulikunitz/xz/@v/v0.5.15.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/ulikunitz/xz/@v/v0.5.15.zip")
          (file-name "go-github.com-ulikunitz-xz-_v-v0.5.15.zip")
          (sha256 (base16-string->bytevector "ca1830f9abc6c99a003ad28f2b145ea0af0c99d5769ddff08d23ce055959fd12"))))
    (list "github.com/vishvananda/netlink/@v/v1.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vishvananda/netlink/@v/v1.1.0.mod")
          (file-name "go-github.com-vishvananda-netlink-_v-v1.1.0.mod")
          (sha256 (base16-string->bytevector "716c699d2ab6fbc9798c24fd30890882b9c10f32328252e1bb0fd2e6b075094c"))))
    (list "github.com/vishvananda/netns/@v/v0.0.0-20191106174202-0a2b9b5464df.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vishvananda/netns/@v/v0.0.0-20191106174202-0a2b9b5464df.mod")
          (file-name "go-github.com-vishvananda-netns-_v-v0.0.0-20191106174202-0a2b9b5464df.mod")
          (sha256 (base16-string->bytevector "664feef4ab06864bf1b0e32acfb3f1f3cf93069c2fd03d2534a622e87e663fdb"))))
    (list "github.com/vishvananda/netns/@v/v0.0.0-20210104183010-2eb08e3e575f.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vishvananda/netns/@v/v0.0.0-20210104183010-2eb08e3e575f.mod")
          (file-name "go-github.com-vishvananda-netns-_v-v0.0.0-20210104183010-2eb08e3e575f.mod")
          (sha256 (base16-string->bytevector "f4789a9fcf2e402616afc906fd239a92d46e4a6e00181cd3435f1c910aafe624"))))
    (list "github.com/vishvananda/netns/@v/v0.0.5.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vishvananda/netns/@v/v0.0.5.info")
          (file-name "go-github.com-vishvananda-netns-_v-v0.0.5.info")
          (sha256 (base16-string->bytevector "3ab38817c94017b33f0b411bc44b1f38803047ac048a6fe8709264ef619930bc"))))
    (list "github.com/vishvananda/netns/@v/v0.0.5.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vishvananda/netns/@v/v0.0.5.mod")
          (file-name "go-github.com-vishvananda-netns-_v-v0.0.5.mod")
          (sha256 (base16-string->bytevector "de8a0c0518c7841b4f04762ee7367c4ff1953381082e066793fa1c93e93883c2"))))
    (list "github.com/vishvananda/netns/@v/v0.0.5.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vishvananda/netns/@v/v0.0.5.zip")
          (file-name "go-github.com-vishvananda-netns-_v-v0.0.5.zip")
          (sha256 (base16-string->bytevector "07804b88c922c2a6780efe392ffef9d126eac584384eb3eb17bcadd34cfa9422"))))
    (list "github.com/vmihailenco/msgpack/v5/@v/v5.4.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vmihailenco/msgpack/v5/@v/v5.4.1.info")
          (file-name "go-github.com-vmihailenco-msgpack-v5-_v-v5.4.1.info")
          (sha256 (base16-string->bytevector "3715d76398d48744d4d3618ce5032dfad99ca21d41a0d8dfddf68b212733a6e4"))))
    (list "github.com/vmihailenco/msgpack/v5/@v/v5.4.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vmihailenco/msgpack/v5/@v/v5.4.1.mod")
          (file-name "go-github.com-vmihailenco-msgpack-v5-_v-v5.4.1.mod")
          (sha256 (base16-string->bytevector "78123be71349515b283280cac807dff2b8e84798a86501341a1b2cae6e3663dc"))))
    (list "github.com/vmihailenco/msgpack/v5/@v/v5.4.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vmihailenco/msgpack/v5/@v/v5.4.1.zip")
          (file-name "go-github.com-vmihailenco-msgpack-v5-_v-v5.4.1.zip")
          (sha256 (base16-string->bytevector "f966b8091c59efce1b44e265097f239be5d4174a827be0a5debebae09517d2b8"))))
    (list "github.com/vmihailenco/tagparser/v2/@v/v2.0.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vmihailenco/tagparser/v2/@v/v2.0.0.info")
          (file-name "go-github.com-vmihailenco-tagparser-v2-_v-v2.0.0.info")
          (sha256 (base16-string->bytevector "a3d1a1f463613cc44198725f771a41953f1d9f4584f89628c1d46ce502100030"))))
    (list "github.com/vmihailenco/tagparser/v2/@v/v2.0.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vmihailenco/tagparser/v2/@v/v2.0.0.mod")
          (file-name "go-github.com-vmihailenco-tagparser-v2-_v-v2.0.0.mod")
          (sha256 (base16-string->bytevector "421006040b7c0c6e4e4257ec9f69a85fb0d6120f5a526b5ef174d6cd34ce4f34"))))
    (list "github.com/vmihailenco/tagparser/v2/@v/v2.0.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/vmihailenco/tagparser/v2/@v/v2.0.0.zip")
          (file-name "go-github.com-vmihailenco-tagparser-v2-_v-v2.0.0.zip")
          (sha256 (base16-string->bytevector "70096ead331b4ac4efc0bf740674cbe55772beee6eace39507a610c5652aa8b5"))))
    (list "github.com/x448/float16/@v/v0.8.4.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/x448/float16/@v/v0.8.4.info")
          (file-name "go-github.com-x448-float16-_v-v0.8.4.info")
          (sha256 (base16-string->bytevector "06f9483061813e32210ae41f092abb82609a062ac7dff685be18290c7c65c132"))))
    (list "github.com/x448/float16/@v/v0.8.4.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/x448/float16/@v/v0.8.4.mod")
          (file-name "go-github.com-x448-float16-_v-v0.8.4.mod")
          (sha256 (base16-string->bytevector "f8a8238aa734c1d2463d48f8808e35124546bd5222b13e4c097746ded5a57e1e"))))
    (list "github.com/x448/float16/@v/v0.8.4.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/x448/float16/@v/v0.8.4.zip")
          (file-name "go-github.com-x448-float16-_v-v0.8.4.zip")
          (sha256 (base16-string->bytevector "73b24a41037ea999ab66851e3798a0973dbb1f214925915b01f0820f7b2f1500"))))
    (list "github.com/xtaci/lossyconn/@v/v0.0.0-20190602105132-8df528c0c9ae.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/xtaci/lossyconn/@v/v0.0.0-20190602105132-8df528c0c9ae.info")
          (file-name "go-github.com-xtaci-lossyconn-_v-v0.0.0-20190602105132-8df528c0c9ae.info")
          (sha256 (base16-string->bytevector "30e274dea05cd56f55fcc5da746be120c45f0e58c37d0689e29f213f139d3db3"))))
    (list "github.com/xtaci/lossyconn/@v/v0.0.0-20190602105132-8df528c0c9ae.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/xtaci/lossyconn/@v/v0.0.0-20190602105132-8df528c0c9ae.zip")
          (file-name "go-github.com-xtaci-lossyconn-_v-v0.0.0-20190602105132-8df528c0c9ae.zip")
          (sha256 (base16-string->bytevector "75cc8c3e14cf812dcc56a1e8cecafd8affd9b2843d39540ab67929f7ce3d1abc"))))
    (list "github.com/xyproto/randomstring/@v/v1.0.5.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/xyproto/randomstring/@v/v1.0.5.info")
          (file-name "go-github.com-xyproto-randomstring-_v-v1.0.5.info")
          (sha256 (base16-string->bytevector "b72e898b857c7ae5f4ab2ed187b6f398c05381ba3e9d90e66a7144472035ae5f"))))
    (list "github.com/xyproto/randomstring/@v/v1.0.5.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/xyproto/randomstring/@v/v1.0.5.mod")
          (file-name "go-github.com-xyproto-randomstring-_v-v1.0.5.mod")
          (sha256 (base16-string->bytevector "a7d51dd77422d16f9cf46888d7ce14a3e8f11a7c3c7f024916f50c065805fc8a"))))
    (list "github.com/xyproto/randomstring/@v/v1.0.5.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/xyproto/randomstring/@v/v1.0.5.zip")
          (file-name "go-github.com-xyproto-randomstring-_v-v1.0.5.zip")
          (sha256 (base16-string->bytevector "58ea0c70496fc698c4597625395b3f35321df09be013ee880a6ce10e94969261"))))
    (list "github.com/yosida95/uritemplate/v3/@v/v3.0.2.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/yosida95/uritemplate/v3/@v/v3.0.2.info")
          (file-name "go-github.com-yosida95-uritemplate-v3-_v-v3.0.2.info")
          (sha256 (base16-string->bytevector "9bc0a5eb8ecde4082962ef5a3c0d045f393c7b9d70ea54f6d14f942714089842"))))
    (list "github.com/yosida95/uritemplate/v3/@v/v3.0.2.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/yosida95/uritemplate/v3/@v/v3.0.2.mod")
          (file-name "go-github.com-yosida95-uritemplate-v3-_v-v3.0.2.mod")
          (sha256 (base16-string->bytevector "69ed795569c71e422d2d21ca310bce1ebe181effe139fdc8a134fa3acd6c478a"))))
    (list "github.com/yosida95/uritemplate/v3/@v/v3.0.2.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/github.com/yosida95/uritemplate/v3/@v/v3.0.2.zip")
          (file-name "go-github.com-yosida95-uritemplate-v3-_v-v3.0.2.zip")
          (sha256 (base16-string->bytevector "65a29b6ab759cd30a1ed496a8a77b144a5683b89d505cfde51f907cb7ab9b8bd"))))
    (list "gitlab.com/go-extension/aes-ccm/@v/v0.0.0-20230221065045-e58665ef23c7.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gitlab.com/go-extension/aes-ccm/@v/v0.0.0-20230221065045-e58665ef23c7.info")
          (file-name "go-gitlab.com-go-extension-aes-ccm-_v-v0.0.0-20230221065045-e58665ef23c7.info")
          (sha256 (base16-string->bytevector "4648571a92057d75482c50175959c030641055db04c2e551b503a5f45bccc9bb"))))
    (list "gitlab.com/go-extension/aes-ccm/@v/v0.0.0-20230221065045-e58665ef23c7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gitlab.com/go-extension/aes-ccm/@v/v0.0.0-20230221065045-e58665ef23c7.mod")
          (file-name "go-gitlab.com-go-extension-aes-ccm-_v-v0.0.0-20230221065045-e58665ef23c7.mod")
          (sha256 (base16-string->bytevector "ee789694de3bab4c62fb2f6f1b886ce37b15b7a78fc52c09eedd46f1b26024b3"))))
    (list "gitlab.com/go-extension/aes-ccm/@v/v0.0.0-20230221065045-e58665ef23c7.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gitlab.com/go-extension/aes-ccm/@v/v0.0.0-20230221065045-e58665ef23c7.zip")
          (file-name "go-gitlab.com-go-extension-aes-ccm-_v-v0.0.0-20230221065045-e58665ef23c7.zip")
          (sha256 (base16-string->bytevector "49edefa08eb14c488b9cd08eab4067c6aa43f59fad8ca1995af3ae40b176bdfe"))))
    (list "gitlab.com/yawning/bsaes.git/@v/v0.0.0-20190805113838-0a714cd429ec.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gitlab.com/yawning/bsaes.git/@v/v0.0.0-20190805113838-0a714cd429ec.info")
          (file-name "go-gitlab.com-yawning-bsaes.git-_v-v0.0.0-20190805113838-0a714cd429ec.info")
          (sha256 (base16-string->bytevector "5d0e3de3ef444f4db62db8a3150f8f2df355564e991a064b83511b5d3530e40c"))))
    (list "gitlab.com/yawning/bsaes.git/@v/v0.0.0-20190805113838-0a714cd429ec.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gitlab.com/yawning/bsaes.git/@v/v0.0.0-20190805113838-0a714cd429ec.mod")
          (file-name "go-gitlab.com-yawning-bsaes.git-_v-v0.0.0-20190805113838-0a714cd429ec.mod")
          (sha256 (base16-string->bytevector "07628c256178c8fbfb57d41ae5a7d91f9ef0bed32926e9ebb1335730768fdb98"))))
    (list "gitlab.com/yawning/bsaes.git/@v/v0.0.0-20190805113838-0a714cd429ec.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gitlab.com/yawning/bsaes.git/@v/v0.0.0-20190805113838-0a714cd429ec.zip")
          (file-name "go-gitlab.com-yawning-bsaes.git-_v-v0.0.0-20190805113838-0a714cd429ec.zip")
          (sha256 (base16-string->bytevector "f619d6e47a42fbaddf6c1e688085c3016b756f7f3219e595b079d7017a121cea"))))
    (list "go.uber.org/automaxprocs/@v/v1.6.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go.uber.org/automaxprocs/@v/v1.6.0.info")
          (file-name "go-go.uber.org-automaxprocs-_v-v1.6.0.info")
          (sha256 (base16-string->bytevector "cbd13ac75355b2a9df916d2ca390e3715046e98db2feb9a01afd845edb15bb4e"))))
    (list "go.uber.org/automaxprocs/@v/v1.6.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go.uber.org/automaxprocs/@v/v1.6.0.mod")
          (file-name "go-go.uber.org-automaxprocs-_v-v1.6.0.mod")
          (sha256 (base16-string->bytevector "2e6d1ecf4cb29eb86182548f4690c991056ab15f18c127efaef2d0239f5fc10d"))))
    (list "go.uber.org/automaxprocs/@v/v1.6.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go.uber.org/automaxprocs/@v/v1.6.0.zip")
          (file-name "go-go.uber.org-automaxprocs-_v-v1.6.0.zip")
          (sha256 (base16-string->bytevector "964c6f548f7ee6df9fa3a9080d722c7950060bda0cb84ff9e2ae065f078813c4"))))
    (list "go.uber.org/mock/@v/v0.4.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go.uber.org/mock/@v/v0.4.0.info")
          (file-name "go-go.uber.org-mock-_v-v0.4.0.info")
          (sha256 (base16-string->bytevector "ab3578d996bf5ee6eafd46ea28815b575fc7a29e56617a9ceaedfa3ee57943d6"))))
    (list "go.uber.org/mock/@v/v0.4.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go.uber.org/mock/@v/v0.4.0.zip")
          (file-name "go-go.uber.org-mock-_v-v0.4.0.zip")
          (sha256 (base16-string->bytevector "29c088ba1621e04fba8670e388e962f92c15f47cd45a63bf0e5decd6d5d63cd1"))))
    (list "go4.org/mem/@v/v0.0.0-20240501181205-ae6ca9944745.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go4.org/mem/@v/v0.0.0-20240501181205-ae6ca9944745.info")
          (file-name "go-go4.org-mem-_v-v0.0.0-20240501181205-ae6ca9944745.info")
          (sha256 (base16-string->bytevector "ab26f568cb97a70a42ce9efc2767e44a406e6365efb019274d804051a49fe7bf"))))
    (list "go4.org/mem/@v/v0.0.0-20240501181205-ae6ca9944745.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go4.org/mem/@v/v0.0.0-20240501181205-ae6ca9944745.mod")
          (file-name "go-go4.org-mem-_v-v0.0.0-20240501181205-ae6ca9944745.mod")
          (sha256 (base16-string->bytevector "4caf98eb924c6539689fe4851b2acdff647b72ed38f95faad5442ea0c6efd105"))))
    (list "go4.org/mem/@v/v0.0.0-20240501181205-ae6ca9944745.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go4.org/mem/@v/v0.0.0-20240501181205-ae6ca9944745.zip")
          (file-name "go-go4.org-mem-_v-v0.0.0-20240501181205-ae6ca9944745.zip")
          (sha256 (base16-string->bytevector "9b5037a57122457fdc5c2c0a31e3996b44cf9dfcdee5c53ed72adfd88d077795"))))
    (list "go4.org/netipx/@v/v0.0.0-20231129151722-fdeea329fbba.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go4.org/netipx/@v/v0.0.0-20231129151722-fdeea329fbba.info")
          (file-name "go-go4.org-netipx-_v-v0.0.0-20231129151722-fdeea329fbba.info")
          (sha256 (base16-string->bytevector "b2df55e564ad2d96f0216bc6722b7fdcd4d053325174662defe1367287a571ff"))))
    (list "go4.org/netipx/@v/v0.0.0-20231129151722-fdeea329fbba.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go4.org/netipx/@v/v0.0.0-20231129151722-fdeea329fbba.mod")
          (file-name "go-go4.org-netipx-_v-v0.0.0-20231129151722-fdeea329fbba.mod")
          (sha256 (base16-string->bytevector "567ffe55c30a5346e382d4e54ef8a82a80704c9a3979e30bb66309a9a244a70b"))))
    (list "go4.org/netipx/@v/v0.0.0-20231129151722-fdeea329fbba.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/go4.org/netipx/@v/v0.0.0-20231129151722-fdeea329fbba.zip")
          (file-name "go-go4.org-netipx-_v-v0.0.0-20231129151722-fdeea329fbba.zip")
          (sha256 (base16-string->bytevector "e15f57de368c92b826010181906f26112ba3a0d7fde7d94c8a8c60c525dc4044"))))
    (list "golang.org/x/crypto/@v/v0.0.0-20190308221718-c2843e01d9a2.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/crypto/@v/v0.0.0-20190308221718-c2843e01d9a2.mod")
          (file-name "go-golang.org-x-crypto-_v-v0.0.0-20190308221718-c2843e01d9a2.mod")
          (sha256 (base16-string->bytevector "33ed070a5a66e0960685ac5386440e1b59899e74d8a38a1180685e72a2195ded"))))
    (list "golang.org/x/crypto/@v/v0.0.0-20191011191535-87dc89f01550.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/crypto/@v/v0.0.0-20191011191535-87dc89f01550.mod")
          (file-name "go-golang.org-x-crypto-_v-v0.0.0-20191011191535-87dc89f01550.mod")
          (sha256 (base16-string->bytevector "3ab9f01f4610fe7b39bd85d68e8d97825351e7e282c39cda41457c2a276f3be3"))))
    (list "golang.org/x/crypto/@v/v0.33.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/crypto/@v/v0.33.0.info")
          (file-name "go-golang.org-x-crypto-_v-v0.33.0.info")
          (sha256 (base16-string->bytevector "4a09998cee119842fbeedbfd76b502a387e6e766a21a5a08b3a18edbd3c3dc9b"))))
    (list "golang.org/x/crypto/@v/v0.33.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/crypto/@v/v0.33.0.mod")
          (file-name "go-golang.org-x-crypto-_v-v0.33.0.mod")
          (sha256 (base16-string->bytevector "f6dad481462711b0c41f147aa175087f3656591c59336242fdc9fae95d0fc59e"))))
    (list "golang.org/x/crypto/@v/v0.33.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/crypto/@v/v0.33.0.zip")
          (file-name "go-golang.org-x-crypto-_v-v0.33.0.zip")
          (sha256 (base16-string->bytevector "3b0c19c1d259e93464f540165470de872721e5fc66ce3f0d36ffd27d307ec5bb"))))
    (list "golang.org/x/exp/@v/v0.0.0-20240904232852-e7e105dedf7e.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/exp/@v/v0.0.0-20240904232852-e7e105dedf7e.info")
          (file-name "go-golang.org-x-exp-_v-v0.0.0-20240904232852-e7e105dedf7e.info")
          (sha256 (base16-string->bytevector "4e90ed84cab573ff80aa6bbe51b0451c7fa2b206c601e281e9fc17bff1a36c80"))))
    (list "golang.org/x/exp/@v/v0.0.0-20240904232852-e7e105dedf7e.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/exp/@v/v0.0.0-20240904232852-e7e105dedf7e.mod")
          (file-name "go-golang.org-x-exp-_v-v0.0.0-20240904232852-e7e105dedf7e.mod")
          (sha256 (base16-string->bytevector "c2f10b4a9e167b79dd32cb33ce506021b6c7421ca0c6aaefb746ea30d8e9c4db"))))
    (list "golang.org/x/exp/@v/v0.0.0-20240904232852-e7e105dedf7e.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/exp/@v/v0.0.0-20240904232852-e7e105dedf7e.zip")
          (file-name "go-golang.org-x-exp-_v-v0.0.0-20240904232852-e7e105dedf7e.zip")
          (sha256 (base16-string->bytevector "f9837e3d39cfcd0167b1c18efd5b9771a651cfd3e3c1cdba468c0373be1d49ac"))))
    (list "golang.org/x/lint/@v/v0.0.0-20200302205851-738671d3881b.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/lint/@v/v0.0.0-20200302205851-738671d3881b.mod")
          (file-name "go-golang.org-x-lint-_v-v0.0.0-20200302205851-738671d3881b.mod")
          (sha256 (base16-string->bytevector "4be743c2c22d63cc685d604114b0ab9312ab1f1c35266441e503317b78b7cf50"))))
    (list "golang.org/x/mod/@v/v0.1.1-0.20191105210325-c90efee705ee.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/mod/@v/v0.1.1-0.20191105210325-c90efee705ee.mod")
          (file-name "go-golang.org-x-mod-_v-v0.1.1-0.20191105210325-c90efee705ee.mod")
          (sha256 (base16-string->bytevector "d76bbdea81d196d09858967a67ac805dacecdd1fb30c5001a187d24c129b1597"))))
    (list "golang.org/x/mod/@v/v0.20.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/mod/@v/v0.20.0.info")
          (file-name "go-golang.org-x-mod-_v-v0.20.0.info")
          (sha256 (base16-string->bytevector "9a5f5d9413c8ca4c49b42232862095cb6aea35571fcdab52b99b58734de1e21d"))))
    (list "golang.org/x/mod/@v/v0.20.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/mod/@v/v0.20.0.mod")
          (file-name "go-golang.org-x-mod-_v-v0.20.0.mod")
          (sha256 (base16-string->bytevector "5c4ac0310a25330757039ccf3a98e75fefdbcb7d444ddd049230003a44945bde"))))
    (list "golang.org/x/mod/@v/v0.20.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/mod/@v/v0.20.0.zip")
          (file-name "go-golang.org-x-mod-_v-v0.20.0.zip")
          (sha256 (base16-string->bytevector "3c3528c39639b7cd699c121c100ddb71ab49f94bff257a4a3935e3ae9e8571fc"))))
    (list "golang.org/x/net/@v/v0.0.0-20190404232315-eb5bcb51f2a3.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/net/@v/v0.0.0-20190404232315-eb5bcb51f2a3.mod")
          (file-name "go-golang.org-x-net-_v-v0.0.0-20190404232315-eb5bcb51f2a3.mod")
          (sha256 (base16-string->bytevector "f7046769daac02beb57cbcc481280df59fb403c96fe8262282aba858c7f7fa4d"))))
    (list "golang.org/x/net/@v/v0.0.0-20190620200207-3b0461eec859.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/net/@v/v0.0.0-20190620200207-3b0461eec859.mod")
          (file-name "go-golang.org-x-net-_v-v0.0.0-20190620200207-3b0461eec859.mod")
          (sha256 (base16-string->bytevector "e6efdaf78a29503f080cf6d2615e289cfb1d9e3ab7d570f53668eca2b4ab41da"))))
    (list "golang.org/x/net/@v/v0.35.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/net/@v/v0.35.0.info")
          (file-name "go-golang.org-x-net-_v-v0.35.0.info")
          (sha256 (base16-string->bytevector "70b819ede04b2d4283d721f2b2be5d57bca3571dd351e96767784644a5d97801"))))
    (list "golang.org/x/net/@v/v0.35.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/net/@v/v0.35.0.mod")
          (file-name "go-golang.org-x-net-_v-v0.35.0.mod")
          (sha256 (base16-string->bytevector "3d0e854f04bd4c18e2a2cb499b17e11d919b09d90be105b92283608e1f1aeb79"))))
    (list "golang.org/x/net/@v/v0.35.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/net/@v/v0.35.0.zip")
          (file-name "go-golang.org-x-net-_v-v0.35.0.zip")
          (sha256 (base16-string->bytevector "9c746c215d695e80d6f4d1b1f1d55deaae5e451b4c031223af25f2b2f0757215"))))
    (list "golang.org/x/sync/@v/v0.0.0-20190423024810-112230192c58.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sync/@v/v0.0.0-20190423024810-112230192c58.mod")
          (file-name "go-golang.org-x-sync-_v-v0.0.0-20190423024810-112230192c58.mod")
          (sha256 (base16-string->bytevector "421f6139686d5891f3dc5a563d0995780d3279f65cad4d225cea52686794161c"))))
    (list "golang.org/x/sync/@v/v0.11.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sync/@v/v0.11.0.info")
          (file-name "go-golang.org-x-sync-_v-v0.11.0.info")
          (sha256 (base16-string->bytevector "8d9c2bb4938738ec33a730b7e9ee0bc6e8879e71c8095dd5a2a7d7947284c77c"))))
    (list "golang.org/x/sync/@v/v0.11.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sync/@v/v0.11.0.mod")
          (file-name "go-golang.org-x-sync-_v-v0.11.0.mod")
          (sha256 (base16-string->bytevector "700e5db00dd26aa19a17dce5fc552436d60f68c5606c85b821f24c3d6072a151"))))
    (list "golang.org/x/sync/@v/v0.11.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sync/@v/v0.11.0.zip")
          (file-name "go-golang.org-x-sync-_v-v0.11.0.zip")
          (sha256 (base16-string->bytevector "0906a8026217a4e31c30ea5fc2514f18fc13480c62fe6bfae7a57e7ce0313de9"))))
    (list "golang.org/x/sys/@v/v0.0.0-20190215142949-d0b11bdaac8a.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.0.0-20190215142949-d0b11bdaac8a.mod")
          (file-name "go-golang.org-x-sys-_v-v0.0.0-20190215142949-d0b11bdaac8a.mod")
          (sha256 (base16-string->bytevector "8969115e4a39108848324e79a1bd8a8445230e6e3aaccbe9f8057fb50fffc8c1"))))
    (list "golang.org/x/sys/@v/v0.0.0-20190412213103-97732733099d.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.0.0-20190412213103-97732733099d.mod")
          (file-name "go-golang.org-x-sys-_v-v0.0.0-20190412213103-97732733099d.mod")
          (sha256 (base16-string->bytevector "181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343"))))
    (list "golang.org/x/sys/@v/v0.0.0-20190606203320-7fc4e5ec1444.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.0.0-20190606203320-7fc4e5ec1444.mod")
          (file-name "go-golang.org-x-sys-_v-v0.0.0-20190606203320-7fc4e5ec1444.mod")
          (sha256 (base16-string->bytevector "181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343"))))
    (list "golang.org/x/sys/@v/v0.0.0-20190804053845-51ab0e2deafa.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.0.0-20190804053845-51ab0e2deafa.mod")
          (file-name "go-golang.org-x-sys-_v-v0.0.0-20190804053845-51ab0e2deafa.mod")
          (sha256 (base16-string->bytevector "181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343"))))
    (list "golang.org/x/sys/@v/v0.0.0-20200217220822-9197077df867.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.0.0-20200217220822-9197077df867.mod")
          (file-name "go-golang.org-x-sys-_v-v0.0.0-20200217220822-9197077df867.mod")
          (sha256 (base16-string->bytevector "181979e8bd57d2d9e064182da86c9a6111aa69755e888f08431ece4742aec343"))))
    (list "golang.org/x/sys/@v/v0.0.0-20220622161953-175b2fd9d664.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.0.0-20220622161953-175b2fd9d664.mod")
          (file-name "go-golang.org-x-sys-_v-v0.0.0-20220622161953-175b2fd9d664.mod")
          (sha256 (base16-string->bytevector "f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024"))))
    (list "golang.org/x/sys/@v/v0.1.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.1.0.mod")
          (file-name "go-golang.org-x-sys-_v-v0.1.0.mod")
          (sha256 (base16-string->bytevector "f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024"))))
    (list "golang.org/x/sys/@v/v0.30.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.30.0.info")
          (file-name "go-golang.org-x-sys-_v-v0.30.0.info")
          (sha256 (base16-string->bytevector "84390f25474ba3bd408d615ac8af1a20a46ef9f69d2acc7b3e8d79f97f3a063c"))))
    (list "golang.org/x/sys/@v/v0.30.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.30.0.mod")
          (file-name "go-golang.org-x-sys-_v-v0.30.0.mod")
          (sha256 (base16-string->bytevector "d227b325f621f4ebe28d39ba773ea99b870f393b7c09c34592c365b16dd560de"))))
    (list "golang.org/x/sys/@v/v0.30.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.30.0.zip")
          (file-name "go-golang.org-x-sys-_v-v0.30.0.zip")
          (sha256 (base16-string->bytevector "f5214bfec98f00e5432da68bbece03e98600fa41594ed026556cbde8fcb6f7c9"))))
    (list "golang.org/x/sys/@v/v0.5.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.5.0.mod")
          (file-name "go-golang.org-x-sys-_v-v0.5.0.mod")
          (sha256 (base16-string->bytevector "f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024"))))
    (list "golang.org/x/sys/@v/v0.6.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/sys/@v/v0.6.0.mod")
          (file-name "go-golang.org-x-sys-_v-v0.6.0.mod")
          (sha256 (base16-string->bytevector "f033333096fe198f3151deed93f2deba74e50bbfe7739134045bc3b7ce4a5024"))))
    (list "golang.org/x/term/@v/v0.29.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/term/@v/v0.29.0.info")
          (file-name "go-golang.org-x-term-_v-v0.29.0.info")
          (sha256 (base16-string->bytevector "582a553c237cfae955c76d34fb3b8d5896df56dfd517dd33afc45fe2e2313673"))))
    (list "golang.org/x/term/@v/v0.29.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/term/@v/v0.29.0.mod")
          (file-name "go-golang.org-x-term-_v-v0.29.0.mod")
          (sha256 (base16-string->bytevector "d9fe2c313121a1a0f1ea8028e6c4bfbd8afbd8f34e67eacfd2d1d37964a4c89d"))))
    (list "golang.org/x/term/@v/v0.29.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/term/@v/v0.29.0.zip")
          (file-name "go-golang.org-x-term-_v-v0.29.0.zip")
          (sha256 (base16-string->bytevector "9d92c583d222113ac653848b3319ff559d2dba92f8232baff03d08fc9c0b8619"))))
    (list "golang.org/x/text/@v/v0.22.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/text/@v/v0.22.0.info")
          (file-name "go-golang.org-x-text-_v-v0.22.0.info")
          (sha256 (base16-string->bytevector "838456e0bbe524e8eb973b807a393625d579575161f9bd63046f3ff36ea7d739"))))
    (list "golang.org/x/text/@v/v0.22.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/text/@v/v0.22.0.mod")
          (file-name "go-golang.org-x-text-_v-v0.22.0.mod")
          (sha256 (base16-string->bytevector "b26a1f71dc41b9992bafec38867987652d1293d046c652df549eed687149d862"))))
    (list "golang.org/x/text/@v/v0.22.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/text/@v/v0.22.0.zip")
          (file-name "go-golang.org-x-text-_v-v0.22.0.zip")
          (sha256 (base16-string->bytevector "939cb4c202aa8fa302f2ba6f9d29165ce82fce9c665d9a1a0bb0d9e51b79e6f5"))))
    (list "golang.org/x/text/@v/v0.3.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/text/@v/v0.3.0.mod")
          (file-name "go-golang.org-x-text-_v-v0.3.0.mod")
          (sha256 (base16-string->bytevector "36879d586fd8001e84da8787190a11e4f78749e2a81dfe8b9b6931899fff31cf"))))
    (list "golang.org/x/time/@v/v0.10.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/time/@v/v0.10.0.info")
          (file-name "go-golang.org-x-time-_v-v0.10.0.info")
          (sha256 (base16-string->bytevector "b2f00ad6396d5b6514a3e4136bc24c715fd2944327f5bc50811630d0466c46d6"))))
    (list "golang.org/x/time/@v/v0.10.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/time/@v/v0.10.0.mod")
          (file-name "go-golang.org-x-time-_v-v0.10.0.mod")
          (sha256 (base16-string->bytevector "226a6cc982bae02ff1e168de8c3e45a2f3f986c69edbc1f416c58b6081ef262e"))))
    (list "golang.org/x/time/@v/v0.10.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/time/@v/v0.10.0.zip")
          (file-name "go-golang.org-x-time-_v-v0.10.0.zip")
          (sha256 (base16-string->bytevector "7420a12017bb47bd85ccab81f9d1f7a3ff6daf8da768256292bc1dbb3bf9ba63"))))
    (list "golang.org/x/tools/@v/v0.0.0-20200130002326-2f3ba24bd6e7.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/tools/@v/v0.0.0-20200130002326-2f3ba24bd6e7.mod")
          (file-name "go-golang.org-x-tools-_v-v0.0.0-20200130002326-2f3ba24bd6e7.mod")
          (sha256 (base16-string->bytevector "5ea469c803b6ef8d41d1561b9e301a003fdd93976468bda5574b26b056ea7f49"))))
    (list "golang.org/x/tools/@v/v0.24.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/tools/@v/v0.24.0.info")
          (file-name "go-golang.org-x-tools-_v-v0.24.0.info")
          (sha256 (base16-string->bytevector "11094eb6aa0ddd4552e8e860b02aefe51710275e15c0d2d535620690d94d65d7"))))
    (list "golang.org/x/tools/@v/v0.24.0.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/tools/@v/v0.24.0.mod")
          (file-name "go-golang.org-x-tools-_v-v0.24.0.mod")
          (sha256 (base16-string->bytevector "82819e438fe12dba2ae05162302d3ce19cc5351f00a887ad22628b125345d989"))))
    (list "golang.org/x/tools/@v/v0.24.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/tools/@v/v0.24.0.zip")
          (file-name "go-golang.org-x-tools-_v-v0.24.0.zip")
          (sha256 (base16-string->bytevector "92607be1cacf4647fd31b19ee64b1a7c198178f1005c75371e38e7b08fb138e7"))))
    (list "golang.org/x/xerrors/@v/v0.0.0-20191011141410-1b5146add898.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/golang.org/x/xerrors/@v/v0.0.0-20191011141410-1b5146add898.mod")
          (file-name "go-golang.org-x-xerrors-_v-v0.0.0-20191011141410-1b5146add898.mod")
          (sha256 (base16-string->bytevector "aa5e3ec9bb7b9f681609efac019d9de1a7ba7719248ff1eaa27e78882db3d7f5"))))
    (list "gopkg.in/check.v1/@v/v0.0.0-20161208181325-20d25e280405.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/check.v1/@v/v0.0.0-20161208181325-20d25e280405.mod")
          (file-name "go-gopkg.in-check.v1-_v-v0.0.0-20161208181325-20d25e280405.mod")
          (sha256 (base16-string->bytevector "5c306e0d633cd66a11b40e2e5fbbc6da42110db7d72ea3c1524ceb45ee40c33f"))))
    (list "gopkg.in/check.v1/@v/v1.0.0-20180628173108-788fd7840127.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/check.v1/@v/v1.0.0-20180628173108-788fd7840127.info")
          (file-name "go-gopkg.in-check.v1-_v-v1.0.0-20180628173108-788fd7840127.info")
          (sha256 (base16-string->bytevector "a28f46faaa09e1ec0d57d46627f94291a7842c699c7d084cba4161d79c3b55e7"))))
    (list "gopkg.in/check.v1/@v/v1.0.0-20180628173108-788fd7840127.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/check.v1/@v/v1.0.0-20180628173108-788fd7840127.zip")
          (file-name "go-gopkg.in-check.v1-_v-v1.0.0-20180628173108-788fd7840127.zip")
          (sha256 (base16-string->bytevector "4bc535ed2aac48a231af8b6005a0b5f6069dadab9a3d65b1e9f1fe91c74d8e61"))))
    (list "gopkg.in/yaml.v3/@v/v3.0.0-20200313102051-9f266ea9e77c.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/yaml.v3/@v/v3.0.0-20200313102051-9f266ea9e77c.mod")
          (file-name "go-gopkg.in-yaml.v3-_v-v3.0.0-20200313102051-9f266ea9e77c.mod")
          (sha256 (base16-string->bytevector "21579860a20306fcf43b1bd234d1fba319499c77611b71c05f9bf3ba90dab939"))))
    (list "gopkg.in/yaml.v3/@v/v3.0.1.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/yaml.v3/@v/v3.0.1.info")
          (file-name "go-gopkg.in-yaml.v3-_v-v3.0.1.info")
          (sha256 (base16-string->bytevector "0cdb0c9ac8c3b25dbd420a86ab27debfa469a8b48ee10560224704c2852ac6c0"))))
    (list "gopkg.in/yaml.v3/@v/v3.0.1.mod"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/yaml.v3/@v/v3.0.1.mod")
          (file-name "go-gopkg.in-yaml.v3-_v-v3.0.1.mod")
          (sha256 (base16-string->bytevector "21579860a20306fcf43b1bd234d1fba319499c77611b71c05f9bf3ba90dab939"))))
    (list "gopkg.in/yaml.v3/@v/v3.0.1.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/gopkg.in/yaml.v3/@v/v3.0.1.zip")
          (file-name "go-gopkg.in-yaml.v3-_v-v3.0.1.zip")
          (sha256 (base16-string->bytevector "aab8fbc4e6300ea08e6afe1caea18a21c90c79f489f52c53e2f20431f1a9a015"))))
    (list "software.sslmate.com/src/go-pkcs12/@v/v0.4.0.info"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/software.sslmate.com/src/go-pkcs12/@v/v0.4.0.info")
          (file-name "go-software.sslmate.com-src-go-pkcs12-_v-v0.4.0.info")
          (sha256 (base16-string->bytevector "5521317c1d2f7041d27ad7e9b67001b63f9af2795dfa3e553ee8748cff55b8a2"))))
    (list "software.sslmate.com/src/go-pkcs12/@v/v0.4.0.zip"
      (origin
          (method url-fetch)
          (uri "https://proxy.golang.org/software.sslmate.com/src/go-pkcs12/@v/v0.4.0.zip")
          (file-name "go-software.sslmate.com-src-go-pkcs12-_v-v0.4.0.zip")
          (sha256 (base16-string->bytevector "55019a391e5302a51ba62e98909e006224b81207866da90beaf582ec0dee036f"))))
    ))
