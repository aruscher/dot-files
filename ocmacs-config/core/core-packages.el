(require 'use-package)
(setq use-package-always-ensure t)

(defun core-use-package (name &rest args)
  (progn `(use-package ,name
	    ,@args)
	 (message "foo")))


(defvar core-packages
  '((which-key
     :config (which-key-mode))
    (general
     :after which-key
     :config (general-override-mode))
    (evil
     :config (evil-mode))
    (evil-magit)
    (evil-commentary
     :init (evil-commentary-mode))
    (helm
     :config (progn
	       (setq helm-buffers-fuzzy-matching t)
	       (helm-mode)))
    (restart-emacs)
    (neotree)
    (magit)
    (aggressive-indent
     :hook (emacs-lisp-mode . aggressive-indent-mode))
    (monokai-theme
     :config (load-theme 'monokai t))
    (rainbow-delimiters
     :hook (prog-mode . rainbow-delimiters-mode))
    (company
     :config (progn
	       (setq company-idle-delay 0)
	       (setq company-minimum-prefix-length 3))
     :init (global-company-mode))
    (company-quickhelp
     :init (add-hook 'company-mode-hook #'company-quickhelp-mode))
    (smartparens
     :hook (prog-mode . smartparens-mode)
     :config (require 'smartparens-config))))


(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package general
  :ensure t
  :after which-key
  :config
  (general-override-mode))

(use-package evil
  :ensure t
  :config
  (evil-mode))

(use-package evil-magit
  :ensure t)

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode))

(use-package helm
  :ensure t
  :config
  (setq helm-buffers-fuzzy-matching t)
  (helm-mode))

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

(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

(use-package rainbow-delimiters
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package company
  :ensure t
  :config
  (progn
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 3))
  :init
  (global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (add-hook 'company-mode-hook #'company-quickhelp-mode))

(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config))

(provide 'core-packages)
