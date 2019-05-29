(require 'ert)
(require 'core-plist)

(defvar test-plist '(:foo 123 :bar 123))
(defvar test-cplist '(:foo 1 2 3 :bar 4 5 :bak 6))
(defvar test-menu '(:label "foo" :key "fo"
			   :entries
			   (item :label "bar")
			   (item :label "bak")))

(ert-deftest core-plist-test-test-menu ()
  (let ((result (core-plist test-menu)))
    (should (equal result '(:label "foo" :key "fo"
				   :entries ((item :label "bar")
					     (item :label "bak")))))))

(ert-deftest core-plist-test-empty-list ()
  (let ((result (core-plist '())))
    (should (equal result '()))))

(ert-deftest core-plist-test-plist ()
  (let ((result (core-plist test-plist)))
    (should (equal test-plist result))
    (should (equal (plist-get result :foo) 123))
    (should (equal (plist-get result :bar) 123))))

(ert-deftest core-plist-test-cplist ()
  (let ((result (core-plist test-cplist)))
    (should (equal '(:foo (1 2 3) :bar (4 5) :bak 6) result))
    (should (equal (plist-get result :foo) '(1 2 3)))
    (should (equal (plist-get result :bar) '(4 5)))
    (should (equal (plist-get result :bak) 6))))


(provide 'core-plist-test)
