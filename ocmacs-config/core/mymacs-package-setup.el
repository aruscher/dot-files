(require 'package)
(setq package-user-dir "~/.emacs.d/packages")

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
	     )

(package-initialize)

(unless (package-installed-p 'use-package)
	  (package-refresh-contents)
 	 (package-install 'use-package))

(message "Package Setup Done")

(provide 'mymacs-package-setup)
