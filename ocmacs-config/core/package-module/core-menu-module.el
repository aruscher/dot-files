(require 'core-package-module)

(define-package-module menu
  :require 'which-key 'evil 'general
  :menu 
  (menu :prefix "q"
	:label "Quit"
	:entries
	(item :prefix "q"
	      :label "Kill Emacs"
	      :func kill-emacs)
	(item :prefix "r"
	      :label "Restart Emacs"
	      :func mymacs/restart-emacs)))

