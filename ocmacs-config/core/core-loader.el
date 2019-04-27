(defun use-module (module)
  (require module))

(defun use-modules (&rest modules)
  (dolist (module modules)
    (use-module module)))


(setq gc-cons-threshold 100000000)
(setq delete-old-versions -1 )		
(setq version-control t )		
(setq vc-make-backup-files t )
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) 
(setq vc-follow-symlinks t )				       
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) 
(setq inhibit-startup-screen t )	
(setq ring-bell-function 'ignore )	
(setq coding-system-for-read 'utf-8 )	
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	
(setq default-fill-column 80)		
(setq initial-scratch-message "Welcome in Emacs")

(setq custom-file "~/.emacs.d/.emacs-custom.el")
(unless (file-exists-p custom-file)
	(with-temp-buffer (write-file custom-file)))

(load custom-file)

(require 'mymacs-window)
(require 'mymacs-font)
(require 'mymacs-package-setup)
(require 'core-packages)
(require 'core-keymap)

(use-modules 'elisp-module 'sml-module)

(provide 'core-loader)

