(use-package sly
  :hook ((sly-mrepl-mode . paredit-mode)
         (lisp-mode . sly-editing-mode)
         (sly-mrepl-mode . company-mode))
  :config
  (setq inferior-lisp-program "sbcl")
  (sly-setup))

(use-package sly-macrostep
  :ensure t)

(defun my-paredit-override-advice (origin-fun &rest args)
  (if (string-prefix-p "*sly-mrepl for" (buffer-name (current-buffer)))
      (sly-mrepl-return)
    (funcall origin-fun)))

(advice-add 'paredit-RET :around #'my-paredit-override-advice)
