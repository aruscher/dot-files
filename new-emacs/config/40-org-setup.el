;; Org-Bullets
(use-package org-bullets
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


;;(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
;;(global-set-key "\C-cb" 'org-switchb)


