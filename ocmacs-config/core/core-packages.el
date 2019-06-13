(defun core-use-packages () 

  (setq use-package-always-ensure t)

  ;; (use-package which-key
  ;;   :config (which-key-mode))

  ;; (use-package general
  ;;   :after which-key
  ;;   :config (general-override-mode))

  ;; (use-package evil
  ;;   :config (evil-mode))

  ;; (use-package evil-magit)

  ;; (use-package evil-commentary
  ;;   :init (evil-commentary-mode))

  ;; (use-package helm
  ;;   :config (progn
  ;; 	      (setq helm-buffers-fuzzy-matching t)
  ;; 	      (helm-mode)))


  (use-package aggressive-indent
    :hook (emacs-lisp-mode . aggressive-indent-mode))

  (use-package monokai-theme
    :config (load-theme 'monokai t))

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))


  (use-package smartparens
    :hook (prog-mode . smartparens-mode)
    :config (require 'smartparens-config)))

(provide 'core-packages)
