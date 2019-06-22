(defconst core-directory
  (expand-file-name "core" user-emacs-directory))

(defconst core-package-module-directory
  (expand-file-name "package-module" core-directory))

(defconst core-backup-directory
  (expand-file-name "backups" user-emacs-directory))

(defconst core-auto-save-directory
  (expand-file-name "auto-save-list/" user-emacs-directory))

(defconst core-package-directory
  (expand-file-name "packages" user-emacs-directory))

(defconst core-language-module-directory
  (expand-file-name "language-modules" core-directory))



(provide 'core-special-directories)
