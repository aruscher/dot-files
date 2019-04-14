
(defun mymacs/init-theme ()
  (mymacs/install-themes)
  (mymacs/load-theme))

(defun mymacs/install-themes ()
  (use-package dracula-theme
    :ensure t))

(defun mymacs/load-theme ()
  (load-theme 'dracula t))

(provide 'mymacs-theme)
