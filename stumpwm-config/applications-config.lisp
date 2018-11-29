(in-package :stumpwm)

(defcommand firefox () ()
  (run-or-raise "firefox" '(:class "Firefox")))
(define-key *root-map* (kbd "b") "firefox")

(defcommand emacs ()()
  (run-or-raise "emacs" '(:class "Emacs")))
(define-key *root-map* (kbd "e") "emacs")

(defcommand xfce-terminal ()()
  (run-or-raise "xfce4-terminal" '(:class "xfce4-terminal")))
(define-key *root-map* (kbd "c") "xfce-terminal")


