(defun core-plist (cplist)
  (if (null cplist) '()
    (let* ((predicate (lambda (x) (not (keywordp x))))
	   (head (car cplist))
	   (tail (cdr cplist))
	   (arguments (seq-take-while predicate tail))
	   (rest (seq-drop-while predicate tail)))
      (if (= (length arguments) 1)
	  (append `(,head ,@arguments) (core-plist rest))
	(append `(,head ,arguments) (core-plist rest))))))


(provide 'core-plist)
