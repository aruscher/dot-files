(defvar *my-backup-folder*
  (expand-file-name "backup/" user-emacs-directory))

(unless (file-exists-p *my-backup-folder*)
  (mkdir *my-backup-folder*))

(setq backup-directory-alist
      `(("." . ,*my-backup-folder*)))
