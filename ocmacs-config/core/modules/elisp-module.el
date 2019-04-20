
(defun init-elisp-module ()
  (message "Elisp Module loaded")
  (show-paren-mode))




(add-hook 'emacs-lisp-mode-hook #'init-elisp-module)

(provide 'elisp-module)
