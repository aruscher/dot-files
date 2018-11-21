(in-package :stumpwm)

(ql:quickload :swank)

(require :swank)
(swank-loader:init)
(swank:create-server :port 4004
                     :style swank:*communication-style*
                     :dont-close t)


(load "./modeline-config.lisp")
(load "./applications-config.lisp")

