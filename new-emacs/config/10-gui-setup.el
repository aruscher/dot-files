; Disable annoying GUI stuff	 

;; Disable toolbar
(tool-bar-mode -1)

;; Disable blinking cursor		 
(blink-cursor-mode -1)

;; Disable scroll all mode
(scroll-all-mode -1)

;; Disable emacs start screen
(setq inhibit-splash-screen t)

;; Remap yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Show matchting parens
(show-paren-mode t)

;; Highlight current line
(global-hl-line-mode t)

;; Show line numbers
(global-display-line-numbers-mode t)

;; Use ibuffer for list-buffers
(defalias 'list-buffers 'ibuffer)

;; Set hack as default font
(set-face-attribute 'default nil
                    :family "Hack"
                    :height 110
                    :weight 'normal
                    :width 'normal)
