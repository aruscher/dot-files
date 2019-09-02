(defvar my-config-folder
  (expand-file-name "config" user-emacs-directory))

(defvar my-config-files
  (directory-files
   my-config-folder
   :match ".*\.el$"))


(dolist (config-file my-config-files)
  (load config-file))



