# cchanl

这是一个 Guix channel，channel 名称空间为 `ch0r0ng`，主要收录 Wayland 桌面、终端和开发工具，以及 QQ、腾讯会议、Clash Verge 等 Linux 桌面程序的 Guix 包和服务定义。

仓库根目录包含 `.guix-channel`。其中的 channel 依赖声明了 [nonguix](https://gitlab.com/nonguix/nonguix)，因此使用 Chrome、QQ、腾讯会议等包时不需要另外复制它们的打包定义。部分包直接重新打包上游发布的二进制文件，具体许可和支持的系统以包定义为准。

## 添加 channel

在 `~/.config/guix/channels.scm` 中加入：

```scheme
(cons
 (channel
  (name 'ch0r0ng)
  (url "https://github.com/po1onius/cchanl")
  (branch "master"))
 %default-channels)
```

然后更新 Guix：

```sh
guix pull -C ~/.config/guix/channels.scm
```

更新完成后，可以直接按包名使用 channel 中的包：

```sh
guix install ghostty
guix install niri-git
guix install codex
```

如果只是检出仓库测试，不想先执行 `guix pull`，可以把仓库根目录作为额外的 Scheme 搜索路径：

```sh
guix build -L /path/to/cchanl ghostty
guix install -L /path/to/cchanl ghostty
```

其中 `/path/to/cchanl` 是包含 `.guix-channel` 和 `ch0r0ng/` 的仓库根目录。

## 包

公开包定义位于 `ch0r0ng/packages/`。可以使用 `guix search`、`guix show` 或 `guix build` 查看包的完整元数据。

| 包名 | 说明 |
| --- | --- |
| `google-chrome-stable-wayland` | 基于 nonguix Chrome stable 的 Wayland 版本，启动时默认使用 `--ozone-platform=wayland`。 |
| `clash-verge-rev-bin` | Clash Verge Rev 预编译 Linux 二进制包，当前只支持 `x86_64-linux`。配合下方的 `clash-verge-service-type` 使用特权 IPC 服务。 |
| `codex` | 从固定版本源码构建的 OpenAI Codex CLI，同时包含 Code Mode、voice host 和 Codex 使用的 bubblewrap。支持 `x86_64-linux` 和 `aarch64-linux`。 |
| `codex-bin` | OpenAI Codex CLI 的官方预编译发行包，包含 ripgrep、bubblewrap、zsh 等运行时文件。支持 `x86_64-linux` 和 `aarch64-linux`。 |
| `dae-bin` | dae 的预编译包，提供基于 eBPF 的透明代理程序，当前只支持 `x86_64-linux`。 |
| `ghostty` | Ghostty GPU 加速终端，使用 GTK4/libadwaita，构建时离线填充 Zig 依赖缓存。 |
| `niri-git` | 从固定 Git commit 构建的 niri 主线版本，包含尚未进入稳定版的 PipeWire/SHM 屏幕采集回退。它属于预发布包，构建需要下载并处理大量 Rust crate。 |
| `qq` | 腾讯 QQ Linux 官方 `.deb` 二进制包，当前版本为 `3.2.32`，只支持 `x86_64-linux`。包装脚本会设置运行时库路径并关闭无法写入 `/gnu/store` 的自动更新。 |
| `sddm-astronaut-theme` | SDDM Astronaut Qt6 主题，当前版本为 `1.4`。需要 Qt6 版 SDDM，并建议把 `qtmultimedia` 放入系统 profile。 |
| `wemeet` | 腾讯会议 Linux 官方 `.deb` 二进制包，提供 `wemeet` 和 `wemeet-xwayland` 两个启动器，当前只支持 `x86_64-linux`。包含针对 Guix、Wayland 和 PipeWire 的运行时修补。 |
| `gcc-symlink` | 提供从 `cc` 到 `gcc` 的符号链接，适合需要 `cc` 命令的构建环境。 |
| `wemeet-shims` | 腾讯会议使用的 `LD_PRELOAD` 修补库，通常由 `wemeet` 自动依赖，不需要单独安装。 |

常用包的差异如下：

- `codex` 是源码构建版本，构建时间较长，但依赖和构建过程由 Guix 管理；`codex-bin` 使用上游预编译发行包，安装更快。
- `niri-git` 跟随固定的 niri 主线 commit，不等同于 Guix 或 Rosenthal 中的稳定 `niri`。升级它时需要同时更新 niri、smithay 以及对应的 crate 输入表。
- `wemeet` 在 Wayland 会话中优先使用 `wemeet`；如果某些桌面环境兼容性较差，可以尝试 `wemeet-xwayland`。关于 niri 下屏幕共享的 PipeWire、SHM 和格式协商细节，见 [`docs/wemeet-screenshare.md`](docs/wemeet-screenshare.md)。
- `google-chrome-stable-wayland`、`qq` 和 `wemeet` 使用上游非自由软件或二进制发行包，请同时查看对应上游许可。

## 服务

服务定义位于 `ch0r0ng/services/`。下面的配置片段放入相应的 Guix System 或 Guix Home 配置文件后，记得导入对应模块。

### `home-awww-service-type`

这是 Guix Home 服务，用于在 Wayland 图形会话中启动 `awww-daemon`，并可在登录后设置初始壁纸。它依赖 `graphical-session`，通常需要和桌面环境提供的 Wayland session 服务一起使用。

```scheme
(use-modules (gnu home)
             (gnu home services)
             (gnu home services shepherd)
             (guix gexp)
             (ch0r0ng services awww))

(home-environment
 (services
  (cons
   (service home-awww-service-type
            (awww-configuration
             (wallpaper (local-file "/home/alice/Pictures/wallpaper.jpg"))))
   %base-home-services)))
```

`wallpaper` 可以是路径字符串，也可以是 `local-file` 等 file-like 对象。不设置它时只启动 daemon，由 awww 自己恢复缓存中的壁纸；`extra-options` 可用于向 `awww-daemon` 传递额外参数。

### `clash-verge-service-type`

这是 Guix System 服务，用 Shepherd 启动 Clash Verge Rev 的特权 IPC 服务。默认会创建 `clash-verge` 系统组、准备运行时目录，并把 GUI 包加入系统 profile。

```scheme
(use-modules (gnu)
             (ch0r0ng services clash-verge))

(operating-system
  ;; 其他 operating-system 字段略
  (services
   (cons
    (service clash-verge-service-type
             (clash-verge-configuration
              (install-gui? #t)
              (auto-start? #t)
              (tun-mode? #t)))
    %base-services)))
```

主要选项：

- `package`：要运行的 `clash-verge-rev-bin` 包。
- `group`：访问服务 socket 的系统组，默认是 `clash-verge`。
- `install-gui?`：是否把 GUI 加入系统 profile，默认开启。
- `auto-start?`：是否由 Shepherd 自动启动特权服务，默认开启。
- `tun-mode?`：启用 TUN 所需的 `tun` 内核模块、网络 sysctl 和 `verge-mihomo` capabilities，默认关闭。

需要使用 GUI 控制服务的桌面用户必须加入配置中的 `group`，例如把用户加入 `clash-verge` 后重新登录。启用 TUN 模式前也应确认系统内核支持 TUN 和相关网络能力。

### `dae-service-type`

这是 Guix System 服务，用 Shepherd 启动 `dae`，并挂载 `/sys/fs/bpf`。dae 的配置文件和资源目录可以显式指定：

```scheme
(use-modules (gnu)
             (ch0r0ng services networking))

(operating-system
  ;; 其他 operating-system 字段略
  (services
   (cons
    (service dae-service-type
             (dae-service-configuration
              (config-file "/etc/dae/config.dae")
              (assets-path "/var/lib/dae")
              (log-file "/var/log/dae.log")
              (auto-start? #t)))
    %base-services)))
```

`assets-path` 应包含 dae 所需的 `geoip.dat` 和 `geosite.dat`。如果不指定自定义目录，dae 会使用包内的资源目录。`config-file` 支持字符串或 file-like 对象；在系统服务中建议使用绝对路径。

## 在 Scheme 中直接引用

包和服务分别按下面的模块路径提供：

```scheme
(use-modules (ch0r0ng packages ghostty)
             (ch0r0ng services awww))
```

对应关系是：

```text
ch0r0ng/packages/ghostty.scm  -> (ch0r0ng packages ghostty)
ch0r0ng/services/awww.scm     -> (ch0r0ng services awww)
```

`ch0r0ng/build/` 和 `ch0r0ng/packages/*/crates.scm` 是构建辅助模块或固定依赖表，通常不需要在系统配置中直接引用。

## 本地构建和检查

在仓库根目录执行：

```sh
# 构建包
guix build -L . ghostty
guix build -L . niri-git

# 检查包元数据
guix show -L . wemeet

# 检查 channel 中的 Scheme 文件能否被加载
guix repl -L .
```

在 `guix repl` 中可以测试模块和公开变量：

```scheme
(use-modules (ch0r0ng packages ghostty))
ghostty
```

如果构建某个依赖 nonguix 的包时出现 `no code for module (nongnu ...)`，请确认使用的是包含 `.guix-channel` 的仓库根目录，并且 Guix 版本支持 channel dependencies；执行一次 `guix pull` 通常可以让 channel 依赖正确同步。

## 目录结构

```text
.
├── .guix-channel             # channel 元数据和 nonguix 依赖
├── ch0r0ng/
│   ├── build/                # 二进制包的构建阶段
│   ├── packages/             # 包定义
│   └── services/             # Guix System / Guix Home 服务
├── docs/                     # 使用和排错笔记
└── scripts/                  # 依赖表生成等维护脚本
```

## 许可和支持范围

本 channel 中的每个包沿用其包定义中的许可字段。QQ、腾讯会议和 Chrome 等包来自上游二进制发行版，使用前请确认你接受相应的上游许可条款。标记为预发布或 Git 版本的包可能随上游变化，建议在生产系统中固定 channel commit，并在更新后重新构建验证。
