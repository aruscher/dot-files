;;; Temporarily reduce garbage collection during startup. Inspnect `gcs-done'.
(defun my/reset-gc-cons-threshold ()
  (setq gc-cons-threshold (car (get 'gc-cons-threshold 'standard-value))))
(setq gc-cons-threshold (* 64 1024 1024))
(add-hook 'after-init-hook #'my/reset-gc-cons-threshold)

					; Move custom file to ~/.emacs.d/custom.el

;; Set custom file in user directory
(setq custom-file (concat user-emacs-directory "custom.el"))

;; Load custom file when exists
(when (file-exists-p custom-file)
  (load custom-file))

; Move backup directory to .emacs.d/backups
(defvar my/backup-directory
  (expand-file-name "backups" user-emacs-directory)) 
(setq backup-directory-alist (list (cons "." my/backup-directory)))
