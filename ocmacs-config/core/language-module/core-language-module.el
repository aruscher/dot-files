(require 'core-plist)
(require 'core-util)

(defvar core-loaded-language-modules '())

(defun core-load-language-module (package-symbol)
  (unless (member package-symbol core-loaded-language-modules)
    (require (core-language-module-name package-symbol))
    (funcall (core-language-loadf-name package-symbol))
    (push package-symbol core-loaded-language-modules)))

(defun core-load-language-modules (&rest package-symbols)
  (dolist (package-symbol package-symbols)
    (core-load-language-module package-symbol)))

(defun core-language-module-name (package-symbol)
  (intern
   (format "%s-module" (symbol-name package-symbol))))

(defun core-language-loadf-name (package-symbol)
  (intern
   (format "load-%s" (core-language-module-name package-symbol))))


(defmacro define-language-module (package-name &rest args)
  (let* ((pargs (core-plist args))
	 (packages (plist-get pargs :packages))
	 (required-modules (plist-get pargs :require-module))
	 (init (plist-get pargs :init))
	 (hooks (plist-get pargs :hooks))
	 (loadf-name (core-language-loadf-name package-name)))
    `(progn
       (defun ,loadf-name ()
	 ,(when required-modules
	    `(core-load-language-modules
	      ,@(core-ensure-list-of-list required-modules)))
	 ,@init)
	 (message "Load %s" ',package-name)
       ,@(cl-loop for hook
		  in (core-ensure-list-of-list hooks)
		  collect `(add-hook ,hook #',loadf-name))
       (provide ',(core-language-module-name package-name)))))



(provide 'core-language-module)
