(require 'core-package-module)

(define-package-module company
  :packages
  (use-package company
    :config (progn
	      (setq company-idle-delay 0)
	      (setq company-minimum-prefix-length 3))
    :init (global-company-mode))
  (use-package company-quickhelp
    :hook (company-mode-hook . company-quickhelp-mode)))
