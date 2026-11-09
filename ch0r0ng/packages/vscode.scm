;;; Microsoft Visual Studio Code, repackaged from the official stable release.
(define-module (ch0r0ng packages vscode)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gtk)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (nonguix build-system chromium-binary)
  #:use-module ((nonguix licenses) #:prefix license:)
  #:use-module (ice-9 match))

(define-public vscode
  (package
    (name "vscode")
    (version "1.145.2")
    (source
     (let* ((system (or (%current-target-system) (%current-system)))
            (arch (match system
                    ("x86_64-linux" "x64")
                    ("aarch64-linux" "arm64")
                    (_ (error "Unsupported VS Code system" system))))
            (hash (match system
                    ("x86_64-linux"
                     "18msrxvi7kdh0zkdjiy4bny96ywg84fq2jwlc3c6y0ps75k2h09v")
                    ("aarch64-linux"
                     "1x16w6a7hdfwjzw7n6wmalp9ydy07802nh6427ydm6z3qrz32q32"))))
       (origin
         (method url-fetch)
         (uri (string-append "https://update.code.visualstudio.com/"
                             version "/linux-" arch "/stable"))
         (file-name (string-append "vscode-" version "-" arch ".tar.gz"))
         (sha256 (base32 hash)))))
    (build-system chromium-binary-build-system)
    (arguments
     (list
      #:substitutable? #f
      #:strip-binaries? #f
      ;; Electron also loads libraries dynamically at runtime.
      #:validate-runpath? #f
      #:install-plan #~'(("opt" "opt"))
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack
            (lambda* (#:key source #:allow-other-keys)
              (mkdir-p "opt/vscode")
              (invoke "tar" "xf" source "--strip-components=1"
                      "-C" "opt/vscode")))
          (add-after 'unpack 'disable-self-update
            (lambda _
              ;; The store is immutable; upgrades are managed by Guix.
              (substitute* "opt/vscode/resources/app/product.json"
                (("\"updateUrl\"[[:space:]]*:[[:space:]]*\"[^\"]*\"")
                 "\"updateUrl\": \"\""))))
          (replace 'patchelf
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (use-modules (ice-9 popen) (ice-9 textual-ports))
              (define (needs-libraries? file stat)
                ;; Static PIE executables have a dynamic section too.  Leave
                ;; these (notably ripgrep) untouched: rewriting their RPATH
                ;; can break the executable's own relocation code.
                (and (elf-file? file)
                     (with-error-to-port (%make-void-port "w")
                       (lambda ()
                         (let* ((port (open-pipe* OPEN_READ "patchelf"
                                                  "--print-needed" file))
                                (needed (get-string-all port))
                                (status (close-pipe port)))
                           (and (zero? status)
                                (not (string-null? needed))))))))
              ;; Patch helpers (ripgrep, node-pty, tunnel) and native Node
              ;; modules as well as Electron.  Extensions use these directly.
              (let ((libraries
                     (map car (filter (lambda (input)
                                        (and (not (member (car input)
                                                          '("source" "libc32")))
                                             (file-exists?
                                              (string-append (cdr input) "/lib"))))
                                      inputs))))
                ((assoc-ref %standard-phases 'patchelf)
                 #:inputs inputs #:outputs outputs
                 #:patchelf-plan
                 (map (lambda (file)
                        (list file
                              (append libraries
                                      (list '("out" "/opt/vscode")
                                            (list "out"
                                                  (string-append "/" (dirname file)))))))
                      (find-files "opt/vscode" needs-libraries?))))))
          (add-before 'install-wrapper 'install-entrypoint
            (lambda _
              (let ((bin (string-append #$output "/bin")))
                (mkdir-p bin)
                ;; Keep upstream's CLI: it implements --wait, --version,
                ;; extension management and terminal-to-window integration.
                (symlink (string-append #$output "/opt/vscode/bin/code")
                         (string-append bin "/code")))))
          (add-after 'install-wrapper 'install-desktop-files
            (lambda _
              (let ((apps (string-append #$output "/share/applications"))
                    (icons (string-append #$output
                                          "/share/icons/hicolor/512x512/apps"))
                    (command (string-append #$output "/bin/code")))
                (mkdir-p icons)
                (symlink (string-append #$output
                                        "/opt/vscode/resources/app/resources/linux/code.png")
                         (string-append icons "/vscode.png"))
                (make-desktop-entry-file
                 (string-append apps "/com.microsoft.VSCode.desktop")
                 #:name "Visual Studio Code"
                 #:generic-name "Text Editor"
                 #:exec (string-append command " %F")
                 #:icon "vscode"
                 #:categories '("TextEditor" "Development" "IDE")
                 #:mime-type '("text/plain" "inode/directory")
                 #:startup-w-m-class "Code")
                (make-desktop-entry-file
                 (string-append apps "/com.microsoft.VSCode.url-handler.desktop")
                 #:name "Visual Studio Code - URL Handler"
                 #:exec (string-append command " --open-url %U")
                 #:icon "vscode"
                 #:no-display #t
                 #:mime-type '("x-scheme-handler/vscode")
                 #:startup-w-m-class "Code")))))))
    (native-inputs (list tar))
    (inputs (list gdk-pixbuf))
    (supported-systems '("x86_64-linux" "aarch64-linux"))
    (home-page "https://code.visualstudio.com/")
    (synopsis "Microsoft Visual Studio Code editor (official binary)")
    (description
     "Visual Studio Code is a code editor with debugging, Git integration,
an integrated terminal and extensions.  This package uses Microsoft's official
stable binary distribution, including access to the Visual Studio Marketplace.
It provides the code command and desktop and vscode:// URL handlers.")
    (license (license:nonfree "https://code.visualstudio.com/license"))))
