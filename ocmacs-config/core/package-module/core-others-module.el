(require 'use-package)
(require 'core-package-module)

(define-package-module others
  :packages
  (use-package restart-emacs
    :ensure t)
  (use-package neotree
    :ensure t)
  (use-package magit
    :ensure t))
