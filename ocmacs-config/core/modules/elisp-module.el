
(defun init-elisp-module ()
  (setq show-paren-style 'mixed)
  (setq show-paren-delay 0)
  (show-paren-mode))

(add-hook 'emacs-lisp-mode-hook #'init-elisp-module)
(message "Elisp module loaded")
(provide 'elisp-module)
