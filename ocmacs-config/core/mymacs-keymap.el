(require 'mymacs-util-funcs)
(require 'general)

(general-create-definer main-definer
  :states '(normal visual insert motion emacs)
  :prefix "SPC"
  :non-normal-prefix "C-SPC") 


(main-definer
  "" 'nil
  "a" '(:ignore t :which-key "applications")
  "f" '(:ignore t :which-key "file")
  "fs" '(save-buffer :which-key "save buffer")
  "ff" '(helm-find-files :which-key "find files")
  "fj" '(dired :which-key "dired")
  "ft" '(neotree-toggle :which-key "toogle neotree")
  "b" '(:ignore t :which-key "buffer")
  "bp" '(previous-buffer :which-key "previous buffer")
  "bn" '(next-buffer :which-key "next buffer")
  "bb" '(helm-buffers-list :which-key "buffer list")
  "bko" '(mymacs/kill-other-buffers :which-key "kill other buffers")
  "w" '(:ignore t :which-key "window")
  "w-" '(split-window-below :which-key "split window below")
  "w/" '(split-window-right :which-key "split window right")
  "wh" '(evil-window-left :which-key "window left")
  "wj" '(evil-window-down :which-key "window open")
  "wk" '(evil-window-up :which-key "window up")
  "wl" '(evil-window-right :which-key "window right")
  "q" '(:ignore t :which-key "quit")
  "qq" '(kill-emacs :which-key "kill emacs")
  "qr" '(mymacs/restart-emacs :which-key "restart emacs")
  "qd" '(mymacs/restart-emacs-debug :which-key "restart emacs (debug)")
  "c" '(:ignore t :which-key "config")
  "cf" '(mymacs/open-config :which-key "open init.el")
  "cr" 'mymacs/init
  "g" '(:ignore t :which-key "git")
  "gs" '(magit-status :which-key "magit status")
  "h" '(:ignore t :which-key "help")
  "hi" '(info :which-key "info")
  "ha" '(apropos :which-key "apropos")
  "hv" '(describe-variable :which-key "describe variable")
  "hd" '(describe-mode :which-key "describe mode")
  "hk" '(describe-key :which-key "describe key")
  "hf" '(describe-function :which-key "describe function")
  )

(global-set-key (kbd "M-x") 'helm-m-x)

(ocmacs-define-evil-key-group 'normal neotree-mode-map
			      "'" #'neotree-quick-look
			      "q" #'neotree-hide
			      "ret" #'neotree-enter
			      "g" #'neotree-refresh
			      "n" #'neotree-next-line
			      "p" #'neotree-previous-line
			      "a" #'neotree-stretch-toggle
			      "h" #'neotree-hidden-file-toggle)

(ocmacs-define-evil-key-group nil company-active-map
			      "C-j" #'company-select-next
			      "C-k" #'company-select-previous
			      "C-n" #'company-select-next-or-abort
			      "C-p" #'company-select-previous-or-abort)

;; (ocmacs-define-evil-key-group nil custom-mode-map
;; 			      "j" #'widget-forward
;; 			      "k" #'widget-backward)

(provide 'mymacs-keymap)
