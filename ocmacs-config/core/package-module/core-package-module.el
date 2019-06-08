(require 'core-plist)

(defun core-load-package-module (package-symbol)
  (require (core-package-module-name package-symbol)))

(defun core-package-module-name (package-symbol)
  (intern
   (concat "core-" (symbol-name package-symbol) "-module")))

(defun core-ensure-list-of-list (a-list)
  (if (listp (car a-list))
      a-list
    (list a-list)))

(defmacro define-package-module (package-name &rest args)
  (let* ((pargs (core-plist args))
	 (packages (plist-get pargs :packages)))
    `(progn
       ,@(core-ensure-list-of-list packages)
       (provide ',(core-package-module-name package-name)))))


(provide 'core-package-module)
