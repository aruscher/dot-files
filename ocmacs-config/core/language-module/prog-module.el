(require 'core-language-module)

(define-language-module prog
  :packages 
  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  (use-package smartparens
    :hook (prog-mode . smartparens-mode)
    :config (require 'smartparens-config)))
