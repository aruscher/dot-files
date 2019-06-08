(require 'use-package)
(require 'core-package-module)

(define-package-module general
  :packages
  (use-package general
    :after which-key
    :config (general-override-mode)))
