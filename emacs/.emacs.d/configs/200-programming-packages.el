(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 2))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :config
  (setq-default flycheck-emacs-lisp-initialize-packages t
                flycheck-highlighting-mode 'lines
                flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-display-errors-function
        #'flycheck-display-error-messages-unless-error-list))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))
