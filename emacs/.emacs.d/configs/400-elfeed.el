

(use-package elfeed)

(use-package elfeed-protocol
  :after elfeed
  :config
  (setq elfeed-use-curl t)
  (elfeed-set-timeout 36000)
  (setq elfeed-protocol-fever-update-unread-only nil)
  (setq elfeed-feeds (list
		      (list "fever+https://Aruscher@news.aruscher-cloud.duckdns.org"
			    :api-url "https://news.aruscher-cloud.duckdns.org/fever/"
			    :password-file "~/.miniflux-password")))
  (setq elfeed-protocol-enabled-protocols '(fever))
  (elfeed-protocol-enable))
