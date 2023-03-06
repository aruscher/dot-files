(use-package paredit)

(add-hook 'lisp-mode-hook
          (lambda ()
	    (enable-paredit-mode)))
