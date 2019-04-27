(defun core-use-module (module)
  (require module))

(defun core-use-modules (&rest modules)
  (dolist (module modules)
    (core-use-module module)))


(setq gc-cons-threshold 100000000)
(setq delete-old-versions -1 )		
(setq version-control t )		
(setq vc-make-backup-files t )
(setq backup-directory-alist
      `(("." . ,my-backup-directory)))
(setq vc-follow-symlinks t )				       
(setq auto-save-file-name-transforms
      `((".*" ,my-auto-save-directory t))) 
(setq inhibit-startup-screen t )	
(setq ring-bell-function 'ignore )	
(setq coding-system-for-read 'utf-8 )	
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	
(setq default-fill-column 80)		
(setq initial-scratch-message "Welcome in Emacs")


(require 'core-custom-file)

(defun core-init ()
  (core-load-custom-file))



(require 'mymacs-window)
(require 'mymacs-font)
(require 'mymacs-package-setup)
(require 'core-packages)
(require 'core-keymap)

(core-use-modules 'elisp-module 'sml-module)

(provide 'core-loader)

