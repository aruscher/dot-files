(require 'mymacs-util-funcs)
(require 'general)

(general-create-definer main-definer
  :states '(normal visual insert motion emacs)
  :prefix "SPC"
  :non-normal-prefix "C-SPC") 


(main-definer
  "" 'nil
  "a" '(:ignore t :which-key "Applications")
  "f" '(:ignore t :which-key "File")
  "fs" 'save-buffer
  "ff" 'helm-find-files
  "fj" 'dired
  "ft" 'neotree-toggle
  "b" '(:ignore t :which-key "Buffer")
  "bp" 'previous-buffer
  "bn" 'next-buffer
  "bb" 'helm-buffers-list
  "bko" 'mymacs/kill-other-buffers
  "w" '(:ignore t :which-key "Window")
  "w-" 'split-window-below
  "w/" 'split-window-right
  "wh" 'evil-window-left
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wl" 'evil-window-right
  "q" '(:ignore t :which-key "Quit")
  "qq" 'kill-emacs
  "qr" 'mymacs/restart-emacs
  "qd" 'mymacs/restart-emacs-debug
  "c" '(:ignore t :which-key "Config")
  "cf" 'mymacs/open-config
  "cR" 'mymacs/init
  "g" '(:ignore t :which-key "Git")
  "gs" 'magit-status
  "h" '(:ignore t :which-key "Help")
  "hi" 'info
  "ha" 'apropos
  "hv" 'describe-variable
  "hd" 'describe-mode
  "hk" 'describe-key
  "hf" 'describe-function)

(global-set-key (kbd "M-x") 'helm-M-x)


(evil-define-key 'normal neotree-mode-map (kbd "'") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

(evil-define-key nil company-active-map (kbd "C-j") #'company-select-next)
(evil-define-key nil company-active-map (kbd "C-k") #'company-select-previous)
(evil-define-key nil company-active-map (kbd "C-n") #'company-select-next-or-abort)
(evil-define-key nil company-active-map (kbd "C-p") #'company-select-previous-or-abort)

(evil-define-key nil custom-mode-map (kbd "j") #'widget-forward)
(evil-define-key nil custom-mode-map (kbd "k") #'widget-backward)


(provide 'mymacs-keymap)
