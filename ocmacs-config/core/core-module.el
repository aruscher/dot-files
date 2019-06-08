(require 'core-keymap)

(defvar core-active-modules '())

(setq core-module-keywords
      '(:init :hooks :mode-keys))

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
	  (setq result (append (list kw (reverse inner-args) result)))
	  (setq inner-args '()))
	(setq kw arg))
       (t
	(push arg inner-args))))
    (append (list kw (reverse inner-args)) result)))

(defun core-args-to-pargs (args)
  (core-build-pargs
   (core-normalize-args args)))

(defun core-build-hooks (init-f-name hooks)
  (let (result)
    (dolist (hook hooks result)
      (push `(add-hook ,hook #',init-f-name) result))))

(defmacro core-define-module (module-name &rest args)
  (let* ((init-f-name (intern (format "init-%s" module-name)))
	 (pargs (core-args-to-pargs args))
	 (init-fs (plist-get pargs :init))
	 (mode-keys (plist-get pargs :mode-key))
	 (hook-adds
	  (core-build-hooks init-f-name
			    (plist-get pargs :hooks))))
    (print pargs)
    `(progn
       (defun ,init-f-name ()
	 (message "Init %s" ',module-name)
	 ,@init-fs)
       (core-definer-menu "m" "Mode"
			  "" 'nil
			  ,@mode-keys)
       ,@hook-adds
       (provide ',module-name))))

(provide 'core-module)
