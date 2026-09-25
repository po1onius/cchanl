;;; Quickshell 的 Guix Home 服务。
;;;
;;; 用来跑自己写的 Quickshell 壳（bar / 通知 / 启动器 / 锁屏都由一个常驻
;;; quickshell 进程画，壳本身只是 `~/.config/quickshell/...` 下的一份 QML
;;; 配置目录）。默认用本频道的 quickshell-git（上游 master 快照）。
;;;
;;; ── 依赖谁 ─────────────────────────────────────────────────────────────
;;;
;;; requirement 是 (dbus graphical-session)：
;;;   * graphical-session —— 合成器/Wayland socket 就绪；这个 provision 由
;;;     rosenthal 的 home-graphical-session-service-type 提供（它自己又依赖
;;;     wayland-display 去探测 socket）。我们只按“服务名”依赖它，不 import
;;;     rosenthal，保持本频道独立。
;;;   * dbus —— tray(SNI)、MPRIS、通知、门户都走会话总线；home-dbus 启动很早，
;;;     不会明显拖慢 bar。这也是 rosenthal 的 home-noctalia / home-fcitx5 的
;;;     同样写法。
;;;
;;; 其余都不要做成依赖：pipewire/wireplumber、fcitx5、awww 之类缺了只是少一块
;;; UI，壳应当容忍缺失、先把 bar 画出来（nota bene: requirement 只保证“已启动”，
;;; 不保证“已就绪”—— 真正的就绪判断在 wayland-display 自己那里）。确实需要就
;;; 用 extra-requirements 显式加，例如 (extra-requirements '(wireplumber))。
;;;
;;; 注意两个“冲突”而非依赖的邻居：壳自己拥有 org.freedesktop.Notifications，
;;; 所以不要同时启用 mako / dunst 之类通知守护进程（Shepherd 层面表达不了这个，
;;; 只能靠文档）。
;;;
;;; ── 与 DMS 上游那个 systemd 用户单元的对应关系 ───────────────────────
;;;
;;;   ExecStart=/usr/bin/dms run --session   →  /…/bin/qs [配置参数]
;;;   Restart=always / RestartSec=2          →  (respawn? #t)
;;;   PartOf/After/Requisite=graphical-session.target
;;;                                     →  (requirement '(dbus graphical-session))
;;;
;;; ── 三个坑（都是这个会话里踩过的）────────────────────────────────────
;;;
;;; 1. Quickshell 的壳配置常常直接读 NIRI_SOCKET 环境变量（DMS 的
;;;    Services/NiriService.qml 就是 `Quickshell.env("NIRI_SOCKET")`，没有兜底
;;;    发现），而 Guix Home 的 Shepherd 环境里有 XDG_CURRENT_DESKTOP=niri、
;;;    WAYLAND_DISPLAY=wayland-1，但**没有** NIRI_SOCKET。所以下面在 start
;;;    thunk 里自己从 $XDG_RUNTIME_DIR 找 niri 的 IPC socket 并 setenv。
;;;
;;; 2. Shepherd 的 make-forkexec-constructor 默认环境是它启动那一刻的快照
;;;    （default-environment-variables = (make-parameter (environ))），所以必须
;;;    显式传 #:environment-variables (environ)，否则上面 setenv 的
;;;    NIRI_SOCKET 传不给 qs。
;;;
;;; 3. 不要加 -d/--daemonize：Shepherd 直接托管这个进程，daemonize 会让 qs
;;;    脱离控制，Shepherd 认为它退出了、于是反复重启。额外参数（比如
;;;    -n/--no-duplicate、-v）用 extra-options。
;;;
;;; 另外：在 shell 配置就位之前不要启用这个服务 —— qs 找不到 shell.qml 会立刻
;;; 退出，respawn 会在几次快速失败后把它禁用（日志里会刷“服务 quickshell
;;; 启动失败”）。
(define-module (ch0r0ng services quickshell)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services)
  #:use-module (ch0r0ng packages quickshell)   ;quickshell-git
  #:export (quickshell-configuration
            quickshell-configuration?
            quickshell-configuration-quickshell
            quickshell-configuration-config
            quickshell-configuration-extra-options
            quickshell-configuration-extra-requirements
            quickshell-configuration-extra-packages
            home-quickshell-service-type))

(define-record-type* <quickshell-configuration> quickshell-configuration
  make-quickshell-configuration
  quickshell-configuration?
  (quickshell quickshell-configuration-quickshell
              (default quickshell-git))
  ;; 选中要跑的壳，四种取值：
  ;;   #f                → 不带参数，qs 跑 `default` 配置，即
  ;;                       ~/.config/quickshell/shell.qml
  ;;   "myshell"         → qs -c myshell，即
  ;;                       ~/.config/quickshell/myshell/shell.qml
  ;;   "/path/to/dir"    → qs -p /path/to/dir（目录或单个 .qml 文件）
  ;;   (local-file …)    → 同样是 -p，但文件在 reconfigure 时进 store
  (config quickshell-configuration-config
          (default #f))
  (extra-options quickshell-configuration-extra-options
                 (default '()))
  ;; 额外的 shepherd 依赖，例如 '(wireplumber) 或 '(awww)。
  (extra-requirements quickshell-configuration-extra-requirements
                      (default '()))
  ;; 额外装进 profile 的包：壳要调的 helper，例如
  ;; matugen / brightnessctl / cliphist / wl-clipboard / cava。
  (extra-packages quickshell-configuration-extra-packages
                  (default '())))

(define (quickshell-config-arguments shell-config)
  "Return a gexp for the command-line arguments selecting SHELL-CONFIG."
  (cond
   ((not shell-config) #~'())
   ((file-like? shell-config) #~(list "-p" #$shell-config))
   ((string? shell-config)
    ;; 含 / 当路径（-p），否则当配置名（-c）。
    #~(list #$(if (memv #\/ (string->list shell-config)) "-p" "-c")
            #$shell-config))
   (else (error "unsupported quickshell configuration" shell-config))))

(define (quickshell-environment-variables shell-config)
  "Return an alist setting the QS_CONFIG_* variable that matches SHELL-CONFIG,
so that any `qs' run (including one typed in a terminal) picks the same shell."
  (cond
   ((not shell-config) '())
   ((file-like? shell-config)
    `(("QS_CONFIG_PATH" . ,shell-config)))
   ((string? shell-config)
    (if (memv #\/ (string->list shell-config))
        `(("QS_CONFIG_PATH" . ,shell-config))
        `(("QS_CONFIG_NAME" . ,shell-config))))
   (else (error "unsupported quickshell configuration" shell-config))))

(define (niri-socket-setup)
  "Return a gexp that sets NIRI_SOCKET in Shepherd's environment if it is not
already set, by looking for niri's IPC socket (niri.<display>.<pid>.sock) in
$XDG_RUNTIME_DIR."
  #~(begin
      (or (getenv "NIRI_SOCKET")
          (let* ((runtime-dir (or (getenv "XDG_RUNTIME_DIR")
                                  (string-append "/run/user/"
                                                 (number->string (getuid)))))
                 (display (getenv "WAYLAND_DISPLAY"))
                 (sockets (catch 'system-error
                            (lambda ()
                              ;; scandir 来自 (ice-9 ftw)，见下面的 modules。
                              (scandir runtime-dir
                                       (lambda (name)
                                         (and (string-prefix? "niri." name)
                                              (string-suffix? ".sock" name)))))
                            (lambda _ '())))
                 ;; 优先挑跟当前 WAYLAND_DISPLAY 匹配的那个，避免多实例/残留
                 ;; socket 时挑错；没有 display 就退回第一个。
                 (preferred (and display
                                 (filter (lambda (name)
                                           (string-prefix?
                                            (string-append "niri." display ".")
                                            name))
                                         sockets)))
                 (pick (if (pair? preferred)
                           (car preferred)
                           (and (pair? sockets) (car sockets)))))
            (when pick
              (setenv "NIRI_SOCKET" (in-vicinity runtime-dir pick))
              #t)))))

(define (quickshell-command quickshell shell-config extra-options)
  "Return a gexp for the complete qs command line."
  #~(append (list #$(file-append quickshell "/bin/qs"))
            #$(quickshell-config-arguments shell-config)
            '#$extra-options))

(define (quickshell-shepherd-services config)
  "Return the list of shepherd services for CONFIG, a
<quickshell-configuration>."
  (let ((quickshell (quickshell-configuration-quickshell config))
        (shell-config (quickshell-configuration-config config))
        (extra-options (quickshell-configuration-extra-options config))
        (extra-requirements
         (quickshell-configuration-extra-requirements config)))
    (list
     (shepherd-service
      (documentation "Run the Quickshell desktop shell.")
      (provision '(quickshell))
      (requirement `(dbus graphical-session ,@extra-requirements))
      (modules '((ice-9 ftw)))          ;scandir，niri-socket-setup 用
      (start #~(lambda args
                 #$(niri-socket-setup)
                 ((make-forkexec-constructor
                   #$(quickshell-command quickshell shell-config extra-options)
                   ;; 见文件开头第 2 条：Shepherd 默认给的是启动时的环境快照，
                   ;; 必须显式传当前环境。
                   #:environment-variables (environ))
                  args)))
      (stop #~(make-kill-destructor))
      (respawn? #t)))))

(define home-quickshell-service-type
  (service-type
   (name 'home-quickshell)
   (description "Run the Quickshell desktop shell.")
   (extensions
    (list (service-extension home-shepherd-service-type
                             quickshell-shepherd-services)
          (service-extension home-profile-service-type
                             (lambda (config)
                               (cons (quickshell-configuration-quickshell config)
                                     (quickshell-configuration-extra-packages
                                      config))))
          (service-extension home-environment-variables-service-type
                             (lambda (config)
                               (quickshell-environment-variables
                                (quickshell-configuration-config config))))))
   (default-value (quickshell-configuration))))
