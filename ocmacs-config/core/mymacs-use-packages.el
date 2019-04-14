(defun mymacs/install-use-package ()
    (package-refresh-contents)
    (package-install 'use-package))

(defun mymacs/kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun mymacs/bootstrap-packages ()
	(require 'package)
    (add-to-list 'package-archives
		'("melpa" . "http://melpa.org/packages/"))
    (package-initialize)
)

(defun mymacs/init-use-package ()
	(mymacs/bootstrap-packages)
	(unless (package-installed-p 'use-package)
		(mymacs/install-use-package)))

(provide 'mymacs-use-packages)
