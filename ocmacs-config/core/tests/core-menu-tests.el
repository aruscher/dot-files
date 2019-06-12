(require 'ert)
(require 'core-menu)

(defvar core-menu-tests-item
  '(item :prefix "s"
	 :label "Save Buffer"
	 :func save-buffer)) 

(defvar core-menu-tests-simple-menu
  '(menu :prefix "b"
	 :label "Buffer")) 

(defvar core-menu-tests-menu-with-menu-entries
  '(menu :prefix "a"
	 :label "A"
	 :entries
	 (menu :prefix "b"
	       :label "B"
	       :entries
	       (item :prefix "c"
		     :label "C"
		     :func foo))
	 (item :prefix "d"
	       :label "D"
	       :func foo)))

(defvar core-menu-tests-menu-with-entries
  '(menu :prefix "b"
	 :label "Buffer"
	 :entries
	 (item :prefix "p"
	       :label "Previous Buffer"
	       :func previous-buffer)
	 (item :prefix "n"
	       :label "Next Buffer"
	       :func next-buffer)))

(ert-deftest core-menu-tests-menu-build ()
  (should (equal (core-menu-build core-menu-tests-item)
		 (core-menu--item-entry core-menu-tests-item)))
  (should (equal (core-menu-build core-menu-tests-menu-with-entries)
		 (core-menu--menu-entry core-menu-tests-menu-with-entries)))
  (should (equal (core-menu-build core-menu-tests-menu-with-menu-entries)
		 (core-menu--menu-entry core-menu-tests-menu-with-menu-entries)))
  )

(ert-deftest core-menu-tests--menu-entry ()
  (should (equal (core-menu--menu-entry core-menu-tests-simple-menu)
		 '("b" '(:ignore t :which-key "Buffer"))))
  (should (equal (core-menu--menu-entry core-menu-tests-menu-with-entries)
		 '("b" '(:ignore t :which-key "Buffer")
		   "bp" '(previous-buffer :which-key "Previous Buffer")
		   "bn" '(next-buffer :which-key "Next Buffer"))))
  (should (equal (core-menu--menu-entry core-menu-tests-menu-with-menu-entries)
		 '("a" '(:ignore t :which-key "A")
		   "ab" '(:ignore t :which-key "B")
		   "abc" '(foo :which-key "C")
		   "ad" '(foo :which-key "D")))))

(ert-deftest core-menu-tests--item-menu-errors ()
  (should-error (core-menu--menu-entry core-menu-tests-item))
  (should-error (core-menu--menu-entry '(menu :label "A")))
  (should-error (core-menu--menu-entry '(menu :prefix "a"))))

(ert-deftest core-menu-tests--item-entry ()
  (let ((result (core-menu--item-entry core-menu-tests-item)))
    (should (equal result '("s" '(save-buffer :which-key "Save Buffer"))))))

(ert-deftest core-menu-tests--item-entry-errors ()
  (should-error (core-menu--item-entry '(:prefix "s" :label "Save Buffer" :func save-buffer)))
  (should-error (core-menu--item-entry '(item :label "Save Buffer" :func save-buffer)))
  (should-error (core-menu--item-entry '(item :prefix "s" :func save-buffer)))
  (should-error (core-menu--item-entry '(item :prefix "s" :label "Save Buffer"))))


(provide 'core-menu-tests)
