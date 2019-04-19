(defun mymacs/open-config ()
  (interactive)
  (find-file mymacs-config-file)) 

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

(provide 'mymacs-util-funcs)
