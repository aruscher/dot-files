(defun setup-elisp-mode-map ()
  ;; (my-local-definer emacs-lisp-mode-map
  ;;   "e" '(:ignore t :which-key "Evaluate")
  ;;   "ee" '(eval-last-sexp :which-key "Evaluate Expression")
  ;;   "eb" '(eval-buffer :which-key "Evaluate Buffer")
  ;;   "er" '(eval-region :which-key "Evaluate Region")
  ;;   "cw" '(paredit-wrap-round :which-key "Wrap Round")))
  nil)


(core-define-module elisp-module
		    :init
		    (setq show-paren-style 'mixed)
		    (setq show-paren-delay 0)
		    (show-paren-mode)
		    :hooks 'emacs-lisp-mode-hook)

