(setq sml-program-name "smlnj")

(use-package sml-mode
  :ensure t
  :mode ("\\.\\(sml\\|sig\\)\\'" . sml-mode))

(defun init-sml-module ()
  (message "Init SML Module")
  (setup-mode-map))

(defun setup-mode-map ()
  (main-definer
    "me" '(:ignore t :which-key "Evaluate")
    "mee" '(:which-key "Evaluate Expression")
    "meb" '(sml-send-buffer :which-key "Evaluate Buffer")
    "mer" '(sml-send-region :which-key "Evaluate Region")
    ))


(message "SML module loaded")
(add-hook 'sml-mode-hook #'init-sml-module)
(provide 'sml-module)
