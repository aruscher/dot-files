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

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  :init (global-company-mode t))


(use-package company-quickhelp          ; Documentation popups for Company
  :ensure t
  :init (add-hook 'company-mode-hook #'company-quickhelp-mode))





(message "Use Package Loaded")

(provide 'mymacs-core-packages)
