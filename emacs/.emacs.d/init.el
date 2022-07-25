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
;;; Stupid fix?
(straight-use-package 'project)
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

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-k") 'eval-buffer)))

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
  :config
  (setq python-indent-guess-indent-offset-verbose nil)
  (cond
   ((executable-find "python3")
    (setq python-shell-interpreter "python3"))
   (t
    (setq python-shell-interpreter "python"))))

(use-package graphviz-dot-mode
  :config
  (setq graphviz-dot-indent-width 4))



(defvar my-org-roam-directory "~/Zettelkasten/zettels")
(defvar my-org-roam-dailies-directory "~/Zettelkasten/dailies")
(defvar my-org-bibliography-file "~/Zettelkasten/bibliography.bib")
(defvar my-agenda-files (list "~/Zettelkasten/work.org"))

(defun my/org-mode-hook ()
  (org-indent-mode)
  (visual-line-mode 1))

(defun my/disable-emacs-checkdoc ()
  (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package org
  :hook  ((org-mode . my/org-mode-hook)
          (org-src-mode . my/disable-emacs-checkdoc))
  :config
  (setq org-agenda-start-with-log-mode t
        org-log-done 'time
        org-log-into-drawer t)
  (setq org-agenda-files my-agenda-files)
  (setq org-cite-global-bibliography (list my-org-bibliography-file))
  (setq bibtex-completion-bibliography (list my-org-bibliography-file))
  (org-babel-do-load-languages 'org-babel-load-languages'((dot . t))) )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org-super-agenda
  :after org)

(use-package hide-mode-line
  :ensure t)

(defun my/org-tree-slide-setup ()
  (org-display-inline-images)
  (hide-mode-line-mode 1))

(defun my/org-tree-slide-end ()
  (org-display-inline-images)
  (hide-mode-line-mode 0))

(use-package org-tree-slide
  :ensure t
  :defer t
  :custom
  (org-image-actual-width nil)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  :hook ((org-tree-slide-play . my/org-tree-slide-setup)
         (org-tree-slide-stop . my/org-tree-slide-end))
  :bind (:map org-tree-slide-mode-map
              ("C-<" . org-tree-slide-move-previous-tree)
              ("C->" . org-tree-slide-move-next-tree)))

(use-package emacsql-sqlite)

(defun my/rebuild-roam-db ()
  (interactive)
  (org-roam-db-clear)
  (org-roam-db-update))


(use-package org-roam
  :straight (:package "org-roam" :host github
                      :type git :repo "org-roam/org-roam" :branch "master")
  :init (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory my-org-roam-directory)
  (org-roam-dailies-directory my-org-roam-dailies-directory)
  (org-roam-file-extensions '("org"))
  (org-roam-node-display-template "${title:*} ${tags:30}")
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n g" . org-roam-graph)
         ("C-c n s" . org-roam-db-sync)
         ("C-c n l" . org-roam-buffer-toggle))
  :bind-keymap ("C-c n d" . org-roam-dailies-map)
  :hook (after-init . org-roam-setup)
  :config
  (require 'org-roam-dailies)
  (setq org-roam-dailies-capture-templates
        '(("d" "default" plain
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org.gpg"
                              "#+title: %<%Y-%m-%d>\n")))))

(use-package org-roam-bibtex
  :after org-roam
  ;; :config
  ;; (require 'org-ref)
  )

(use-package auctex
 :defer t
 :config
 (setq TeX-auto-save t)
 (setq TeX-parse-self t)
 (setq-default TeX-master nil))

(use-package company-auctex
  :after (company auctex)
  :config
  (company-auctex-init))

(use-package gnuplot-mode
  :mode ("\\.p\\'" "\\.gp\\'" "\\.gnuplot\\'")
  :init
  (setq gnuplot-program "gnuplot")
  :config
  (autoload 'gnuplot-mode        "gnuplot" "Gnuplot major mode"            t )
  (autoload 'gnuplot-make-buffer "gnuplot" "Open a buffer in gnuplot-mode" t ))



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

(when (file-exists-p "~/Code/Emacs-Lisp/book-thing")
  (use-package book-thing
    :straight (book-thing :local-repo "~/Code/Emacs-Lisp/book-thing")))
