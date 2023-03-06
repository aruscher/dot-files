(use-package projectile
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path
	(seq-filter #'file-directory-p my/project-directories))
  (setq projectile-switch-project-action #'projectile-dired)
  (projectile-mode +1))
