(defun init-elisp-module ()
  (message "Elisp module initied")
  (setq show-paren-style 'mixed)
  (setq show-paren-delay 0)
  (show-paren-mode))


(add-hook 'emacs-lisp-mode-hook #'init-elisp-module)
(provide 'elisp-module)
