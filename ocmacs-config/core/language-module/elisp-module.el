(require 'core-language-module)


(define-language-module elisp
  :require-module 'prog
  :packages 
  (use-package aggressive-indent
    :ensure t)
  (use-package paredit
    :ensure t)
  (use-package evil-paredit
    :ensure t
    :hook (emacs-lisp-mode-hook . evil-paredit-mode))
  :hooks 'emacs-lisp-mode-hook
  :init
  (aggressive-indent-mode)
  (setq show-paren-style 'parenthesis)
  (setq show-paren-delay 0)
  (show-paren-mode)
  :menu
  (item :prefix "'"
	:label "IElm"
	:func ielm)
  (menu :prefix "e"
	:label "Evaluate"
	:entries
	(item :prefix "e"
	      :label "Last Expression"
	      :func eval-last-sexp)
	(item :prefix "b"
	      :label "Buffer"
	      :func eval-buffer)
	(item :prefix "f"
	      :label "Defun"
	      :func eval-defun)))



;; (defun setup-elisp-mode-map ()
;;   ;; (my-local-definer emacs-lisp-mode-map
;;   ;;   "e" '(:ignore t :which-key "Evaluate")
;;   ;;   "ee" '(eval-last-sexp :which-key "Evaluate Expression")
;;   ;;   "eb" '(eval-buffer :which-key "Evaluate Buffer")
;;   ;;   "er" '(eval-region :which-key "Evaluate Region")
;;   ;;   "cw" '(paredit-wrap-round :which-key "Wrap Round")))
;;   nil)

;; (macroexpand
;;  '(core-define-module elisp-module
;; 		      :init
;; 		      (setq show-paren-style 'mixed)
;; 		      (setq show-paren-delay 0)
;; 		      (show-paren-mode)
;; 		      :hooks 'emacs-lisp-mode-hook
;; 		      :mode-key
;; 		      "e" '(:ignore t :which-key "Evaluate")
;; 		      "ee" '(eval-last-sexp :which-key "Expression")))

;; (core-define-module elisp-module
;; 		    :init
;; 		    (setq show-paren-style 'mixed)
;; 		    (setq show-paren-delay 0)
;; 		    (show-paren-mode)
;; 		    :hooks 'emacs-lisp-mode-hook)


