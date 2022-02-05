;;; Temporarily reduce garbage collection during startup. Inspnect `gcs-done'.
(defun my/reset-gc-cons-threshold ()
  (setq gc-cons-threshold (car (get 'gc-cons-threshold 'standard-value))))
(setq gc-cons-threshold (* 64 1024 1024))
(add-hook 'after-init-hook #'my/reset-gc-cons-threshold)

;;; Temporarily disable the file name handler.
(setq default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(defun my/reset-file-name-handler-alist ()
  (setq file-name-handler-alist
        (append default-file-name-handler-alist
                file-name-handler-alist))
  (cl-delete-duplicates file-name-handler-alist :test 'equal))
(add-hook 'after-init-hook #'my/reset-file-name-handler-alist)

; Move backup directory to .emacs.d/backups
(defvar my/backup-directory
  (expand-file-name "backups" user-emacs-directory)) 
(setq backup-directory-alist (list (cons "." my/backup-directory)))

                                        ; Move custom file to ~/.emacs.d/custom.el
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(defalias 'yes-or-no-p 'y-or-n-p) ; Remap yes-or-no to y-or-n

(column-number-mode) ; Show line number and column in the minibuffer
(global-display-line-numbers-mode t) ; Show line numbers on the side
(global-hl-line-mode t) ; Highlight the current line
(show-paren-mode t) ; Show matching parens

;; Don't show line numbers in shell-modes
(dolist (mode '(term-mode-hook eshell-mode-hook shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Automatically tangle our Emacs.org config file when we save it
(defun my/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (file-truename (expand-file-name user-emacs-directory)))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'my/org-babel-tangle-config)))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(set-face-attribute 'default nil
                    :family "Fira Code Retina"
                    :height 110
                    :weight 'normal
                    :width 'normal)

(set-face-attribute 'fixed-pitch nil
                    :family "Fira Code Retina"
                    :height 110
                    :weight 'normal
                    :width 'normal)

(use-package doom-themes
  :config (load-theme 'doom-palenight t))

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :init
  (unless (find-font (font-spec :name "all-the-icons"))
    (all-the-icons-install-fonts t)))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; (use-package dashboard
;;   :config
;;   (setq dashboard-startup-banner nil)
;;   (setq dashboard-items
;;         '((recents . 5)
;;           (projects .5)))
;;   (dashboard-setup-startup-hook))

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :bind (("C-s" . swiper-isearch)
         ("M-x" . counsel-M-x)
         ("C-h a" . counsel-apropos)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package smex)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defvar my/project-directories
  '("~/Code/Python/" "~/Code/Common-Lisp/"))

(use-package projectile
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path (seq-filter #'file-directory-p my/project-directories))
  (setq projectile-switch-project-action #'projectile-dired)
  (projectile-mode +1))

;; (use-package magit)
(straight-use-package 'magit)

(defun bjm/elfeed-load-db-and-open ()
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

(defun bjm/elfeed-save-db-and-bury ()
  (interactive)
  (elfeed-db-save)
  (elfeed-db-compact)
  (quit-window))

(defun bjm/elfeed-mark-all-as-read ()
  (interactive)
  (mark-whole-buffer)
  (elfeed-search-untag-all-unread))

(use-package elfeed
  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury))
  :config
  (setq elfeed-db-directory "~/Generic-Share/shared/elfeeddb"))

(use-package elfeed-org
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files
        (list "~/.emacs.d/feeds.org")))

(use-package esup
  :config
  (setq esup-depth 0))

(setq epa-file-select-keys nil
      epa-file-cache-passphrase-for-symmetric-encryption t
      epa-pinentry-mode 'loopback)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 2))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package paredit)

(use-package flycheck
  :hook (prog-mode . flycheck-mode)
  :config
  (setq-default flycheck-emacs-lisp-initialize-packages t
                flycheck-highlighting-mode 'lines
                flycheck-emacs-lisp-load-path 'inherit))

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

(defun my/lisp-mode-hook ()
  (enable-paredit-mode))

(add-hook 'lisp-mode-hook
          #'my/lisp-mode-hook)

(defun my/emacs-mode-hook ()
  (paredit-mode t)
  (flycheck-mode)
  (eldoc-mode t))

(use-package emacs-lisp-mode
  :straight nil
  :hook (emacs-lisp-mode . my/emacs-mode-hook))

(use-package sly
  :hook ((lisp-mode . sly-editing-mode)
         (sly-mrepl-mode . company-mode)
         (sly-mrepl-mode . paredit-mode))
  :config
  (setq inferior-lisp-program "sbcl")
  (sly-setup))

(use-package sly-macrostep
  :ensure t)

;; (when (file-exists-p "~/quicklisp/log4sly-setup.el")
;;   (load "~/quicklisp/log4sly-setup.el")
;;   (global-log4sly-mode 1))

(use-package python
  :ensure nil
  :custom
  (python-shell-interpreter "python3"))

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4))



(defun my/org-mode-hook ()
  (org-indent-mode)
  (visual-line-mode 1))

(defun my/disable-emacs-checkdoc ()
  (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package org
  :hook  ((org-mode . my/org-mode-hook)
	  (org-src-mode . my/disable-emacs-checkdoc)))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package emacsql-sqlite)

(use-package hide-mode-line
  :ensure t)

(defun my/org-tree-slide-setup ()
  (org-display-inline-images)
  (hide-mode-line-mode 1))

(defun my/org-tree-slide-end ()
  (org-display-inline-images)
  (hide-mode-line-mode 0))

(use-package org-super-agenda
  :after org)



(use-package pdf-tools
  :defer 2
  :config (pdf-tools-install)
  :hook (pdf-view-mode . (lambda () (display-line-numbers-mode nil))))

(use-package pdf-view-restore
  :after pdf-tools
  :hook(pdf-view-mode 'pdf-view-restore-mode))

(defun my/open-config ()
  (interactive)
  (find-file (expand-file-name "Emacs.org" user-emacs-directory)))
