(in-package :stumpwm)
(ql:quickload :swank)
(require :swank)
(swank-loader:init)

(defvar *swank-state* nil)

(defun start-swank ()
  (swank:create-server :port 4004
                       :style swank:*communication-style*
                       :dont-close t)
  (setf *swank-state* t)
  (message "Debug server started on port 4004. Run slime-connect on localhost:4004."))

(defun stop-swank()
  (swank:stop-server 4004)
  (setf *swank-state* nil)
  (message "Debug server closed"))

(defun toggle-swank ()
  (if *swank-state* (stop-swank) (start-swank)))
