(require 'use-package)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package general
  :ensure t
  :after which-key
  :config
  (general-override-mode 1))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package evil-magit
  :ensure t)

(use-package helm
  :ensure t
  :config
  (setq helm-buffers-fuzzy-matching t)
  (helm-mode 1))

(use-package restart-emacs
  :ensure t)

(use-package neotree
  :ensure t)

(use-package magit
  :ensure t)

(use-package aggressive-indent
  :ensure t
  :hook
  (emacs-lisp-mode . aggressive-indent-mode))


(use-package spacemacs-theme
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(message "Use Package Loaded")

(provide 'mymacs-core-packages)
