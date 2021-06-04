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

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

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

(use-package dashboard
  :config
  (setq dashboard-startup-banner nil)
  (setq dashboard-items
        '((recents . 5)
          (projects .5)))
  (dashboard-setup-startup-hook))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :diminish
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

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package projectile
  :diminish projectile
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path
        (seq-filter #'file-directory-p '("~/Code/Python" "~/Code/Common-Lisp")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit)

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
  :ensure t
  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury))
  :config
  (setq elfeed-db-directory "~/Dropbox/shared/elfeeddb"))

(use-package elfeed-org
  :ensure t
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files
        (list "~/.emacs.d/feeds.org")))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 2))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package paredit)

(use-package flycheck
  :defer t
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
  :ensure nil
  :hook (emacs-lisp-mode . my/emacs-mode-hook))

(use-package sly
  :hook ((lisp-mode . sly-editing-mode)
         (sly-mrepl-mode . company-mode))
  :config
  (setq inferior-lisp-program "sbcl")
  (sly-setup))

(use-package sly-macrostep
  :ensure t)

(use-package python
  :ensure nil
  :custom
  (python-shell-interpreter "python3"))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred))))

(defun my/cargo-run ()
  "Build and run Rust code."
  (interactive)
  (rustic-cargo-run)
  (let ((orig-win (selected-window))
        (run-win (display-buffer (get-buffer "*rustic-compilation*") nil 'visible)))
    (select-window run-win)
    (comint-mode)
    (read-only-mode 0)
    (select-window orig-win)))

(use-package rustic
  :bind (:map rustic-mode-map
              ("C-c r" . my/cargo-run))
  :hook (rust-mode . lsp)
  :config (setq rustic-format-on-save t)
  :custom (lsp-rust-analyzer-cargo-watch-command "clippy"))

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4))

(defun my/org-mode-hook ()
  (org-indent-mode)
  (visual-line-mode 1))

(defvar my-org-directory "~/ORG-MyLife")
(defvar my-org-todo-file "~/ORG-MyLife/todos.org")
(defvar my-org-roam-directory "~/ORG-MyLife/roam")
(defvar my-org-bibliography-file "~/ORG-MyLife/bibliography.bib")

(defun my/disable-emacs-checkdoc ()
  (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package org
  :hook  ((org-mode . my/org-mode-hook)
          (org-src-mode . my/disable-emacs-checkdoc))
  :config
  (setq org-directory my-org-directory)
  (setq org-agenda-files (list my-org-todo-file))

  (setq org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t)

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline my-org-todo-file "Tasks")
                                 "* TODO %i%?")))
  (org-babel-do-load-languages 'org-babel-load-languages'((dot . t))) )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org-roam-bibtex)

(use-package org-ref
  :config
  (setq org-ref-default-bibliography (list my-org-bibliography-file)
        bibtex-completion-bibliography (list my-org-bibliography-file)))

(defun my/rebuild-roam-db ()
  (interactive)
  (org-roam-db-clear)
  (org-roam-db-update))

(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory my-org-roam-directory)
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph)
               ("C-c n r" . my/rebuild-roam-db))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(defun my/open-config ()
  (interactive)
  (find-file (expand-file-name "Emacs.org" user-emacs-directory)))
