(require 'ert)
(require 'core-menu)

(defvar core-menu-tests-item
  '(item :prefix "s"
	 :label "Save Buffer"
	 :func save-buffer)) 

(defvar core-menu-tests-simple-menu
  '(menu :prefix "b"
	 :label "Buffer")) 

(defvar core-menu-tests-menu-with-entries
  '(menu :prefix "b"
	 :label "Buffer"
	 :entries
	 (item :prefix "p"
	       :label "Previous Buffer"
	       :func previous-buffer)
	 (item :prefix "n"
	       :label "Next Buffer"
	       :func next-buffer)
	 (item :prefix "b"
	       :label "Buffer List"
	       :func helm-buffers-list)
	 (item :prefix "ko"
	       :label "Kill Other Buffer"
	       :func mymacs/kill-other-buffers)))

(ert-deftest core-menu-tests--menu-entry ()
  (should (equal (core-menu--menu-entry core-menu-tests-simple-menu)
		 '("b" (:ignore t :which-key "Buffer")))))

(ert-deftest core-menu-tests--item-entry ()
  (let ((result (core-menu--item-entry core-menu-tests-item)))
    (should (equal result '("s" (save-buffer :which-key "Save Buffer"))))))

(ert-deftest core-menu-tests-menu-item-errors ()
  (should-error (core-menu--item-entry '(:prefix "s" :label "Save Buffer" :func save-buffer)))
  (should-error (core-menu--item-entry '(item :label "Save Buffer" :func save-buffer)))
  (should-error (core-menu--item-entry '(item :prefix "s" :func save-buffer)))
  (should-error (core-menu--item-entry '(item :prefix "s" :label "Save Buffer"))))


(provide 'core-menu-tests)
