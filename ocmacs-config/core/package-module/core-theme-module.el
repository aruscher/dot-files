
(require 'core-package-module)

(define-package-module theme
  :packages
  (use-package monokai-theme
    :config (load-theme 'monokai t)))
