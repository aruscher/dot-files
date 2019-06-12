(require 'core-plist)
(require 'core-menu)

(defvar core-loaded-package-modules '())

(defun core-require-package-loaded (package-symbol)
  (unless (member package-symbol core-loaded-package-modules)
    (core-load-package-module package-symbol)))

(defun core-load-package-module (package-symbol)
  (require (core-package-module-name package-symbol))
  (funcall (core-package-loadf-name package-symbol))
  (push package-symbol core-loaded-package-modules))

(defun core-load-package-modules (&rest package-symbols)
  (dolist (package-symbol package-symbols)
    (core-load-package-module package-symbol)))

(defun core-package-module-name (package-symbol)
  (intern
   (concat "core-" (symbol-name package-symbol) "-module")))

(defun core-package-loadf-name (package-symbol)
  (intern
   (concat "core-load-" (symbol-name package-symbol) "-module")))


(defun core-ensure-list-of-list (a-list)
  (if (listp (car a-list))
      a-list
    (list a-list)))

(defmacro define-package-module (package-name &rest args)
  (let* ((pargs (core-plist args))
	 (packages (plist-get pargs :packages))
	 (required-packages (plist-get pargs :require))
	 (menu (plist-get pargs :menu))
	 (loadf-name (core-package-loadf-name package-name)))
    `(progn
       (defun ,loadf-name ()
	 (message "Load %s" ',package-name)
	 ,@(cl-loop for requirement
		    in (core-ensure-list-of-list required-packages)
		    collect `(core-require-package-loaded ,requirement))
	 ,@(core-ensure-list-of-list packages)
	 ,(unless (null menu) 
	    `(main-definer
	       ,@(apply #'append
			(cl-loop for menu
				 in (core-ensure-list-of-list menu)
				 collect (core-menu-build menu))))))
       (provide ',(core-package-module-name package-name)))))


(provide 'core-package-module)
