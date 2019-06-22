(require 'core-plist)
(require 'core-menu)
(require 'core-util)

(defvar core-loaded-package-modules '())

(defun core-load-package-module (package-symbol)
  (unless (member package-symbol core-loaded-package-modules)
    (require (core-package-module-name package-symbol))
    (funcall (core-package-loadf-name package-symbol))
    (push package-symbol core-loaded-package-modules)))

(defun core-load-package-modules (&rest package-symbols)
  (dolist (package-symbol package-symbols)
    (core-load-package-module package-symbol)))

(defun core-package-module-name (package-symbol)
  (intern
   (format "core-%s-module" (symbol-name package-symbol))))

(defun core-package-loadf-name (package-symbol)
  (intern
   (format "load-%s" (core-package-module-name package-symbol))))

(defun core-ensure-list-of-list (a-list)
  (if (listp (car a-list))
      a-list
    (list a-list)))

(defmacro define-package-module (package-name &rest args)
  (let* ((pargs (core-plist args))
	 (packages (plist-get pargs :packages))
	 (required-modules (plist-get pargs :require-module))
	 (menu (plist-get pargs :menu))
	 (menu-definer (plist-get pargs :menu-definer))
	 (loadf-name (core-package-loadf-name package-name)))
    `(progn
       (defun ,loadf-name ()
	 ,(when required-modules
	    `(core-load-package-modules
	      ,@(core-ensure-list-of-list required-modules)))
	 (message "Load %s" ',package-name)
	 ,@(core-ensure-list-of-list packages)
	 ,(unless (null menu) 
	    `(,menu-definer
	      ,@(apply #'append
		       (cl-loop for menu
				in (core-ensure-list-of-list menu)
				collect (core-menu-build menu))))))
       (provide ',(core-package-module-name package-name)))))


(provide 'core-package-module)
