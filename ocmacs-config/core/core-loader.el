(require 'core-custom-file)
(require 'core-settings)
(require 'core-packages)
(require 'core-module)
(require 'core-window)

(defun core-init ()
  (core-default-settings)
  (core-use-packages)
  (core-load-custom-file)
  (core-init-window)

  (require 'core-keymap)
  (core-use-modules 'elisp-module 'sml-module))





(provide 'core-loader)

