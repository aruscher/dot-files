(require 'use-package)
(require 'core-package-module)

(define-package-module general
  :require 'evil
  :packages
  (use-package general
    :ensure t
    :after which-key
    :config
    (general-override-mode 1)
    (general-auto-unbind-keys)
    (general-create-definer main-definer
      :states '(normal visual insert motion emacs)
      :prefix "SPC"
      :non-normal-prefix "C-SPC")
    )
  :menu 
  (menu :prefix "q"
	:label "Quit"
	:entries
	(item :prefix "q"
	      :label "Kill Emacs"
	      :func kill-emacs)
	(item :prefix "r"
	      :label "Restart Emacs"
	      :func mymacs/restart-emacs))
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

