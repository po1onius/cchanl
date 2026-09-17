;;; Clash Verge Rev packaged from the upstream Linux binary release.
(define-module (ch0r0ng packages clash-verge)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bootstrap)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages webkit)
  #:export (clash-verge-rev-bin))

(define-public clash-verge-rev-bin
  (package
    (name "clash-verge-rev-bin")
    (version "2.5.2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v"
             version "/Clash.Verge_" version "_amd64.deb"))
       (sha256
        (base32
         "1vb7q6dxzsmfrr4qarxnpqkmvpdy6h5p2pby77fz2vdi2knq6p03"))))
    (build-system gnu-build-system)
    (arguments
     (list
      ;; The binaries are supplied by upstream.  They must not be stripped.
      #:strip-binaries? #f
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack
            (lambda* (#:key source #:allow-other-keys)
              (mkdir "source")
              (chdir "source")
              (invoke "ar" "x" source)
              (mkdir "data")
              (invoke "tar" "xf" "data.tar.gz" "-C" "data")))
          (delete 'configure)
          (delete 'build)
          (delete 'check)
          (replace 'install
            (lambda* (#:key inputs outputs tests? #:allow-other-keys)
              (use-modules (guix build utils) (srfi srfi-1))
              (let* ((out (assoc-ref outputs "out"))
                     (program (string-append out "/bin/clash-verge"))
                     (service (string-append out "/bin/clash-verge-service"))
                     (rpath
                      (string-join
                       (delete-duplicates
                        (map (lambda (library)
                               (dirname (search-input-file inputs library)))
                             '("/lib/libc.so.6"
                               "/lib/libgcc_s.so.1"
                               "/lib/libgdk-3.so.0"
                               "/lib/libgdk_pixbuf-2.0.so.0"
                               "/lib/libcairo.so.2"
                               "/lib/libgobject-2.0.so.0"
                               "/lib/libglib-2.0.so.0"
                               "/lib/libdbus-1.so.3"
                               "/lib/libwebkit2gtk-4.1.so.0"
                               "/lib/libgtk-3.so.0"
                               "/lib/libsoup-3.0.so.0"
                               "/lib/libgio-2.0.so.0"
                               "/lib/libjavascriptcoregtk-4.1.so.0"
                               "/lib/libappindicator3.so.1")))
                       ":")))
                (copy-recursively "data/usr/bin" (string-append out "/bin"))
                (copy-recursively "data/usr/lib"
                                  (string-append out "/lib"))
                (copy-recursively "data/usr/share"
                                  (string-append out "/share"))

                ;; The upstream desktop file has a non-canonical name.
                (rename-file
                 (string-append out "/share/applications/Clash Verge.desktop")
                 (string-append out "/share/applications/clash-verge.desktop"))

                ;; The binary release was built for /lib64 and embeds the
                ;; installer-era /tmp/verge IPC directory.  A same-size path
                ;; replacement keeps the ELF layout intact while putting the
                ;; socket below a root-owned /run directory managed by the
                ;; Shepherd service.
                (for-each
                 (lambda (file)
                   ;; sed operates on bytes here; both strings are exactly
                   ;; ten bytes long, so no ELF offsets are shifted.
                   (invoke "sed" "-i" "s|/tmp/verge|/run/cvgeX|g" file))
                 (list program service))
                (for-each
                 (lambda (file)
                   (invoke "patchelf" "--set-interpreter"
                           #$(file-append glibc "/lib/ld-linux-x86-64.so.2")
                           "--set-rpath" rpath file))
                 (list program service))

                ;; These helpers install systemd units and are intentionally
                ;; not exposed by a Guix package with Shepherd integration.
                (delete-file (string-append out "/bin/clash-verge-service-install"))
                (delete-file (string-append out "/bin/clash-verge-service-uninstall"))
                (when tests?
                  (invoke "patchelf" "--print-interpreter" program)
                  (invoke "patchelf" "--print-rpath" program)
                  (invoke "patchelf" "--print-interpreter" service)
                  (invoke "patchelf" "--print-rpath" service))
                (wrap-program program
                  `("XDG_DATA_DIRS" prefix
                    (,(string-append out "/share")
                     #$(file-append gtk+ "/share")
                     #$(file-append gsettings-desktop-schemas "/share")))
                  `("GIO_EXTRA_MODULES" prefix
                    (#$(file-append glib-networking "/lib/gio/modules"))))))))))
    (native-inputs
     (list patchelf))
    (inputs
     `(("glibc" ,glibc)
       ("gcc:lib" ,gcc "lib")
       ("bash-minimal" ,bash-minimal)
       ("gtk+" ,gtk+)
       ("gdk-pixbuf" ,gdk-pixbuf)
       ("cairo" ,cairo)
       ("glib" ,glib)
       ("dbus" ,dbus)
       ("webkitgtk-for-gtk3" ,webkitgtk-for-gtk3)
       ("libsoup" ,libsoup)
       ("libappindicator" ,libappindicator)
       ("kconfig" ,kconfig)
       ("glib-networking" ,glib-networking)
       ("gsettings-desktop-schemas" ,gsettings-desktop-schemas)))
    (supported-systems '("x86_64-linux"))
    (home-page "https://github.com/clash-verge-rev/clash-verge-rev")
    (synopsis "Clash GUI based on Tauri (prebuilt binary)")
    (description
     "Clash Verge Rev is a Tauri-based desktop GUI for Mihomo.  This package
uses the upstream Linux binary release, patches its ELF interpreter and
runtime library search path for Guix, and removes the upstream systemd
installer.  The included Mihomo core remains a static binary.")
    (license license:gpl3)))

clash-verge-rev-bin
