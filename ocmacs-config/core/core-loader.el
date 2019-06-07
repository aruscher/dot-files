(require 'core-settings)
(require 'core-package-setup)
(require 'core-packages)
(require 'core-module)
(require 'core-keymap)
(require 'core-custom-file)

(require 'core-paths)


(defun core-load ()
  (core-settings-startup)
  (core-paths-load-paths)
  (core-package-setup-use-package)
  (core-use-packages)
  (core-init-keymap)
  (core-settings-default))
  ;; (core-use-modules 'elisp-module 'sml-module))

(provide 'core-loader)

