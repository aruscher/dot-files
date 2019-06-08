(require 'core-package-module)
(require 'use-package)

(define-package-module which-key
  :packages
  (use-package which-key
    :ensure t
    :config (which-key-mode)))


