(defun setup-show-paren ()
  (setq show-paren-style 'mixed)
  (setq show-paren-delay 0)
  (show-paren-mode))

(defun setup-elisp-mode-map ()
  (main-definer emacs-lisp-mode-map
    "me" '(:ignore t :which-key "Evaluate")
    "mee" '(eval-last-sexp :which-key "Evaluate Expression")
    "meb" '(eval-buffer :which-key "Evaluate Buffer")
    "mer" '(eval-region :which-key "Evaluate Region")
    "mcw" '(paredit-wrap-round :which-key "Wrap Round")))

(defun init-elisp-module ()
  (message "Elisp module initied")
  (setup-show-paren)
  (setup-elisp-mode-map))



(add-hook 'emacs-lisp-mode-hook #'init-elisp-module)
(provide 'elisp-module)
