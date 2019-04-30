(defvar core-active-modules '())

(defun core-use-module (module)
  (require module)
  (push module core-active-modules))

(defun core-use-modules (&rest modules)
  (dolist (module modules)
    (core-use-module module)))

(defun core-build-arg-list (args)
  (let ((result '())
	(kw nil)
	(inner-args '()))
    (dolist (arg args)
      (cond
       ((keywordp arg)
	(setq kw arg))
       (t (push arg inner-args))))
    result))

(defmacro core-define-module (module-name &rest args)
  (let ((init-f-name (intern (format "init-%s" module-name)))
	(arg-list (core-build-arg-list args)))
    (message "%s" arg-list)
    `(let ((init-f (lambda () ,args)))
       (provide ',module-name))))




(provide 'core-module)
