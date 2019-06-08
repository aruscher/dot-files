(defun core-use-packages () 

  (setq use-package-always-ensure t)

  ;; (use-package which-key
  ;;   :config (which-key-mode))

  (use-package general
    :after which-key
    :config (general-override-mode))

  (use-package evil
    :config (evil-mode))

  (use-package evil-magit)

  (use-package evil-commentary
    :init (evil-commentary-mode))

  (use-package helm
    :config (progn
	      (setq helm-buffers-fuzzy-matching t)
	      (helm-mode)))

  (use-package restart-emacs)

  (use-package neotree)

  (use-package magit)

  (use-package aggressive-indent
    :hook (emacs-lisp-mode . aggressive-indent-mode))

  (use-package monokai-theme
    :config (load-theme 'monokai t))

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  (use-package company
    :config (progn
	      (setq company-idle-delay 0)
	      (setq company-minimum-prefix-length 3))
    :init (global-company-mode))

  (use-package company-quickhelp
    :hook (company-mode-hook . company-quickhelp-mode))

  (use-package smartparens
    :hook (prog-mode . smartparens-mode)
    :config (require 'smartparens-config)))

(provide 'core-packages)
