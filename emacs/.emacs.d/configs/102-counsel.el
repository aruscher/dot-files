(use-package counsel
  :bind (("C-s" . swiper-isearch)
         ("M-x" . counsel-M-x)
         ("C-h a" . counsel-apropos)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil))


(use-package ivy-rich
  :init (ivy-rich-mode 1))
