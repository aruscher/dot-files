(defun add-to-loadpath (dir)
  (add-to-list 'load-path dir))

(defun add-to-loadpath-if-exists (dir)
  (when (file-exists-p dir)
    (add-to-loadpath dir)))

(defconst core-directory
  (expand-file-name "core" user-emacs-directory)
  "The mymacs core directory")

(defconst core-tests-directory
  (expand-file-name "tests" core-directory))


(defconst module-directory
  (expand-file-name "module" user-emacs-directory))

(defconst my-custom-file
  (expand-file-name ".emacs-custom.el" user-emacs-directory))

(defconst my-backup-directory
  (expand-file-name "backups" user-emacs-directory))

(defconst my-auto-save-directory
  (expand-file-name "auto-save-list/" user-emacs-directory))

(defconst package-directory
  (expand-file-name "packages" user-emacs-directory))

(add-to-loadpath-if-exists core-directory)
(add-to-loadpath-if-exists core-tests-directory)
(add-to-loadpath-if-exists module-directory)
