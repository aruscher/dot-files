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
  (core-create-core-definer
   :states '(normal visual insert motion emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC")

  (define-menu
    (menu :prefix "f"
	  :label "File"
	  :entries ((item :prefix "s"
			  :label "Save Buffer"
			  :func save-buffer)
		    (item :prefix "f"
			  :label "Find Files"
			  :func helm-find-files)
		    (item :prefix "j"
			  :label "Dired"
			  :func dired)
		    (item :prefix "t"
			  :label "Neotree"
			  :func neotree-toggle))))
  (define-menu 
    (menu :prefix "b"
	  :label "Buffer"
	  :entries ((item :prefix "p"
			  :label "Previous Buffer"
			  :func previous-buffer)
		    (item :prefix "n"
			  :label "Next Buffer"
			  :func next-buffer)
		    (item :prefix "b"
			  :label "Buffer List"
			  :func helm-buffers-list)
		    (item :prefix "ko"
			  :label "Kill Other Buffer"
			  :func mymacs/kill-other-buffers))))

  (define-menu
    (menu :prefix "w"
	  :label "Window"
	  :entries ((item :prefix "-"
			  :label "Split Window Below"
			  :func split-window-below)
		    (item :prefix "/"
			  :label "Split Window Right"
			  :func split-window-right)
		    (item :prefix "h"
			  :label "Window Left"
			  :func evil-window-left)
		    (item :prefix "j"
			  :label "Window Down"
			  :func evil-window-down)
		    (item :prefix "k"
			  :label "Window Up"
			  :func evil-window-up)
		    (item :prefix "l"
			  :label "Window Right"
			  :func evil-window-right)
		    )))

  (define-menu
    (menu :prefix "q"
	  :label "Quit"
	  :entries ((item :prefix "q"
			  :label "Kill Emacs"
			  :func kill-emacs)
		    (item :prefix "r"
			  :label "Restart Emacs"
			  :func mymacs/restart-emacs))))

  (define-menu
    (menu :prefix "c"
	  :label "Config"
	  :entries ((item :prefix "f"
			  :label "Dired Emacs Directory"
			  :func dired-user-emacs-directory)
		    (item :prefix "c"
			  :label "Dired Core Directory"
			  :func dired-core-directory)
		    (item :prefix "m"
			  :label "Dired Module Directory"
			  :func dired-module-directory))))

  (define-menu
    (menu :prefix "g"
	  :label "Git"
	  :entries ((item :prefix "s"
			  :label "Magit Status"
			  :func magit-status))))

  (define-menu
    (menu :prefix "h"
	  :label "Help"
	  :entries ((item :prefix "i"
			  :label "Info"
			  :func info)
		    (item :prefix "a"
			  :label "Apropos"
			  :func apropros)
		    (item :prefix "v"
			  :label "Describe Variable"
			  :func describe-variable)
		    (item :prefix "m"
			  :label "Describe Mode"
			  :func describe-mode)
		    (item :prefix "k"
			  :label "Describe Key"
			  :func describe-key)
		    (item :prefix "f"
			  :label "Describe Function"
			  :func describe-function))))


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
