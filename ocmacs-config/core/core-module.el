(defvar core-active-modules '())

(defun core-use-module (module)
  (require module)
  (push module core-active-modules))

(defun core-use-modules (&rest modules)
  (dolist (module modules)
    (core-use-module module)))


(defmacro core-define-module (module-name &rest args)
  (let ((init-f-name (intern (format "init-%s" module-name))))
    `(progn
       (message ,args)
       (defun ,init-f-name ()
	 ,(plist-get args :init))
       (provide ',module-name))))




(provide 'core-module)
