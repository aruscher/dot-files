(require 'core-language-module)

(define-language-module prog
  :packages 
  (use-package rainbow-delimiters
    :ensure t
    :hook (prog-mode . rainbow-delimiters-mode))
  
  (use-package smartparens
    :ensure t
    :hook (prog-mode . smartparens-mode)
    :config (require 'smartparens-config)))
