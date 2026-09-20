;;; awww（swww 改名之后的名字）的 Guix Home 服务。
;;;
;;; awww 是 Wayland 动画壁纸 daemon，依赖 wlr-layer-shell（niri 支持）。
;;;
;;; 用法：
;;;
;;;   (service home-awww-service-type
;;;            (awww-configuration
;;;             ;; wallpaper 给运行时路径（字符串）或 file-like 都可以：字符串要求
;;;             ;; 那一刻该路径确实存在，file-like（如 (local-file "wp.jpg")）则在
;;;             ;; reconfigure 时就复制进 store、之后不依赖原文件。
;;;             (wallpaper "/path/to/wallpaper.jpg")))
;;;
;;; 不指定 wallpaper 就不生成设置壁纸的那个 one-shot 服务（daemon 照样跑，并会尝试
;;; 从自己的 cache 恢复上次的壁纸）。
;;;
;;; requirement 是 (graphical-session)，和 rosenthal 的 home-waybar 一样：这个
;;; provision 由 home-graphical-session-service-type 提供，而后者依赖 wayland-display
;;; 服务（它负责等 niri 的 socket 出现、并把 WAYLAND_DISPLAY setenv 进 Shepherd
;;; 环境）。所以这个服务必须和 rosenthal 的 home-graphical-session 成对出现，
;;; 否则 wayland-display 不存在、服务不会启动（或者报依赖缺失）。
;;;
;;; ── 两个 Shepherd 的环境坑（写这个服务时踩过的）────────────────────────────
;;;
;;; 1. make-forkexec-constructor 默认的环境是
;;;      (default-environment-variables) == (make-parameter (environ))
;;;    ——它在 (shepherd service) 模块加载那一刻（也就是 Shepherd 启动瞬间）就求值
;;;    固化了。wayland-display 后来 setenv 的 WAYLAND_DISPLAY 因此对 fork 出来的
;;;    子进程不可见，awww-daemon 会去连默认的 wayland-0、连不上 compositor 直接
;;;    panic（信号 6），然后被 Shepherd 的 respawn 次数限制禁用，表现为“壁纸服务
;;;    起不来”。修法和 rosenthal 的 waybar 服务一样：显式传
;;;    #:environment-variables (environ)。
;;;
;;; 2. one-shot 服务里不能用裸的 system*：实测在 Shepherd 里，Shepherd 自己的
;;;    (getenv "WAYLAND_DISPLAY") 是 "wayland-1"、(environ) 里也有它，但 system*
;;;    fork 出的子进程 env 里却没有（子进程只拿到 Shepherd 启动那一刻的变量，连
;;;    (environ lst) 重新安装环境都无效）；而 make-forkexec-constructor 显式传
;;;    #:environment-variables 时子进程能正常拿到。所以 awww img 用 coreutils 的
;;;    env 把 WAYLAND_DISPLAY 显式带上。（waybar 是常驻 daemon，没有这个问题。）
(define-module (ch0r0ng services awww)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages base)                ;coreutils（env）
  #:use-module (gnu packages window-management)   ;awww
  #:use-module (gnu services)
  #:export (awww-configuration
            awww-configuration?
            awww-configuration-awww
            awww-configuration-wallpaper
            awww-configuration-extra-options
            home-awww-service-type))

(define-record-type* <awww-configuration> awww-configuration
  make-awww-configuration
  awww-configuration?
  (awww awww-configuration-awww
        (default awww))
  (wallpaper awww-configuration-wallpaper
             (default #f))
  (extra-options awww-configuration-extra-options
                 (default '())))

(define (awww-shepherd-services config)
  "Return the list of shepherd services for CONFIG, an <awww-configuration>."
  (let ((awww (awww-configuration-awww config))
        (wallpaper (awww-configuration-wallpaper config))
        (extra-options (awww-configuration-extra-options config)))
    `(,(shepherd-service
        (documentation "Run the awww Wayland wallpaper daemon.")
        (provision '(awww awww-daemon))
        (requirement '(graphical-session))
        (start #~(lambda args
                   ((make-forkexec-constructor
                     (list #$(file-append awww "/bin/awww-daemon")
                           #$@extra-options)
                     ;; 见文件开头第 1 条：Shepherd 默认给的是它启动那一刻的环境快照，
                     ;; 必须显式传当前环境，否则拿不到 wayland-display 设置的
                     ;; WAYLAND_DISPLAY。
                     #:environment-variables (environ))
                    args)))
        (stop #~(make-kill-destructor))
        (respawn? #t))

      ;; 可选：登录后把壁纸设成指定文件。做成 one-shot：成功后 Shepherd 就把它
      ;; 标记为已停止，不需要常驻进程（shepherd-service 的 one-shot? 字段）。
      ;; 没配 wallpaper 就不生成这个服务。
      ,@(if wallpaper
            (list
             (shepherd-service
              (documentation "Set the initial awww wallpaper.")
              (provision '(awww-wallpaper))
              (requirement '(awww))
              (one-shot? #t)
              (start #~(lambda _
                         ;; 重试是为了等 daemon 的 socket 就绪：没有 daemon 时 awww
                         ;; 客户端会直接失败退出。
                         (let loop ((tries 50))
                           (let ((display (getenv "WAYLAND_DISPLAY")))
                             (cond ((zero? tries) #f)
                                   ((not display)
                                    (sleep 0.2)
                                    (loop (- tries 1)))
                                   ((zero?
                                     (system*
                                      ;; 见文件开头第 2 条：裸的 system* 看不到
                                      ;; WAYLAND_DISPLAY，用 env 显式带上。
                                      #$(file-append coreutils "/bin/env")
                                      (string-append "WAYLAND_DISPLAY=" display)
                                      #$(file-append awww "/bin/awww")
                                      "img" #$wallpaper))
                                    #t)
                                   (else
                                    (sleep 0.2)
                                    (loop (- tries 1))))))))
              (stop #~(lambda _ #t))
              (respawn? #f)))
            '()))))

(define home-awww-service-type
  (service-type
   (name 'home-awww)
   (description "Run the awww Wayland wallpaper daemon.")
   (extensions
    (list (service-extension home-shepherd-service-type
                             awww-shepherd-services)))
   (default-value (awww-configuration))))
