;;; toogle modeline
(in-package :stumpwm)
(toggle-mode-line (current-screen)
                  (current-head))

(setf *mode-line-timeout* 1)
(setf *time-modeline-string* "%k:%M %d/%m/%Y")

(defvar *battary-command*
  "acpi -b | grep \"[0-9]*%\" -o")

(defun get-battary ()
  (string-trim (string #\newline)
               (run-shell-command *battary-command* t)))


(setf *screen-mode-line-format*
      '("%g"
        " | %v"
        " | BAT:"
        (:eval (get-battary))
        " |%d"))

