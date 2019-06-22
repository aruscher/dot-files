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

(defun core-ensure-list-of-list (a-list)
  (if (listp (car a-list))
      a-list
    (list a-list)))


(provide 'core-util)
