(defun add-to-loadpath (dir)
  (add-to-list 'load-path dir))

(defun add-to-loadpath-if-exists (dir)
  (when (file-exists-p dir)
    (add-to-loadpath dir)))

(defconst core-directory
  (expand-file-name "core" user-emacs-directory))

(defconst core-tests-directory
  (expand-file-name "tests" core-directory))

(defconst core-modules-directory
  (expand-file-name "modules" core-directory))

(defconst module-directory
  (expand-file-name "module" user-emacs-directory))

(add-to-loadpath-if-exists core-directory)
(add-to-loadpath-if-exists core-tests-directory)
(add-to-loadpath-if-exists module-directory)
(add-to-loadpath-if-exists core-modules-directory)
