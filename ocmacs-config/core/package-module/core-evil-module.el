(require 'use-package)
(require 'core-package-module)

(define-package-module evil
  :packages
  (use-package evil
    :ensure t
    :config (evil-mode))
  (use-package evil-magit
    :ensure t)
  (use-package evil-commentary
    :ensure t
    :init (evil-commentary-mode)))
