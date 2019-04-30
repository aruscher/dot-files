(defun setup-show-paren ()
  (setq show-paren-style 'mixed)
  (setq show-paren-delay 0)
  (show-paren-mode))

(defun setup-elisp-mode-map ()
  ;; (my-local-definer emacs-lisp-mode-map
  ;;   "e" '(:ignore t :which-key "Evaluate")
  ;;   "ee" '(eval-last-sexp :which-key "Evaluate Expression")
  ;;   "eb" '(eval-buffer :which-key "Evaluate Buffer")
  ;;   "er" '(eval-region :which-key "Evaluate Region")
  ;;   "cw" '(paredit-wrap-round :which-key "Wrap Round")))
  nil)

(defun init-elisp-module ()
  (message "Elisp module initied")
  (setup-show-paren)
  (setup-elisp-mode-map))

;; (macroexpand '(core-define-module elisp-module
;; 				  :init (message "ELISP") (message "Foo")
;; 				  :hooks 'foo-hook 'bar-hook))

(add-hook 'emacs-lisp-mode-hook #'init-elisp-module)
(provide 'elisp-module)
