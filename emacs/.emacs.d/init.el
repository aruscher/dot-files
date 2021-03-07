(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(defalias 'yes-or-no-p 'y-or-n-p) ; Remap yes-or-no to y-or-n

(defalias 'yes-or-no-p 'y-or-n-p) ; Remap yes-or-no to y-or-n
(column-number-mode) ; Show line number and column in the minibuffer
(global-display-line-numbers-mode t) ; Show line numbers on the side
(global-hl-line-mode t) ; Highlight the current line
(show-paren-mode t) ; Show matching parens

(dolist (mode '(term-mode-hook eshell-mode-hook shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 2))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package paredit)

(use-package flycheck
  :defer t)

(defun my/emacs-mode-hook ()
  (paredit-mode t)
  (flycheck-mode)
  (eldoc-mode t))

(use-package emacs-lisp-mode
  :ensure nil
  :hook (emacs-lisp-mode . my/emacs-mode-hook))

(use-package python
  :ensure nil
  :custom
  (python-shell-interpreter "python3"))

(defun my/org-mode-hook ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . my/org-mode-hook))
