(use-package emacsql-sqlite)

(use-package org-roam
  :straight (:host github :repo "org-roam/org-roam"
		   :files (:defaults "extensions/*"))
  :custom
  (org-roam-directory my/org-roam-directory)
  (org-roam-file-extensions '("org"))
  (org-roam-node-display-template "${title:*} ${tags:30}")
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n g" . org-roam-graph)
         ("C-c n s" . org-roam-db-sync)
         ("C-c n l" . org-roam-buffer-toggle))
  :hook (after-init . org-roam-setup))

(custom-set-variables
 '(org-roam-graph-link-hidden-types '("file" "https" "http")))
