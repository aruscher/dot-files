
(require 'core-package-module)

(define-package-module theme
  :packages
  (use-package monokai-theme
	:ensure t
    :config (load-theme 'monokai t)))
