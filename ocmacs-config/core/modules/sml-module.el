(use-package sml-mode
  :ensure t
  :mode ("\\.\\(sml\\|sig\\)\\'" . sml-mode) )


(defun init-sml-module ()
  (message "Init SML Module")
  nil)


(message "SML module loaded")
(add-hook 'sml-mode-hook #'init-sml-module)
(provide 'sml-module)
