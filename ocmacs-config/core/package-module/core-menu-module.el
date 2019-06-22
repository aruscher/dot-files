(require 'core-package-module)
(require 'core-special-directories)

(define-package-module menu
  :require-module 'general
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
	      :label "Window Down" :func evil-window-down)
	(item :prefix "k"
	      :label "Window Up"
	      :func evil-window-up)
	(item :prefix "l"
	      :label "Window Right"
	      :func evil-window-right)
	(item :prefix "H"
	      :label "Move Window Left"
	      :func evil-window-move-far-left)
	(item :prefix "J"
	      :label "Move Window Down"
	      :func evil-window-move-very-bottom)
	(item :prefix "K"
	      :label "Move Window Up"
	      :func evil-window-move-very-top)
	(item :prefix "L"
	      :label "Move Window Right"
	      :func evil-window-move-far-right))
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
	      :func (lambda ()
		      (interactive)
		      (dired user-emacs-directory)))
	(item :prefix "c"
	      :label "Dired Core Directory"
	      :func (lambda ()
		      (interactive)
		      (dired core-directory)))
	(item :prefix "p"
	      :label "Dired Package Module Directory"
	      :func (lambda ()
		      (interactive)
		      (dired core-package-module-directory)))
	(item :prefix "l"
	      :label "Dired Language Module Directory"
	      :func (lambda ()
		      (interactive)
		      (dired core-language-module-directory))))
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
