(defconst mymacs-config-file user-init-file)

(defconst mymacs-directory user-emacs-directory
  "The mymacs directory")

(defconst core-directory (expand-file-name "core" mymacs-directory)
  "The mymacs core directory")

(defconst module-directory (expand-file-name "modules" core-directory))

(defun add-to-loadpath (dir)
  (add-to-list 'load-path dir))

(defun add-to-loadpath-if-exists (dir)
  (when (file-exists-p dir)
    (add-to-loadpath dir)))


(add-to-loadpath core-directory)
(add-to-loadpath module-directory)
