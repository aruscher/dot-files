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

(use-package evil-commentary
  :ensure t
  :init
  (evil-commentary-mode))

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
  (global-company-mode t))

(use-package company-quickhelp
  :ensure t
  :init
  (add-hook 'company-mode-hook #'company-quickhelp-mode))

;;(use-package parinfer
;;  :ensure t
;;  :init (setq parinfer-extensions '(defaults evil smart-yank))  
;;  :hook (emacs-lisp-mode . parinfer-mode))

;; (use-package paredit
;;   :ensure t
;;   :hook
;;   (
;;    (emacs-lisp-mode . paredit-mode)
;;    ;; enable in the *scratch* buffer
;;    (lisp-interaction-mode . paredit-mode)
;;    (ielm-mode . paredit-mode)
;;    (lisp-mode . paredit-mode)
;;    (eval-expression-minibuffer-setup . paredit-mode)))

;; (use-package evil-paredit
;;   :ensure t
;;   :hook 
;;   (emacs-lisp-mode-hook . evil-paredit-mode))

(message "Use Package Loaded")

(provide 'mymacs-core-packages)
