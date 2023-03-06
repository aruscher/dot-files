

(defun my/next-theme (theme)
  (disable-theme *my/current-theme*)
  (load-theme theme t)
  (setq *my/current-theme* theme))

(defun my/toggle-theme ()
  (interactive)
  (cond
   ((eq *my/current-theme* 'modus-vivendi) (my/next-theme 'modus-operandi))
   ((eq *my/current-theme* 'modus-operandi) (my/next-theme 'modus-vivendi))))


(load-theme *my/current-theme* t)

(global-set-key (kbd "<f12>")
                'my/toggle-theme)
