(defun core-use-module (module)
  (require module))

(defun core-use-modules (&rest modules)
  (dolist (module modules)
    (core-use-module module)))



(provide 'core-module)
