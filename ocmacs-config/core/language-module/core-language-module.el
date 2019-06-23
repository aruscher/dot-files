(require 'core-plist)
(require 'core-menu)
(require 'core-util)
(require 'core-package-module)

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
	 (required-language-modules (plist-get pargs :require-module))
	 (required-package-modules (plist-get pargs :require-package-module))
	 (init (plist-get pargs :init))
	 (menu (plist-get pargs :menu))
	 (hooks (plist-get pargs :hooks))
	 (loadf-name (core-language-loadf-name package-name)))
    `(progn
       (defun ,loadf-name ()
	 ,(when required-language-modules
	    `(core-load-language-modules
	      ,@(core-ensure-list-of-list required-language-modules)))
	 ,(when required-package-modules
	    `(core-load-package-modules
	      ,@(core-ensure-list-of-list required-package-modules)))
	 ,@init
	 (message "Load %s" ',package-name)
	 ,(when  menu
	    `(main-definer
	       ,@(core-menu-build `(menu :prefix "m"
					 :label "Mode"
					 :entries
					 ,@(core-ensure-list-of-list menu))))))

       ,@(core-ensure-list-of-list packages)
       ,@(cl-loop for hook
		  in (core-ensure-list-of-list hooks)
		  collect `(add-hook ,hook #',loadf-name))
       (provide ',(core-language-module-name package-name)))))



(provide 'core-language-module)
