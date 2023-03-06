;; Disable Scrollbar, Toolbar, Tooltips, Startupmessage
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;; Remap yes-or-no to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p) 

;; Show position in buffer, line numbers, highlight current line, and matching pairs
(column-number-mode) 
(global-display-line-numbers-mode t)
(global-hl-line-mode t)
(show-paren-mode t)

;; Don't show line numbers in shell-modes
(dolist (mode '(term-mode-hook eshell-mode-hook shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
