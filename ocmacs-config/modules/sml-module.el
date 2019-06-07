
(use-package sml-mode
  :ensure t
  :mode ("\\.\\(sml\\|sig\\)\\'" . sml-mode))

(require 'sml-mode)
(setq sml-program-name "smlnj")

(defun init-sml-module ()
  (message "Init SML Module")
  (setup-sml-mode-map))

(defun setup-sml-mode-map ()
  ;; (main-definer sml-mode-map
  ;;   "me" '(:ignore t :which-key "Evaluate")
  ;;   "mee" '(:which-key "Evaluate Expression")
  ;;   "meb" '(sml-send-buffer :which-key "Evaluate Buffer")
  ;;   "mer" '(sml-send-region :which-key "Evaluate Region")
  ;;   ))
  nil)


(message "SML module loaded")
(add-hook 'sml-mode-hook #'init-sml-module)
(provide 'sml-module)
