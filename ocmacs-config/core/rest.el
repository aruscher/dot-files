
(defun mymacs/load-core ()
    (add-to-list 'load-path (concat *mymacs/start-directory* "core/"))
    (load "mymacs-keymap")
    (mymacs/bootstrap-packages)
    (mymacs/setup-packages))



(defun mymacs/setup-packages ()
  (require 'use-package)
  (mymacs/use-which-key-package)
  (mymacs/use-general-package)
  (mymacs/use-restart-emacs-package)
  (mymacs/use-evil-package)
  (mymacs/use-helm-package)
  (mymacs/setup-key-map)
)




(defun mymacs/use-which-key-package ()
    

(defun mymacs/use-general-package ()
    (use-package general
 
    (
    (tyrant-def
      "" 'nil)))



