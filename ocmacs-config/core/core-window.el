(defun core-init-font ()
  (set-face-attribute 'default nil
		      :family "Hack"
		      :height 110
		      :weight 'normal
		      :width 'normal))

(defun core-init-window ()
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (core-init-font))

(provide 'core-window)
