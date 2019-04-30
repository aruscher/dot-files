(defvar core-active-modules '())

(setq core-module-keywords
      '(:init :foo))


(defun core-use-module (module)
  (require module)
  (push module core-active-modules))

(defun core-use-modules (&rest modules)
  (dolist (module modules)
    (core-use-module module)))

(defun core-normalize-args (args)
  (let ((result args))
    (dolist (keyword core-module-keywords)
      (unless (plist-get args keyword)
	(push keyword result)))
    result))

(defun core-build-pargs (args)
  (let ((result '())
	(kw nil)
	(inner-args '()))
    (dolist (arg args)
      (cond
       ((keywordp arg)
	(when kw
	  (setq result (append (list kw inner-args) result))
	  (setq inner-args '()))
	(setq kw arg))
       (t (push arg inner-args))))
    (append (list kw inner-args) result)))

(defun core-args-to-pargs (args)
  (core-build-pargs
   (core-normalize-args args)))

(defmacro core-define-module (module-name &rest args)
  (let ((init-f-name (intern (format "init-%s" module-name)))
	(pargs (core-args-to-pargs args)))
    (message "%s" pargs)
    `(progn
       (defun ,init-f-name ()
	 (message "Init %s" ',module-name)
	 ,@(plist-get pargs :init))
       ,@(let (result)
	   (dolist (hook (plist-get pargs :hooks) result)
	     (push (list 'add-hook hook `#',init-f-name) result)))
       (provide ',module-name))))




(provide 'core-module)
