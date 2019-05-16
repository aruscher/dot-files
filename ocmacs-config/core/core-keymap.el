(require 'core-util)
(require 'general)
(require 'neotree)
(require 'magit)
(require 'evil)
(require 'restart-emacs)

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


;; (setq test-menu 
;;       '(:type menu
;; 	      :prefix "a"
;; 	      :label "Files"
;; 	      :entries ((:type item
;; 			       :prefix "b"
;; 			       :label "foo")
;; 			(:type menu
;; 			       :prefix "c"
;; 			       :label "C"
;; 			       :entries ((:type item
;; 						:prefix "d"
;; 						:label "D"))))))

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
  
  ;; (core-definer-menu
  ;;  "f" '(:ignore t :which-key "File")
  ;;  "s" '(save-buffer :which-key "Save Buffer")
  ;;  "f" '(helm-find-files :which-key "Find Files")
  ;;  "j" '(dired :which-key "Dired") 
  ;;  "t" '(neotree-toggle :which-key "Neotree"))

  ;; (core-definer-menu
  ;;  "b" '(:ignore t :which-key "Buffer")
  ;;  "p" '(previous-buffer :which-key "Previous Buffer")
  ;;  "n" '(next-buffer :which-key "Next Buffer")
  ;;  "b" '(helm-buffers-list :which-key "Buffer List")
  ;;  "ko" '(mymacs/kill-other-buffers :which-key "Kill Other Buffers"))

  (core-definer-menu
   "w" '(:ignore t :which-key "Window")
   "-" '(split-window-below :which-key "Split Window Below")
   "/" '(split-window-right :which-key "Split Window Right")
   "h" '(evil-window-left :which-key "Window Left")
   "j" '(evil-window-down :which-key "Window Down")
   "k" '(evil-window-up :which-key "Window Up")
   "l" '(evil-window-right :which-key "Window Right"))

  (core-definer-menu
   "q" '(:ignore t :which-key "Quit")
   "q" '(kill-emacs :which-key "Kill Emacs")
   "r" '(mymacs/restart-emacs :which-key "Restart Emacs")
   "d" '(mymacs/restart-emacs-debug :which-key "Restart Emacs (Debug)"))

  (core-definer-menu
   "c" '(:ignore t :which-key "config")
   "f" '(dired-user-emacs-directory :which-key "Dired Emacs Directory")
   "c" '(dired-core-directory :which-key "Dired Core Directory")
   "m" '(dired-module-directory :which-key "Dired Module Directory"))

  (core-definer-menu
   "g" '(:ignore t :which-key "Git")
   "s" '(magit-status :which-key "Magit Status"))

  (core-definer-menu
   "h" '(:ignore t :which-key "Help")
   "i" '(info :which-key "Info")
   "a" '(apropos :which-key "Apropos")
   "v" '(describe-variable :which-key "Describe Variable")
   "d" '(describe-mode :which-key "Describe Mode")
   "k" '(describe-key :which-key "Describe Key")
   "f" '(describe-function :which-key "Describe Function"))

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
