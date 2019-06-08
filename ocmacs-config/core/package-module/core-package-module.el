(defun core-load-package-module (package-symbol)
  (let* ((package-symbol-name (symbol-name package-symbol))
	 (require-name (concat "core-" package-symbol-name "-module"))
	 (require-package-symbol (make-symbol require-name)))
    (require require-package-symbol)))

(defmacro define-package-module (name)
  nil)


(provide 'core-package-module)
