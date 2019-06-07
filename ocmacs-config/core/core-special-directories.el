(defconst core-backup-directory
  (expand-file-name "backups" user-emacs-directory))

(defconst core-auto-save-directory
  (expand-file-name "auto-save-list/" user-emacs-directory))

(defconst core-package-directory
  (expand-file-name "packages" user-emacs-directory))

(defconst core-module-directory
  (expand-file-name "module" user-emacs-directory))

(provide 'core-special-directories)
