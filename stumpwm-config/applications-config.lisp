(in-package :stumpwm)

(defcommand firefox () ()
  (run-or-raise "firefox" '(:class "Firefox"))
  (title "Firefox"))
(define-key *root-map* (kbd "b") "firefox")

(defcommand emacs ()()
  (run-or-raise "emacs" '(:class "Emacs"))
  (title "Emacs"))
(define-key *root-map* (kbd "e") "emacs")
