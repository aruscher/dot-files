(defun core-maybe-create-custom-file ()
  (unless (file-exists-p custom-file)
    (with-temp-buffer (write-file custom-file))))

(defun core-load-custom-file ()
  (setq custom-file my-custom-file)
  (core-maybe-create-custom-file)
  (load custom-file))



(provide 'core-custom-file)
