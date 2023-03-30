(defun my/org-mode-hook ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(add-hook 'org-mode-hook #'my/org-mode-hook)
