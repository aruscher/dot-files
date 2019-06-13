(require 'core-util)

(defvar core-definer-name 'main-definer)
(defvar inner-prefix "")


(defmacro core-create-core-definer (&rest args)
  `(progn
     (general-create-definer ,core-definer-name ,@args)
     (,core-definer-name
      "" 'nil)))

(defmacro core-definer-item (name argument func)
  (let ((prefix-argument (concat %prefix name)))))


(defun core-build-item-entries (prefix items)
  (let (result)
    (dolist (item items result)
      (if (stringp item)
	  (push (concat prefix item) result)
	(push item result)))
    (reverse result)))


(defun menu-entry (args)
  (let* ((prefix (plist-get args :prefix))
	 (parent-prefix (plist-get args :parent-prefix))
	 (menu-prefix (concat parent-prefix prefix))
	 (label (plist-get args :label))
	 (entries (mapcar (lambda (entry)
			    (build-entry (append entry `(:parent-prefix ,menu-prefix))))
			  (plist-get args :entries)))
	 (entries-flat (apply #'append entries))
	 (menu-prefix (concat parent-prefix prefix)))
    `(,menu-prefix '(:ignore t :which-key ,label)
		   ,@entries-flat)))

(defun item-entry (args)
  (let* ((prefix (plist-get args :prefix))
	 (parent-prefix (plist-get args :parent-prefix))
	 (label (plist-get args :label))
	 (func (plist-get args :func))
	 (item-prefix (concat parent-prefix prefix)))
    `(,item-prefix '(,func :which-key ,label))))


(defun build-entry (entry)
  (let ((type (car entry))
	(args (cdr entry)))
    (pcase type
      ('menu (menu-entry args))
      ('item (item-entry args)))))

(defmacro define-menu (menu)
  (let ((entries (build-entry menu)))
    `(,core-definer-name
      ,@entries)))

(defmacro core-definer-menu (prefix item &rest items)
  (let* ((inner-prefix (concat inner-prefix prefix))
	 (item-entries (core-build-item-entries prefix items)))
    `(,core-definer-name
      ,inner-prefix ,item
      ,@item-entries)))

(defun core-init-keymap ()


  (global-set-key (kbd "M-x") 'helm-M-x)

  (ocmacs-define-evil-key-group 'normal neotree-mode-map
				"'" #'neotree-quick-look
				"q" #'neotree-hide
				"RET" #'neotree-enter
				"g" #'neotree-refresh
				"n" #'neotree-next-line
				"p" #'neotree-previous-line
				"a" #'neotree-stretch-toggle
				"h" #'neotree-hidden-file-toggle)

  (ocmacs-define-evil-key-group nil company-active-map
				"C-j" #'company-select-next
				"C-k" #'company-select-previous
				"C-n" #'company-select-next-or-abort
				"C-p" #'company-select-previous-or-abort))

;; (ocmacs-define-evil-key-group nil custom-mode-map
;; 			      "j" #'widget-forward
;; 			      "k" #'widget-backward)

(provide 'core-keymap)
