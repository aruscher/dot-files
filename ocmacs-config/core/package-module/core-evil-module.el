(require 'use-package)
(require 'core-package-module)

(define-package-module evil
  :packages
  (use-package evil
    :ensure t
    :init
    (setq evil-want-keybinding nil)
    :config (evil-mode 1))
  (use-package evil-magit
    :ensure t
    :after evil)
  (use-package evil-commentary
    :ensure t
    :after evil
    :init (evil-commentary-mode))
  (use-package evil-collection
    :ensure t
    :after evil
    :config
    (evil-collection-init)))
