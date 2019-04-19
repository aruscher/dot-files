(defun mymacs/init-sml-mode ()
  (mymacs/use-package-sml-mode)
  )

(defun mymacs/use-package-sml-mode ()
  (use-package sml-mode
    :mode ("\\.\\(sml\\|sig\\)\\'" . sml-mode)
    ))







(provide 'sml-module)
