(defun dired-user-emacs-directory()
  (interactive)
  (dired user-emacs-directory))

(defun dired-core-directory()
  (interactive)
  (dired core-directory))

(defun dired-module-directory()
  (interactive)
  (dired module-directory))

(defun mymacs/restart-emacs(&optional arguments)
  (interactive)
  (restart-emacs arguments))

(defun mymacs/restart-emacs-debug ()
  (interactive)
  (ocmacs/restart-emacs  '("--debug-init")))

(defun mymacs/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


(defun core-ensure-list (list)
  (if (listp list) list
    (list list)))


(provide 'core-util)
