(require 'core-custom-file)
(require 'core-settings)
(require 'core-packages)
(require 'core-module)
(require 'core-window)
(require 'core-keymap)

(defun core-init ()
  (core-default-settings)
  (core-use-packages)
  (core-load-custom-file)
  (core-init-window)
  (core-init-keymap)
  (core-use-modules 'elisp-module 'sml-module))

(provide 'core-loader)

