(defun mymacs/open-config ()
  (interactive)
  (find-file mymacs-config-file)) 

(defun mymacs/restart-emacs(&optional arguments)
  (interactive)
  (restart-emacs arguments))

(defun mymacs/restart-emacs-debug ()
  (interactive)
  (ocmacs/restart-emacs  '("--debug-init")))

(provide 'mymacs-util-funcs)
