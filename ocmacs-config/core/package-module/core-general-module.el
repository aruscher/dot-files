(require 'use-package)
(require 'core-package-module)

(define-package-module general
  :require-module 'evil
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
  :menu-definer main-definer
  :menu 
  (menu :prefix "b"
	:label "Buffer"
	:entries
	(item :prefix "p"
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
	      :func mymacs/kill-other-buffers))
  (menu :prefix "w"
	:label "Window"
	:entries
	(item :prefix "-"
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
	      :func evil-window-right))
  (menu :prefix "q"
	:label "Quit"
	:entries
	(item :prefix "q"
	      :label "Kill Emacs"
	      :func kill-emacs)
	(item :prefix "r"
	      :label "Restart Emacs"
	      :func mymacs/restart-emacs))
  (menu :prefix "c"
	:label "Config"
	:entries
	(item :prefix "f"
	      :label "Dired Emacs Directory"
	      :func dired-user-emacs-directory)
	(item :prefix "c"
	      :label "Dired Core Directory"
	      :func dired-core-directory)
	(item :prefix "m"
	      :label "Dired Module Directory"
	      :func dired-module-directory))
  (menu :prefix "g"
	:label "Git"
	:entries
	(item :prefix "s"
	      :label "Magit Status"
	      :func magit-status))
  (menu :prefix "h"
	:label "Help"
	:entries
	(item :prefix "i"
	      :label "Info"
	      :func info)
	(item :prefix "a"
	      :label "Apropos"
	      :func helm-apropos)
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
	      :func describe-function))
  (menu :prefix "f"
	:label "File"
	:entries
	(item :prefix "s"
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
	      :func neotree-toggle)))

