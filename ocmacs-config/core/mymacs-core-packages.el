(defun mymacs/init-core-packages ()
  (use-package which-key
    :ensure t
    :config (which-key-mode))

  (use-package general
    :ensure t
    :after which-key
    :config
    (general-override-mode 1))

  (use-package evil
    :ensure t
    :config (evil-mode 1))

  (use-package evil-magit
    :ensure t)
  
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
    :ensure t
    )

  (use-package aggressive-indent
    :ensure t
    :hook (emacs-lisp-mode . aggressive-indent-mode)
    )
  (use-package parinfer
    :ensure t
    :hook (
	   (clojure-mode . parinfer-mode)
	   (emacs-lisp-mode . parinfer-mode)
	   (common-lisp-mode . parinfer-mode)
	   (lisp-mode-mode . parinfer-mode)
	   (scheme-mode-hook . parinfer-mode))
    :init
    (progn
      (setq parinfer-extensions
	    '(defaults 
	       pretty-parens 
	       evil          
	       smart-yank))   
      )))




(provide 'mymacs-core-packages)
