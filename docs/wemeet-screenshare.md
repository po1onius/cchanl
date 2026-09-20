# 腾讯会议（wemeet）在 niri + Wayland 下共享屏幕：有效措施总结

环境：Guix System、niri（主线构建，见 `niri-git`）、Intel i915（8086:7D67，Meteor Lake/Xe）、
4K 显示器（scale 1.8，物理 3840x2160 / 逻辑 2133x1200）、腾讯会议 3.26.10.401（官方 .deb）。

结论：最终能用 = **5 处改动，缺一不可**。前 4 处在 wemeet 侧，第 5 处在 niri 侧
（用 `niri-git`，即直接编译 niri main）。

---

## 1. wrapper 里 `WEMEET_XWAYLAND=1`（wemeet 侧，最关键）

`libscreen_share_module.so` 的 `IsUseXDGDesktopPortal()`（源码 util.cc）反汇编出来只有一句：

```c
return (getenv("WEMEET_XWAYLAND") ?: "") == "1";
```

**只有等于 `"1"`** 才走 XDG Desktop Portal 抓屏；否则退回 X11 抓屏。而 Wayland 会话里
X11 根窗口是空的（niri 的 xwayland-satellite 是 rootless），于是共享时选择框里预览是蓝块、
开始共享后对端整块绿色。变量名的语义是"本进程跑在 XWayland 下，X11 根窗口没意义，
请改用 portal"。

* 落地：`build/wemeet.scm`，生成的 `bin/wemeet` 里 `export WEMEET_XWAYLAND="1"`。
* 注意：`WEMEET_XWAYLAND=`（空值）或 unset 都是**反的**，只会走 X11。

## 2. LD_LIBRARY_PATH 里 mesa 必须排在 libglvnd 之前（wemeet 侧）

`libxcast.so` 初始化 EGL 时如果拿到的是 libglvnd 的 `libEGL.so.1`，那只是 dispatcher，
它要读 `/usr/share/glvnd/egl_vendor.d/*.json`（Guix 上不存在），于是
`eglGetDisplay` 报 `300c`(EGL_BAD_PARAMETER) → `xcast start failed(-1)` →
弹 5021「会议发生异常」，连快速会议都进不去。

* 落地：`packages/wemeet.scm` 的 `inputs` 里 `mesa` 写在 `libglvnd` 前面
  （顺序决定 wrapper 里 LD_LIBRARY_PATH 的先后）。

## 3. LD_LIBRARY_PATH 里要有 pipewire（wemeet 侧）

模块用 `dlopen("libpipewire-0.3.so.0")` 拿 PipeWire stream。

* 落地：`packages/wemeet.scm` 的 `inputs` 里加 `pipewire`。

## 4. shim：`libwemeet-portal-format-fix.so`（wemeet 侧）

模块传给 `pw_stream_connect` 的 EnumFormat 过滤器是**空的**（实测解析结果
`format=0 modifier=0x0 size=0x0 framerate=0/0`），与源的 offer 求交集必然为空，
niri 报 `res=-32 no more input formats`，一帧都协商不出来 → 对端黑屏。

shim 在 `dlsym` 处把 `pw_stream_connect` / `pw_stream_update_params` 换成自己的包装，
提供 4 个合法候选（**顺序有意义**）：

| 顺序 | 格式 | 用途 |
|---|---|---|
| 1 | `BGRx`，不带 modifier | 首选。PipeWire 约定"没有 VideoModifier ⇒ 只能共享内存"，配合 niri main 的 SHM 回退 |
| 2 | `BGRA`，不带 modifier | 同上（窗口采集时源端带 alpha） |
| 3 | `BGRx` + `Modifier::Invalid` | 兼容只有 DMA-BUF 的合成器 |
| 4 | `BGRA` + `Modifier::Invalid` | 同上 |

* 落地：`packages/wemeet-shims/wemeet-portal-format-fix.c`，由 `packages/wemeet.scm`
  的 `wemeet-shims` 编译安装，wrapper 里 LD_PRELOAD。

## 5. niri 侧：`niri-git`（直接编译 niri main）

做完 1–4，portal 链路已经全通（`CreateSession`/`SelectSources`/`Start` 都成功，
niri 进入 `Streaming`），但对端**仍然全黑**。原因是：

1. niri 26.04 的采集只 offer DMA-BUF（`SPA_PARAM_BUFFERS_dataType` 的 flags 只有
   `1 << DataType::DmaBuf`），而 PipeWire 的约定是"协商结果里没有 VideoModifier
   ⇒ 用共享内存缓冲"，源端不支持 shm 时协商直接失败；
2. 即使强制客户端给 `Modifier::Invalid` 走线性 dmabuf，Intel Gen12 上"渲染进线性
   dmabuf"这条路本身是坏的（niri issue #4123，静默出黑帧；同款 GPU 上 OBS 也一样黑）。

SHM 采集回退已由上游 PR #1791 **合并进 niri 主线**，但**还没有 release**（最新 release
仍是 26.04），所以 Guix 里的 niri 没有它。本频道直接编译 main：

* `ch0r0ng/packages/wm.scm` 里的 `niri-git` + `smithay-git`
* `ch0r0ng/packages/niri-git-crates.scm`：自动生成的 crate 输入表
  （niri main 的 lock 487 个 + smithay 自己 lock 的 453 个）
* `~/config/guix/system.scm` 的系统包列表里用 `niri-git` 取代 `niri`

niri main 在客户端不带 modifier 协商时会走共享内存路径，日志出现：

```
negotiated inefficient shm stream, moving to ready state
```

### 打包方式（照抄本 Guix 里 niri 包的既有约定）

本 Guix（rosenthal fork）的 niri 包不使用 `rust-*` 包，而是把每个 crate 作为
**crates.io 的 fixed-output origin** 放进 `inputs`，由 `cargo-build-system` 的
`prepare-rust-crates` / `unpack-rust-crates` 摊成 vendor 目录；`configure` 会删掉
`Cargo.lock`，niri 自带的 `use-guix-vendored-dependencies` 阶段把 `Cargo.toml` 的
版本要求放宽成 `"*"`，于是 cargo 用提供的这套版本重新解析。

两个必须遵守的约定（踩过的坑）：

* input 的 **label 必须以 `rust-` 开头**（`rust-package?` 只看这个前缀）；
* origin 的 **`file-name` 必须与 label 相同**（`unpack-rust-crates` 用
  `(strip-store-file-name path)` 当 vendor 子目录名；不设 `file-name` 时每个 crate
  的 store 名都是 `download`，只会解出一个 crate、其余被当重复输入跳过）。

`smithay` 是 git 依赖，单独用一个继承 `rust-smithay-0.7.0.ff5fa7d` 的包，只把 source
换成 main 的 `Cargo.lock` 指定的 rev，并**单独**给它自己 lock 的完整 crate 集
（不能和 niri 的混用：两套 lock 版本不同，cargo 重新解析会挑到高版本然后找不到其依赖，
例如 `image 0.25.9` 需要 `zune-jpeg ^0.5.5`，而 niri 那边根本没有 `image`）。

### 升级到更新的 main

1. `git clone --depth 1 https://github.com/niri-wm/niri`（或 `git fetch`），记下 commit；
2. 更新 `wm.scm` 里的 `%niri-git-commit` 和它的 `sha256`（`guix hash -x -r <clone 目录>`）；
3. 在该 clone 里 `cargo vendor --locked <vendor 目录>`（会下齐 `.crate`）；
4. 对每个 `<name>-<version>.crate` 算哈希：`guix hash -S none`
   （**注意默认格式是 nix-base32**，不是 `-f base32`）；
5. smithay 那边同理：`cargo generate-lockfile` 得到它的完整依赖，逐个下载并哈希；
6. 生成表：
   `scripts/gen-niri-git-crates.sh <niri 哈希表> <smithay 哈希表> > ch0r0ng/packages/niri-git-crates.scm`；
   哈希表每行是 `name version hash`，由 `extract-crates.awk` 那种"遇下一个
   `[[package]]` 才 flush"的抽取方式从 `Cargo.lock` 得到（靠空行分块会漏 crate，
   `zune-jpeg 0.5.15` 就是这么被漏掉的）；
7. `guix build -L ~/cchanl niri-git`，再
   `sudo guix system reconfigure -L /home/liz/cchanl ~/config/guix/system.scm`。

---

## 走过但无效/已废弃的路（别再回头）

* **`wemeet-wayland-screenshare` hook（libhook.so）**：上游已 deprecation；实测挂上后一按
  「共享屏幕」就闪退，而且它自己建 PipeWire stream 同样撞"空 EnumFormat"这个坑。
  **包定义已从本频道删除**。
* **`niri-shm-sharing`（26.04 + rucnyz 的 SHM 移植补丁）**：曾经可用（portal 通了、SHM
  也走通了），但属于手工移植。**已删除**，由 `niri-git` 取代。
* `EGL_PLATFORM=wayland|surfaceless|x11`：在 libglvnd dispatcher 阶段就失败了，改不了 5021。
* 只加 pipewire、不修 EGL：5021 依旧。
* 只设 `WEMEET_XWAYLAND=1`、不给合法 EnumFormat：portal 通了但协商失败（-32）。
* niri `debug { force-pipewire-invalid-modifier; }`：能救协商，但线性 dmabuf 在 Gen12 上
  渲染出来就是黑的；niri main 自带 SHM 回退后**不再需要**，而且它对愿意用 dmabuf 的
  客户端（OBS、Firefox 等）有害。**已从 niri 配置里移除**。
* `cargo vendor` 目录作为 `#:vendor-dir` 输入：可行但没必要（583MB，且要选一个长期路径），
  用 crate origin 表更符合本 Guix 的既有做法。
* 沿用 Guix 的 `rust-*` 包 + 只补差额：不可行（26.04→main 有 233 个 crate 版本差异）。

## 已知遗留

* **共享画面没有鼠标指针**：wemeet 请求的是 `cursor_mode=Hidden`，而 niri 用 cursor
  metadata 把绘制指针的工作交给客户端，wemeet 自己不画。社区用 `wemeet-cursor-hook`
  解决，可以按同样思路并进我们自己的 shim。
* wemeet 的 portal 客户端还有别的坑，例如 flatpak 下 `Start` 早于 `SelectSources` 响应
  到达 → portal 以 `Sources not selected` 拒绝（见 acd407/wemeet-screencast-hook）。

## 参考

* niri issue #4123（Intel Gen12 监视器录制黑屏）：https://github.com/niri-wm/niri/issues/4123
* niri issue #3145（no more input formats）：https://github.com/niri-wm/niri/issues/3145
* 上游 PR #1791（Support shm sharing，已合并）：https://github.com/niri-wm/niri/pull/1791
* Arch 中文论坛 topic/16843（niri 26.04 腾讯会议共享讨论）：https://forum.archlinuxcn.org/t/topic/16843
