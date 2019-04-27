(require 'package)

(defun core-maybe-install-use-package ()
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))

(defun core-init-package ()
  (setq package-user-dir package-directory)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/"))
  (package-initialize)
  (core-maybe-install-use-package))

(provide 'core-package-setup)
