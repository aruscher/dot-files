(defun my/org-mode-hook ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package org
  :config
  (setq org-cite-global-bibliography (list "~/Zettelkasten/bibliography.bib"))
  (setq bibtex-completion-bibliography (list "~/Zettelkasten/bibliography.bib")))

(add-hook 'org-mode-hook #'my/org-mode-hook)
