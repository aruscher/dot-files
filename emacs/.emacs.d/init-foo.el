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



(use-package org-super-agenda
  :after org)




(defun my/rebuild-roam-db ()
  (interactive)
  (org-roam-db-clear)
  (org-roam-db-update))



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

(use-package ledger-mode
  :defer t
  :mode ("\\.\\(ledger\\|ldg\\)\\'" . ledger-mode))

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
