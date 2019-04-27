(defun add-to-loadpath (dir)
  (add-to-list 'load-path dir))

(defun add-to-loadpath-if-exists (dir)
  (when (file-exists-p dir)
    (add-to-loadpath dir)))

(defconst core-directory (expand-file-name "core" user-emacs-directory)
  "The mymacs core directory")

(defconst module-directory (expand-file-name "module" user-emacs-directory))



(add-to-loadpath-if-exists core-directory)
(add-to-loadpath-if-exists module-directory)
