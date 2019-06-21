(require 'use-package)
(require 'core-package-module)

(define-package-module general
  :require-module 'evil
  :packages
  (use-package general
    :ensure t
    :after which-key evil
    :config
    (general-override-mode 1)
    (general-auto-unbind-keys)
    (general-create-definer main-definer
      :states '(normal visual insert motion emacs)
      :prefix "SPC"
      :non-normal-prefix "C-SPC")))
