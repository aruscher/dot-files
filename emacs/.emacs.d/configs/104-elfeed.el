;; (defun bjm/elfeed-load-db-and-open ()
;;   (interactive)
;;   (elfeed-db-load)
;;   (elfeed)
;;   (elfeed-search-update--force))

;; (defun bjm/elfeed-save-db-and-bury ()
;;   (interactive)
;;   (elfeed-db-save)
;;   (elfeed-db-compact)
;;   (quit-window))

;; (defun bjm/elfeed-mark-all-as-read ()
;;   (interactive)
;;   (mark-whole-buffer)
;;   (elfeed-search-untag-all-unread))

;; (use-package elfeed
;;   :bind (:map elfeed-search-mode-map
;;               ("q" . bjm/elfeed-save-db-and-bury)
;;               ("Q" . bjm/elfeed-save-db-and-bury))
;;   :config
;;   (setq elfeed-db-directory "~/Generic-Share/shared/elfeeddb"))
