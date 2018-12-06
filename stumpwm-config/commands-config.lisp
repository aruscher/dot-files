(in-package :stumpwm)

(defcommand firefox () ()
  (run-or-raise "firefox" '(:class "Firefox")))

(defcommand emacs ()()
  (run-or-raise "emacs" '(:class "Emacs")))

(defcommand xfce-terminal ()()
  (run-or-raise "xfce4-terminal" '(:class "xfce4-terminal")))
