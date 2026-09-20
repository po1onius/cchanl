/*
 * wemeet-portal-format-fix.c
 *
 * WeMeet 的 screen_share 模块在走 XDG Desktop Portal 抓屏时
 * （wrapper 里设了 WEMEET_XWAYLAND=1），会通过 dlsym 取得
 * pw_stream_connect / pw_stream_update_params，并给采集流传一个
 * “空的” EnumFormat 过滤器。实测把它解析出来是：
 *
 *     format=0(UNKNOWN)  modifier=0x0  size=0x0  framerate=0/0
 *
 * 这种过滤器与合成器（niri 等）offer 的格式求交集必然为空，
 * 于是 PipeWire 协商直接失败：
 *
 *     niri: pw error id=2 res=-32 no more input formats
 *
 * 现象：共享屏幕时对端全黑（本地也拿不到画面），而且无论换哪个
 * 合成器都失败 —— 这是 wemeet 自己的问题（niri issue #3145/#4123 是另一
 * 半：niri 默认只 offer Intel 的平铺/压缩 dmabuf 修饰符）。
 *
 * 本 shim 把它传来的 EnumFormat 换成“最小的合法视频格式过滤器”：
 *
 *     mediaType=video, mediaSubtype=raw,
 *     format=BGRx（外加 BGRA 作为备选）,
 *     modifier=Modifier::Invalid (0x00FFFFFFFFFFFFFF)  ← 线性、可 mmap
 *
 * 不指定 size / framerate，交给源端 fixate（niri 会给显示器原生尺寸
 * 与可变帧率）。WeMeet 用 PW_STREAM_FLAG_MAP_BUFFERS 连接，因此源端必须
 * 给**线性**缓冲，这也是 niri 侧需要 debug { force-pipewire-invalid-modifier }
 * 的原因。
 */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <spa/param/video/format-utils.h>
#include <spa/param/video/raw-utils.h>
#include <spa/pod/builder.h>

/* DRM_FORMAT_MOD_INVALID，即 gbm/smithay 的 Modifier::Invalid */
#define MOD_INVALID 0x00FFFFFFFFFFFFFFULL

static void *(*real_dlsym) (void *, const char *);
static void *real_connect;
static void *real_update_params;

static const struct spa_pod **
rewrite_params (const struct spa_pod **params, uint32_t n_params, uint32_t *out_n)
{
  /* 静态缓冲：PipeWire 在 connect/update 时会把 pod 内容拷走，
     但指针要一直有效，所以不放栈上。 */
  static uint8_t bufs[4][1024];
  static const struct spa_pod *pods[4];
  int i;

  (void) params;
  (void) n_params;

  /* 顺序很重要：
     前两个故意**不带** VideoModifier —— 打了 shm 补丁的 niri 在这种情况下会
     offer MemFd 共享内存，绕开 Intel Gen12 上坏掉的"渲染进线性 dmabuf"路径
     （niri issue #4123 的静默黑帧）。
     后两个带 Modifier::Invalid，用于没有 shm 支持的 niri：此时修饰符是
     MANDATORY，客户端不指定就会协商失败（res=-32 no more input formats）。 */
  for (i = 0; i < 4; i++)
    {
      struct spa_video_info_raw info;
      struct spa_pod_builder b;

      memset (&info, 0, sizeof info);
      info.format = (i % 2 == 0) ? SPA_VIDEO_FORMAT_BGRx : SPA_VIDEO_FORMAT_BGRA;
      info.modifier = (i < 2) ? 0 : MOD_INVALID;

      b = SPA_POD_BUILDER_INIT (bufs[i], sizeof bufs[i]);
      pods[i] = spa_format_video_raw_build (&b, SPA_PARAM_EnumFormat, &info);
    }

  *out_n = 4;
  return pods;
}

static int
my_pw_stream_connect (void *stream, int direction, uint32_t target_id,
                      uint32_t flags, const struct spa_pod **params,
                      uint32_t n_params)
{
  typedef int (*fn_t) (void *, int, uint32_t, uint32_t,
                       const struct spa_pod **, uint32_t);
  uint32_t n;
  const struct spa_pod **p = rewrite_params (params, n_params, &n);

  if (!real_connect)
    return -1;
  return ((fn_t) real_connect) (stream, direction, target_id, flags, p, n);
}

static int
my_pw_stream_update_params (void *stream, const struct spa_pod **params,
                            uint32_t n_params)
{
  typedef int (*fn_t) (void *, const struct spa_pod **, uint32_t);
  uint32_t n;
  const struct spa_pod **p = rewrite_params (params, n_params, &n);

  if (!real_update_params)
    return -1;
  return ((fn_t) real_update_params) (stream, p, n);
}

/* 模块是通过 dlsym 拿到这两个符号的，所以替换点在这里。
   real_dlsym 必须用 dlvsym 取，否则 dlsym 会递归到自己。 */
void *
dlsym (void *handle, const char *sym)
{
  void *p;

  if (!real_dlsym)
    real_dlsym = dlvsym (RTLD_NEXT, "dlsym", "GLIBC_2.2.5");

  p = real_dlsym ? real_dlsym (handle, sym) : NULL;

  if (sym != NULL && strcmp (sym, "pw_stream_connect") == 0)
    {
      real_connect = p;
      fprintf (stderr, "wemeet-portal-format-fix: patching pw_stream_connect\n");
      return (void *) my_pw_stream_connect;
    }
  if (sym != NULL && strcmp (sym, "pw_stream_update_params") == 0)
    {
      real_update_params = p;
      fprintf (stderr, "wemeet-portal-format-fix: patching pw_stream_update_params\n");
      return (void *) my_pw_stream_update_params;
    }
  return p;
}
