(require 'core-paths)
(require 'core-settings)
(require 'core-package-setup)
(require 'core-packages)
(require 'core-module)
(require 'core-keymap)
(require 'core-custom-file)
(require 'core-package-module)

(defun core-load ()
  (core-settings-startup)
  (core-package-setup-use-package)
  (core-use-packages)
  (core-load-package-modules
   'which-key
   'general
   'evil
   'helm
   'others


   'menu)
  (core-init-keymap)
  (core-settings-default))
  ;; (core-use-modules 'elisp-module 'sml-module))

(provide 'core-loader)

