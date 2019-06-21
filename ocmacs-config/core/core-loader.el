(require 'core-paths)
(require 'core-settings)
(require 'core-package-setup)
(require 'core-packages)
(require 'core-custom-file)
(require 'core-package-module)

(defun core-load ()
  (core-settings-startup)
  (core-package-setup-use-package)
  (core-load-package-modules
   'which-key
   'general
   'evil
   'helm
   'theme
   'company
   'others
   'menu)
  (core-settings-default))
  ;; (core-use-modules 'elisp-module 'sml-module))

(provide 'core-loader)

