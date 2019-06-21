(require 'core-special-files)

(defun core-maybe-create-custom-file (file)
  (unless (file-exists-p file)
    (with-temp-buffer (write-file file))))

(setq custom-file core-custom-file-name)
(core-maybe-create-custom-file custom-file)
(load custom-file)

(provide 'core-custom-file)
