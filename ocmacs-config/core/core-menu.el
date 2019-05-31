(require 'core-plist)
(require 'core-util)


(defun core-menu--item-entry (item-arg &optional parent-prefix)
  (let* ((head (car item-arg))
	 (tail (cdr item-arg))
	 (args (core-plist tail))
	 (prefix (plist-get args :prefix))
	 (func (plist-get args :func))
	 (label (plist-get args :label))
	 (entry-prefix (concat parent-prefix prefix)))
    (when (not (equal head 'item))
      (error "Cant parse item-entry: %s" item-arg))
    (when (null prefix)
      (error ":prefix is missing for item-entry: %s" item-arg))
    (when (null func)
      (error ":func is missing for item-entry: %s" item-arg))
    (when (null label)
      (error ":label is missing for item-entry: %s" item-arg))
    `(,entry-prefix (,func :which-key ,label))))

(defun core-menu--menu-entry (menu-arg &optional parent-prefix)
  (let* ((head (car menu-arg))
	 (tail (cdr menu-arg))
	 (args (core-plist tail))
	 (prefix (plist-get args :prefix))
	 (entries (plist-get args :entries))
	 (label (plist-get args :label))
	 (entry-prefix (concat parent-prefix prefix)))
    (when (not (equal head 'menu))
      (error "Cant parse menu-entry: %s" menu-arg))
    (when (null prefix)
      (error ":prefix is missing for menu-entry: %s" item-arg))
    (when (null label)
      (error ":label is missing for menu-entry: %s" item-arg))
    `(,entry-prefix (:ignore t :which-key ,label)
		    ,@(apply #'append
			     (mapcar
			      (lambda (x)
				(core-menu-build x entry-prefix))
			      (if (or (equal (car entries) 'item)
				      (equal (car entries) 'menu))
				  (list entries)
				entries))))))

  (defun core-menu-build (menu-or-item &optional parent-prefix)
    (let ((type (car menu-or-item)))
      (cond
       ((equal type 'menu) (core-menu--menu-entry menu-or-item parent-prefix))
       ((equal type 'item) (core-menu--item-entry menu-or-item parent-prefix))
       (t (error "Cant build menu-or-item: %s" menu-or-item)))))

(provide 'core-menu)
