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


(use-package org-roam-ui
  :straight
    (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
    :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
