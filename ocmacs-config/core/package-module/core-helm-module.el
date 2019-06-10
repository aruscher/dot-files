(require 'use-package)
(require 'core-package-module)

(define-package-module helm
  :packages
  (use-package helm
    :ensure t
    :config 
    (setq helm-buffers-fuzzy-matching t)
    (helm-mode)))
