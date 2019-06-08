(require 'core-special-directories)

(defun core-paths--add-to-loadpath (dir)
  (add-to-list 'load-path dir))

(defun core-paths--add-to-loadpath-if-exists (dir)
  (when (file-exists-p dir)
    (core-paths--add-to-loadpath dir)))

(core-paths--add-to-loadpath-if-exists core-modules-directory)
(core-paths--add-to-loadpath-if-exists core-package-module-directory)

(provide 'core-paths)
