(defun core-use-packages () 

  (setq use-package-always-ensure t)

  (use-package aggressive-indent
    :hook (emacs-lisp-mode . aggressive-indent-mode))


  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  (use-package smartparens
    :hook (prog-mode . smartparens-mode)
    :config (require 'smartparens-config)))

(provide 'core-packages)
