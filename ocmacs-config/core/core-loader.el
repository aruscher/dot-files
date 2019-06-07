(require 'core-settings)
(require 'core-package-setup)
(require 'core-packages)
(require 'core-module)
(require 'core-keymap)

(require 'core-custom-file)

(defun core-load ()
  (core-settings-startup)
  (core-package-setup)
  (core-use-packages)
  (core-init-keymap)
  (core-settings-default)
  (core-use-modules 'elisp-module 'sml-module))

(provide 'core-loader)

