;;; awww（swww 改名之后的名字）的 Guix Home 服务。
;;;
;;; awww 是 Wayland 动画壁纸 daemon，依赖 wlr-layer-shell（niri 支持）。
;;;
;;; 用法：
;;;
;;;   (service home-awww-service-type
;;;            (awww-configuration
;;;             (wallpaper "/home/liz/Pictures/wall.png")))
;;;
;;; 不指定 wallpaper 也可以：awww-daemon 启动时会从自己的 cache 恢复上次用的壁纸
;;; （`awww-daemon --no-cache` 可关掉这个行为）。
;;;
;;; 注意：和 rosenthal 的 home-waybar 一样，这个 shepherd 服务的 requirement 是
;;; (graphical-session)，所以必须和 rosenthal 的
;;; home-graphical-session-service-type 成对出现，否则服务不会启动（或者报依赖缺失）。
(define-module (ch0r0ng services awww)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
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
    (list
     (shepherd-service
      (documentation "Run the awww Wayland wallpaper daemon.")
      (provision '(awww awww-daemon))
      (requirement '(graphical-session))
      (start #~(make-forkexec-constructor
                (list #$(file-append awww "/bin/awww-daemon") #$@extra-options)))
      (stop #~(make-kill-destructor))
      (respawn? #t))

     ;; 可选：登录后把壁纸设成指定文件。做成 one-shot：成功后 Shepherd 就把它标记为
     ;; 已停止，不需要常驻进程（shepherd-service 的 one-shot? 字段）。
     (shepherd-service
      (documentation "Set the initial awww wallpaper.")
      (provision '(awww-wallpaper))
      (requirement '(awww))
      (one-shot? #t)
      (start #~(lambda _
                 ;; 等 daemon 的 socket 就绪：awww 客户端在没有 daemon 时会直接失败。
                 (let loop ((tries 50))
                   (cond ((zero? tries) #f)
                         ((zero? (system* #$(file-append awww "/bin/awww")
                                          "img" #$wallpaper))
                          #t)
                         (else
                          (sleep 0.2)
                          (loop (- tries 1)))))))
      (stop #~(lambda _ #t))
      (respawn? #f)))))

(define home-awww-service-type
  (service-type
   (name 'home-awww)
   (description "Run the awww Wayland wallpaper daemon.")
   (extensions
    (list (service-extension home-shepherd-service-type
                             awww-shepherd-services)))
   (default-value (awww-configuration))))
