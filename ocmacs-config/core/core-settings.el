(require 'core-special-directories)

(defun core-settings-default ()
  (setq gc-cons-threshold 100000000)
  (setq delete-old-versions -1 )		
  (setq version-control t )		
  (setq vc-make-backup-files t )
  (setq backup-directory-alist
	`(("." . ,core-backup-directory)))
  (setq vc-follow-symlinks t )				       
  (setq auto-save-file-name-transforms
	`((".*" ,core-auto-save-directory t))) 
  (setq inhibit-startup-screen t )	
  (setq ring-bell-function 'ignore )	
  (setq coding-system-for-read 'utf-8 )	
  (setq coding-system-for-write 'utf-8 )
  (setq sentence-end-double-space nil)	
  (setq default-fill-column 80)		
  (setq initial-scratch-message "Welcome in Emacs"))


(defun core-settings-startup ()
  nil)

(provide 'core-settings)
