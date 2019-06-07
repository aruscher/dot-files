(require 'package)
(require 'core-special-directories)

(defun core-package-maybe-install (package)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package)))


(defun core-package-setup ()
  (setq package-user-dir core-package-directory)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/"))
  (package-initialize)
  (core-package-maybe-install use-package))

(provide 'core-package-setup)
