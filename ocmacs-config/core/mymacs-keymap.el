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
  "fs" '(save-buffer :which-key "Save Buffer")
  "ff" '(helm-find-files :which-key "Find Files")
  "fj" '(dired :which-key "Dired")
  "ft" '(neotree-toggle :which-key "Toogle Neotree")
  "b" '(:ignore t :which-key "Buffer")
  "bp" '(previous-buffer :which-key "Previous Buffer")
  "bn" '(next-buffer :which-key "Next Buffer")
  "bb" '(helm-buffers-list :which-key "Buffer List")
  "bko" '(mymacs/kill-other-buffers :which-key "Kill Other Buffers")
  "w" '(:ignore t :which-key "Window")
  "w-" '(split-window-below :which-key "Split Window Below")
  "w/" '(split-window-right :which-key "Split Window Right")
  "wh" '(evil-window-left :which-key "Window Left")
  "wj" '(evil-window-down :which-key "Window Open")
  "wk" '(evil-window-up :which-key "Window Up")
  "wl" '(evil-window-right :which-key "Window Right")
  "q" '(:ignore t :which-key "Quit")
  "qq" '(kill-emacs :which-key "Kill Emacs")
  "qr" '(mymacs/restart-emacs :which-key "Restart Emacs")
  "qd" '(mymacs/restart-emacs-debug :which-key "Restart Emacs (Debug)")
  "c" '(:ignore t :which-key "Config")
  "cf" '(mymacs/open-config :which-key "Open init.el")
  "cR" 'mymacs/init
  "g" '(:ignore t :which-key "Git")
  "gs" '(magit-status :which-key "Magit Status")
  "h" '(:ignore t :which-key "Help")
  "hi" '(info :which-key "Info")
  "ha" '(apropos :which-key "Apropos")
  "hv" '(describe-variable :which-key "Describe Variable")
  "hd" '(describe-mode :which-key "Describe Mode")
  "hk" '(describe-key :which-key "Describe Key")
  "hf" '(describe-function :which-key "Describe Function")
  )

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
