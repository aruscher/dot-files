(require 'core-language-module)


(define-language-module elisp
  :require-module 'prog
  :hooks 'emacs-lisp-mode-hook
  :init 
  (setq show-paren-style 'mixed)
  (setq show-paren-delay 0)
  (show-paren-mode))


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

