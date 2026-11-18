;;; swayidle 的 Guix Home 服务。
;;;
;;; swayidle 负责在系统挂起前执行 swaylock，并响应 logind 的 lock 请求。
;;; 它通过 logind 的 sleep delay inhibitor 工作：收到 PrepareForSleep 时先
;;; 跑命令，用 -w 等命令结束再放行挂起，所以 bar 的「休眠」、合盖、挂起键
;;; 都会经过这里。
;;;
;;; requirement 是 (graphical-session)：这个 provision 由 rosenthal 的
;;; home-graphical-session-service-type 提供，保证 niri 的 Wayland socket
;;; 已就绪；否则 swayidle 拿不到 WAYLAND_DISPLAY。
;;;
;;; 注意：swaylock 认证走 PAM 服务 "swaylock"，系统里必须有
;;; /etc/pam.d/swaylock。在 Guix System 上用 screen-locker-service-type
;;; 生成：
;;;
;;;   (service screen-locker-service-type
;;;            (screen-locker-configuration
;;;             (name "swaylock")
;;;             (program (file-append swaylock "/bin/swaylock"))
;;;             (using-setuid? #f)))
;;;
;;; 没有这个 PAM 服务时，swaylock 锁上后无法用登录密码解锁。
(define-module (ch0r0ng services swayidle)
  #:use-module (guix gexp)
  #:use-module (guix records)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services)
  #:use-module (gnu packages window-management)   ;swayidle, swaylock
  #:export (swayidle-configuration
            swayidle-configuration?
            swayidle-configuration-swayidle
            swayidle-configuration-swaylock
            swayidle-configuration-extra-options
            swayidle-configuration-extra-requirements
            home-swayidle-service-type))

(define-record-type* <swayidle-configuration> swayidle-configuration
  make-swayidle-configuration
  swayidle-configuration?
  (swayidle swayidle-configuration-swayidle
            (default swayidle))
  (swaylock swayidle-configuration-swaylock
            (default swaylock))
  ;; 追加给 swayidle 的参数，例如空闲自动锁屏：
  ;; '("timeout" "300" "/path/to/swaylock -f")
  (extra-options swayidle-configuration-extra-options
                 (default '()))
  (extra-requirements swayidle-configuration-extra-requirements
                      (default '())))

(define (swayidle-shepherd-services config)
  "Return the swayidle shepherd service for CONFIG."
  (let ((swayidle (swayidle-configuration-swayidle config))
        (swaylock (swayidle-configuration-swaylock config))
        (extra-options (swayidle-configuration-extra-options config))
        (extra-requirements (swayidle-configuration-extra-requirements config)))
    (list
     (shepherd-service
      (documentation "Lock the screen before suspend with swayidle.")
      (provision '(swayidle))
      (requirement `(graphical-session ,@extra-requirements))
      (start #~(lambda args
                 (let ((lock (string-append
                              #$(file-append swaylock "/bin/swaylock") " -f")))
                   ((make-forkexec-constructor
                     (list #$(file-append swayidle "/bin/swayidle")
                           "-w"
                           "lock" lock
                           "before-sleep" lock
                           #$@extra-options)
                     ;; Shepherd 的默认环境是启动时的快照；必须显式传当前环境，
                     ;; 否则拿不到 wayland-display 设置的 WAYLAND_DISPLAY。
                     #:environment-variables (environ))
                    args))))
      (stop #~(make-kill-destructor))
      (respawn? #t)))))

(define home-swayidle-service-type
  (service-type
   (name 'home-swayidle)
   (description "Run swayidle and lock the screen before suspend.")
   (extensions
    (list (service-extension home-shepherd-service-type
                             swayidle-shepherd-services)
          (service-extension home-profile-service-type
                             (lambda (config)
                               (list (swayidle-configuration-swayidle config))))))
   (default-value (swayidle-configuration))))
