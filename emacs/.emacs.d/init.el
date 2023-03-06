(let ((config-files (directory-files (file-name-concat user-emacs-directory "configs") t "\.el")))
  (dolist (config-file config-files)
    (load config-file)))
