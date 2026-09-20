;;; ghostty —— 快速、原生、GPU 加速的终端模拟器（ghostty-org/ghostty）
;;;
;;; 为什么这个包这么长：ghostty 用 Zig 包管理器（build.zig.zon）管理依赖，
;;; 除了纯 Zig 库（libxev/vaxis/z2d/uucode/zig_wayland/gobject ...）之外，
;;; 连 freetype/harfbuzz/fontconfig/libpng/zlib/oniguruma/glslang/spirv-cross/
;;; simdutf/highway 这些 C 库也是通过 zon 拉源码自己编译（静态链接）的，
;;; 而且还有递归依赖（pkg/*/build.zig.zon）。Guix 构建沙箱没有网络，
;;; 所以这里把上游 build.zig.zon.json 里列出的所有 artifact 都声明成
;;; fixed-output origin（native-inputs），构建前用
;;;
;;;   zig fetch --global-cache-dir /tmp/zig-cache <artifact.tar.gz>
;;;
;;; 把它们塞进 Zig 的全局包缓存 p/<hash>/；随后 `zig build` 按 build.zig.zon
;;; 里的 .hash 命中缓存，全程离线。
;;; （等价于 Nix 的 nix/package.nix 里 `--system <linkFarm-of-hashes>` 的做法。）
;;;
;;; 系统库里只有 gtk4/libadwaita/gtk4-layer-shell/wayland/X11 是真的动态链接，
;;; 其余 C 库都走 zig 缓存里的自带源码。Guix 的 zig 打了
;;; zig-0.15-fix-runpath.patch：链接时会把 LIBRARY_PATH 里命中的动态库目录
;;; 写进 RUNPATH，所以运行时能找到 gtk4 等，validate-runpath 也能过。
;;;
;;; 本机验证（2026-09-20）：
;;;   guix build -L ~/cchanl ghostty
;;;   → /gnu/store/zvz6qinwl8af3wwwjjpa4q0wgjjxm856-ghostty-1.3.1
;;;     （bin/ghostty --version 输出 1.3.1，validate-runpath 通过）
;;;
;;; 踩过的坑：
;;;   * native-inputs 里只要有一个带标签的元组，后面所有包都得写标签
;;;     （Guix 的 maybe-add-input-labels 只看第一个元素，见下面注释）。
;;;   * tic（来自 ncurses）必须有：安装 ghostty 时会用 tic 把 terminfo 源码
;;;     编成二进制 terminfo 数据库。
;;;   * pandoc 必须有：zig 在非 system-package 模式下，只要 PATH 里有 pandoc
;;;     就默认生成 man page / html 文档。
;;;   * vaxis 自己的 build.zig.zon 里用 git+https 引了 uucode 的一个 commit，
;;;     所以除了 tarball 清单，还得额外塞一个 git-fetch 的 artifact
;;;     （见下面的 %%zig-git-artifacts）。
;;;
;;; 升级版本时要做的事：
;;;   1. 改 %ghostty-version 和 source 的 commit/hash
;;;      （hash 用：guix hash -x -S nar <git checkout>）；
;;;   2. 重新生成下面的 %%zig-artifacts：上游仓库里的 build.zig.zon.json 是
;;;      官方生成的 artifact 清单（name/url/sha256-base64），把 base64 转成
;;;      Guix 的 base32 填进来即可；另外看一眼清单里有没有 git+ 开头的
;;;      （有就照 %%zig-git-artifacts 的写法补一条，哈希可以从上游
;;;      build.zig.zon.nix 里的 sha256-base64 转换，或直接
;;;      guix hash -x -S nar <checkout>）。

(define-module (ch0r0ng packages ghostty)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system zig)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages regex)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages zig))

(define %ghostty-version "1.3.1")

;;; ghostty build.zig.zon（含 pkg/*/build.zig.zon 的递归依赖）里所有需要
;;; 联网下载的 artifact：(名字 url sha256)，sha256 是 Guix base32。
;;; 名字只用于 native-inputs 的 key，随意；真正的匹配靠 Zig 的内容哈希。
(define %zig-artifacts
  '(
    ;; zig hash: N-V-__8AANT61wB--nJ95Gj_ctmzAtcjloZ__hRqNw5lC1Kr
    ("bindings" "https://deps.files.ghostty.org/DearBindings_v0.17_ImGui_v1.92.5-docking.tar.gz"
     "18xsf0zisr9q8xqa8g3kh4qkqb9rrikkvqiyhmwzc9h9w00cbzlb")
    ;; zig hash: N-V-__8AALw2uwF_03u4JRkZwRLc3Y9hakkYV7NKRR9-RIZJ
    ("breakpad" "https://deps.files.ghostty.org/breakpad-b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz"
     "1nbadlml3r982bz1wyp17w33hngzkb07f47nrrk0g68s7na9ijkc")
    ;; zig hash: N-V-__8AAIrfdwARSa-zMmxWwFuwpXf1T3asIN7s5jqi9c1v
    ("fontconfig" "https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz"
     "0mcarq6v9k7k9a8is23vq9as0niv0hbagwdabknaq6472n9dv8iv")
    ;; zig hash: N-V-__8AAKLKpwC4H27Ps_0iL3bPkQb-z6ZVSrB-x_3EEkub
    ("freetype" "https://deps.files.ghostty.org/freetype-1220b81f6ecfb3fd222f76cf9106fecfa6554ab07ec7fdc4124b9bb063ae2adf969d.tar.gz"
     "035r5bypzapa1x7za7lpvpkz58fxynz4anqzbk8705hmspsh2wj2")
    ;; zig hash: N-V-__8AADcZkgn4cMhTUpIz6mShCKyqqB-NBtf_S2bHaTC-
    ("gettext" "https://deps.files.ghostty.org/gettext-0.24.tar.gz"
     "1dqq2ln01mfwr4gblvy0cyvarbqnv09ml5sdhksdlw1xb4ym0669")
    ;; zig hash: N-V-__8AABzkUgISeKGgXAzgtutgJsZc0-kkeqBBscJgMkvy
    ("glslang" "https://deps.files.ghostty.org/glslang-12201278a1a05c0ce0b6eb6026c65cd3e9247aa041b1c260324bf29cee559dd23ba1.tar.gz"
     "1dcpm70fhxk07vk37f5l0hb9gxfv6pjgbqskk8dfbcwwa2xyv8hl")
    ;; zig hash: gobject-0.3.0-Skun7ANLnwDvEfIpVmohcppXgOvg_I6YOJFmPIsKfXk-
    ("gobject" "https://deps.files.ghostty.org/gobject-2025-11-08-23-1.tar.zst"
     "0j0csvsyvp0193mpkdp25s14kargppmdyslbhi5qw788y0347gfr")
    ;; zig hash: N-V-__8AALiNBAA-_0gprYr92CjrMj1I5bqNu0TSJOnjFNSr
    ("gtk4_layer_shell" "https://deps.files.ghostty.org/gtk4-layer-shell-1.1.0.tar.gz"
     "12396gx723ybgq1xp9i02257hsmzqhb5z9b39xdyypha4s0l4a4q")
    ;; zig hash: N-V-__8AAG02ugUcWec-Ndp-i7JTsJ0dgF8nnJRUInkGLG7G
    ("harfbuzz" "https://deps.files.ghostty.org/harfbuzz-11.0.0.tar.xz"
     "16rb7aazy36pj3xrjy149dd90j9yv7q5jnqx5kz2air1zsx52qzi")
    ;; zig hash: N-V-__8AAGmZhABbsPJLfbqrh6JTHsXhY6qCaLAQyx25e0XE
    ("highway" "https://deps.files.ghostty.org/highway-66486a10623fa0d72fe91260f96c892e41aceb06.tar.gz"
     "04m21b46h6c4x099r9qb720ql9llpzz8yq3k94i8zq7l7s4zim47")
    ;; zig hash: N-V-__8AAEbOfQBnvcFcCX2W5z7tDaN8vaNZGamEQtNOe0UI
    ("imgui" "https://github.com/ocornut/imgui/archive/refs/tags/v1.92.5-docking.tar.gz"
     "1jzr65gpx4mqfcdbnf2rm2kd20jmj9whwdb7x1df3wvmih7c45n8")
    ;; zig hash: N-V-__8AABVbAwBwDRyZONfx553tvMW8_A2OKUoLzPUSRiLF
    ("iterm2_themes" "https://deps.files.ghostty.org/ghostty-themes-release-20260216-151611-fc73ce3.tgz"
     "1zd81af7hjnyfq3dypl3xg9bd5mkh2r01m89jsv4m08cdaw0n80l")
    ;; zig hash: N-V-__8AAIC5lwAVPJJzxnCAahSvZTIlG-HhtOvnM1uh-66x
    ("jetbrains_mono" "https://deps.files.ghostty.org/JetBrainsMono-2.304.tar.gz"
     "1i2w213919avi0apgbw720wqy0z46a89bwv3b65hkbc2icg6jyn5")
    ;; zig hash: N-V-__8AAJrvXQCqAT8Mg9o_tk6m0yf5Fz-gCNEOKLyTSerD
    ("libpng" "https://deps.files.ghostty.org/libpng-1220aa013f0c83da3fb64ea6d327f9173fa008d10e28bc9349eac3463457723b1c66.tar.gz"
     "0fm0y7543w2gx5sz3zg9i46x1am51c77a554r0zqwpphdjs9bk7y")
    ;; zig hash: libxev-0.0.0-86vtc4IcEwCqEYxEYoN_3KXmc6A9VLcm22aVImfvecYs
    ("libxev" "https://deps.files.ghostty.org/libxev-34fa50878aec6e5fa8f532867001ab3c36fae23e.tar.gz"
     "1mvx91wn7499xfx76fxijq4x66x1g5yk4cpr52hii9g4jrmyl0v0")
    ;; zig hash: N-V-__8AAG3RoQEyRC2Vw7Qoro5SYBf62IHn3HjqtNVY6aWK
    ("libxml2" "https://deps.files.ghostty.org/libxml2-2.11.5.tar.gz"
     "05b2kbccbkb5pkizwx2s170lcqvaj7iqjr5injsl5sry5sg0aa3c")
    ;; zig hash: N-V-__8AAMVLTABmYkLqhZPLXnMl-KyN38R8UVYqGrxqO26s
    ("nerd_fonts_symbols_only" "https://deps.files.ghostty.org/NerdFontsSymbolsOnly-3.4.0.tar.gz"
     "010d7gkv359qg555d89i4hhgb56c8f69kw5jsx4f5gflaswx2r0i")
    ;; zig hash: N-V-__8AAHjwMQDBXnLq3Q2QhaivE0kE2aD138vtX2Bq1g7c
    ("oniguruma" "https://deps.files.ghostty.org/oniguruma-1220c15e72eadd0d9085a8af134904d9a0f5dfcbed5f606ad60edc60ebeccd9706bb.tar.gz"
     "187jk4fxdkzc0wrcx4kdy4v6p1snwmv8r97i1d68yi3q5qha26h0")
    ;; zig hash: N-V-__8AADYiAAB_80AWnH1AxXC0tql9thT-R-DYO1gBqTLc
    ("pixels" "https://deps.files.ghostty.org/pixels-12207ff340169c7d40c570b4b6a97db614fe47e0d83b5801a932dcd44917424c8806.tar.gz"
     "06pi3f3lhyxfzczhwrc2b4n0jhhzydbz96qlpw12a24is0b3ps2m")
    ;; zig hash: N-V-__8AAKYZBAB-CFHBKs3u4JkeiT4BMvyHu3Y5aaWF3Bbs
    ("plasma_wayland_protocols" "https://deps.files.ghostty.org/plasma_wayland_protocols-12207e0851c12acdeee0991e893e0132fc87bb763969a585dc16ecca33e88334c566.tar.gz"
     "0hgl1p173pxs50z1p6mjjzcqssn44aq0ip166k56p3nd98hvln2w")
    ;; zig hash: N-V-__8AAPlZGwBEa-gxrcypGBZ2R8Bse4JYSfo_ul8i2jlG
    ("sentry" "https://deps.files.ghostty.org/sentry-1220446be831adcca918167647c06c7b825849fa3fba5f22da394667974537a9c77e.tar.gz"
     "1pqqqcin8nw398rvn187dfqlab4vikdssiry14qqs6nnr1y4kiia")
    ;; zig hash: N-V-__8AANb6pwD7O1WG6L5nvD_rNMvnSc9Cpg1ijSlTYywv
    ("spirv_cross" "https://deps.files.ghostty.org/spirv_cross-1220fb3b5586e8be67bc3feb34cbe749cf42a60d628d2953632c2f8141302748c8da.tar.gz"
     "1qspcsx56v0mddarb6f05i748wsl2ln3d8863ydsczsyqk7nyaxm")
    ;; zig hash: N-V-__8AAHffAgDU0YQmynL8K35WzkcnMUmBVQHQ0jlcKpjH
    ("utfcpp" "https://deps.files.ghostty.org/utfcpp-1220d4d18426ca72fc2b7e56ce47273149815501d0d2395c2a98c726b31ba931e641.tar.gz"
     "1ksrdf7dy4csazhddi64xahks8jzf4r8phgkjg9hfxp722iniipz")
    ;; zig hash: uucode-0.2.0-ZZjBPqZVVABQepOqZHR7vV_NcaN-wats0IB6o-Exj6m9
    ("uucode" "https://deps.files.ghostty.org/uucode-0.2.0-ZZjBPqZVVABQepOqZHR7vV_NcaN-wats0IB6o-Exj6m9.tar.gz"
     "15az8qzp0rg5qj8ma0dam9j8jbf4wwb7wxsiq3iymmlb9w7yxayh")
    ;; zig hash: vaxis-0.5.1-BWNV_LosCQAGmCCNOLljCIw6j6-yt53tji6n6rwJ2BhS
    ("vaxis" "https://deps.files.ghostty.org/vaxis-7dbb9fd3122e4ffad262dd7c151d80d863b68558.tar.gz"
     "1xlf12dlzda0z4d3svq0qibvfgqzkrv4igg6qqg58nwwr0mk6wif")
    ;; zig hash: N-V-__8AAKrHGAAs2shYq8UkE6bGcR1QJtLTyOE_lcosMn6t
    ("wayland" "https://deps.files.ghostty.org/wayland-9cb3d7aa9dc995ffafdbdef7ab86a949d0fb0e7d.tar.gz"
     "03f574n5w0y6glr7lf8xjd71844qh8kxxb1s3zjpfxj3ivb92hga")
    ;; zig hash: N-V-__8AAKw-DAAaV8bOAAGqA0-oD7o-HNIlPFYKRXSPT03S
    ("wayland_protocols" "https://deps.files.ghostty.org/wayland-protocols-258d8f88f2c8c25a830c6316f87d23ce1a0f12d9.tar.gz"
     "1y1h0pmql53x6ixbsycgkzxlxsxqs9fkps754c7ycx8vx3fwmvaw")
    ;; zig hash: N-V-__8AAAzZywE3s51XfsLbP9eyEw57ae9swYB9aGB6fCMs
    ("wuffs" "https://deps.files.ghostty.org/wuffs-122037b39d577ec2db3fd7b2130e7b69ef6cc1807d68607a7c232c958315d381b5cd.tar.gz"
     "04qwpr8c4xjla4skwb1fpvkjc0c611qhbhz9xp3c9rlnpq5d4k4y")
    ;; zig hash: z2d-0.10.0-j5P_Hu-6FgBsZNgwphIqh17jDnj8_yPtD8yzjO6PpHRQ
    ("z2d" "https://deps.files.ghostty.org/z2d-0.10.0-j5P_Hu-6FgBsZNgwphIqh17jDnj8_yPtD8yzjO6PpHRQ.tar.gz"
     "1xwpcw2awxf2r1kz27m0j4pzpi5g92gd1i2mzqvhkvnmxyi1vwk9")
    ;; zig hash: zf-0.10.3-OIRy8RuJAACKA3Lohoumrt85nRbHwbpMcUaLES8vxDnh
    ("zf" "https://deps.files.ghostty.org/zf-3c52637b7e937c5ae61fd679717da3e276765b23.tar.gz"
     "0s25gjvp7rns1l52jvgbd7aakndlvfs5xh9b4wk9wkphia95s09v")
    ;; zig hash: zig_js-0.0.0-rjCAV-6GAADxFug7rDmPH-uM_XcnJ5NmuAMJCAscMjhi
    ("zig_js" "https://deps.files.ghostty.org/zig_js-04db83c617da1956ac5adc1cb9ba1e434c1cb6fd.tar.gz"
     "18vkzib7xgvk4g1xk18070w3yfg9kjnqc0q9p029blqmc3jih82c")
    ;; zig hash: zig_objc-0.0.0-Ir_Sp5gTAQCvxxR7oVIrPXxXwsfKgVP7_wqoOQrZjFeK
    ("zig_objc" "https://deps.files.ghostty.org/zig_objc-f356ed02833f0f1b8e84d50bed9e807bf7cdc0ae.tar.gz"
     "1k4fq05brsm799qpkxbwcq1dgs5jyc4hkcrcfb6nyd95frrsz16x")
    ;; zig hash: wayland-0.5.0-dev-lQa1khrMAQDJDwYFKpdH3HizherB7sHo5dKMECfvxQHe
    ("zig_wayland" "https://deps.files.ghostty.org/zig_wayland-1b5c038ec10da20ed3a15b0b2a6db1c21383e8ea.tar.gz"
     "0khjg5q1z1d4sgnyhfjqzb8c6wizx79p3gz343sjgmfhbrrnn52g")
    ;; zig hash: zigimg-0.1.0-8_eo2vHnEwCIVW34Q14Ec-xUlzIoVg86-7FU2ypPtxms
    ("zigimg" "https://github.com/ivanstepanovftw/zigimg/archive/d7b7ab0ba0899643831ef042bd73289510b39906.tar.gz"
     "0ly53dd3pj8hl3kkf3h8x4dw79yb7riwj9qc9da18mdkl9mxf7ic")
    ;; zig hash: N-V-__8AAB0eQwD-0MdOEBmz7intriBReIsIDNlukNVoNu6o
    ("zlib" "https://deps.files.ghostty.org/zlib-1220fed0c74e1019b3ee29edae2051788b080cd96e90d56836eea857b0b966742efb.tar.gz"
     "0p6h2i9ajdp46lckdpibfqy4vz5nh5r22bqq96mp41k0ydiqis0p")
    ))

(define (zig-artifact-input-name artifact)
  (string-append "zig-dep-" (car artifact)))

(define (zig-artifact-input artifact)
  (list (zig-artifact-input-name artifact)
        (origin
          (method url-fetch)
          (uri (cadr artifact))
          (sha256 (base32 (caddr artifact))))))

;;; 例外：vaxis 自己的 build.zig.zon 里用 git+https 引用了 uucode 的某个
;;; commit（不是上面那张表里的 uucode-0.2.0 tarball），Zig 会按内容哈希
;;; 去缓存里找，所以这里也必须把它塞进缓存。做法和 Nix 的 zon2nix 一样：
;;; 先 git-fetch 出目录，再 zig fetch 这个目录。
(define %zig-git-artifacts
  '(;; (名字 仓库 提交 哈希)
    ("uucode-git" "https://github.com/jacobsandlund/uucode"
     "5f05f8f83a75caea201f12cc8ea32a2d82ea9732"
     "1zrdyhnqs0v46qasxb2kwd7694j8r8z6w4zlnfp42x8j6kwy2wxh")))

(define (zig-git-artifact-input-name artifact)
  (string-append "zig-dep-" (car artifact)))

(define (zig-git-artifact-input artifact)
  (list (zig-git-artifact-input-name artifact)
        (origin
          (method git-fetch)
          (uri (git-reference
                (url (cadr artifact))
                (commit (caddr artifact))))
          (sha256 (base32 (cadddr artifact))))))

(define-public ghostty
  (package
    (name "ghostty")
    (version %ghostty-version)
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/ghostty-org/ghostty")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0d064l17drqcf6bc27jmjxak0n2xqp2mpalakwp3j9mx8yclrmzr"))))
    (build-system zig-build-system)
    (arguments
     (list #:zig zig-0.15
           ;; 源码树太大，不复制进 out/src/zig。
           #:install-source? #f
           ;; 上游自己也不跑测试（`zig build test` 要编译一整套测试二进制）。
           #:tests? #f
           ;; Guix 的 zig-build-system 默认会加 -Dtarget=<platform target>，
           ;; 这里叠加 -Dcpu=baseline 保证可复现（否则会用构建机 CPU 特性）。
           #:zig-build-flags
           #~(list "-Doptimize=ReleaseFast"
                   (string-append "-Dversion-string=" #$%ghostty-version)
                   "-Dgtk-x11=true"
                   "-Dgtk-wayland=true"
                   "-Dcpu=baseline"
                   "-Dstrip=true"
                   "-Dpie=true")
           #:phases
           #~(modify-phases %standard-phases
               ;; Guix 自带的 unpack-dependencies 依赖 input 名字和 zon 里的
               ;; key 一致，ghostty 有几十个依赖、名字还互不相同，所以关掉它，
               ;; 换成下面这个按内容哈希填缓存的版本。
               (delete 'unpack-dependencies)
               (add-after 'configure 'populate-zig-cache
                 (lambda* (#:key inputs #:allow-other-keys)
                   (let ((cache "/tmp/zig-cache"))
                     (mkdir-p cache)
                     (setenv "ZIG_GLOBAL_CACHE_DIR" cache)
                     (setenv "ZIG_LOCAL_CACHE_DIR" cache)
                     (for-each
                      (lambda (name)
                        (let ((artifact (assoc-ref inputs name)))
                          (unless artifact
                            (error "missing ghostty zig artifact" name))
                          (format #t "zig fetch ~a~%" artifact)
                          (invoke "zig" "fetch"
                                  "--global-cache-dir" cache
                                  artifact)))
                      '#$(append (map zig-artifact-input-name %zig-artifacts)
                                 (map zig-git-artifact-input-name
                                      %zig-git-artifacts))))))
               ;; 上游的 desktop / dbus / systemd / .pc 文件里的路径是按
               ;; ${prefix} 生成的，而 Guix 的 zig-build-system 用
               ;; "--prefix "" + DESTDIR"，于是这些文件里出现的是
               ;; "/bin/ghostty"（.pc 里的 prefix= 干脆是空的）。这里改回
               ;; 绝对 store 路径，否则桌面项 / DBus 激活都起不来。
               (add-after 'install 'fix-embedded-prefix
                 (lambda _
                   (define (files-in dir pattern)
                     (if (file-exists? dir) (find-files dir pattern) '()))
                   (let ((bin (string-append #$output "/bin/ghostty")))
                     (for-each
                      (lambda (file)
                        (substitute* file
                          (("=/bin/ghostty") (string-append "=" bin))))
                      (append
                       (files-in (string-append #$output "/share/applications")
                                 "desktop")
                       (files-in (string-append #$output "/share/dbus-1/services")
                                 ".")
                       (files-in (string-append #$output "/share/systemd/user")
                                 ".")))
                     (for-each
                      (lambda (file)
                        (substitute* file
                          (("^prefix=") (string-append "prefix=" #$output))))
                      (files-in (string-append #$output "/share/pkgconfig")
                                "ghostty"))))))))
    (native-inputs
     (append (map zig-artifact-input %zig-artifacts)
             (map zig-git-artifact-input %zig-git-artifacts)
             ;; 注意：这张表里已经混了 "名字 + origin" 的带标签元组，而 Guix 的
             ;; maybe-add-input-labels 只看第一个元素：第一个元素带标签时就假定
             ;; 整张表都带标签，所以后面的包也必须显式写标签，不能写裸包。
             `(("pkg-config" ,pkg-config)
               ("glib" ,glib "bin")                  ;glib-compile-resources
               ("blueprint-compiler" ,blueprint-compiler) ;.blp -> .ui，要求 >= 0.16
               ("libxml2" ,libxml2)                    ;xmllint
               ("gettext" ,gettext-minimal)            ;msgfmt（i18n，glibc 上默认开）
               ("ncurses" ,ncurses)                     ;tic（把 ghostty 的 terminfo 编成二进制）
               ("pandoc" ,pandoc))))                   ;man page / html 文档
    ;; 注意：本版 Guix 里 "gtk" 就是 GTK4（gtk+ 才是 GTK3），没有 gtk4 变量。
    (inputs (list gtk
                  libadwaita
                  ;; ghostty 默认用系统 gtk4-layer-shell（vendored 版只给
                  ;; 没有该库的平台兜底）
                  gtk4-layer-shell
                  wayland
                  libx11
                  libxkbcommon
                  zlib
                  bzip2
                  libpng
                  expat
                  fontconfig
                  freetype
                  harfbuzz
                  oniguruma))
    ;; GTK 应用运行时需要 GSettings schema（深色模式等）。
    (propagated-inputs (list gsettings-desktop-schemas))
    (home-page "https://ghostty.org")
    (synopsis "Fast, feature-rich, GPU-accelerated terminal emulator")
    (description
     "Ghostty is a terminal emulator that differentiates itself by being
fast, feature-rich, and native.  While there are many excellent terminal
emulators, Ghostty stands out by providing:
@itemize
@item Multi-window, tabbing and split support with native platform UI.
@item GPU-accelerated rendering with a Kitty graphics protocol extension.
@item A large set of built-in themes and shell integration scripts.
@item Platform-native UI on Linux (GTK4/libadwaita) and macOS.
@end itemize
This package builds the GTK4 application together with the @code{libghostty}
library.  All Zig dependencies are fetched into the Zig package cache at build
time so that the build itself stays offline.")
    (license license:expat)))
