(defparameter *fruit* 'apple)
(cond ( (eq *fruit* 'apple) 'its-an-apple)
      ( (eq *fruit* 'orange) 'its-an-orange ) )
      
(equal 'apple 'apple)
;; T
(equal (list 1 2 3) (list 1 2 3) )
;; T
(equal (list 1 2 3 ) (cons 1 (cons 2 (cons 3 () ) ) ) )
;; T
(equal 5 5)
;; T
(equal "foo" "foo")
;; T
(equal #\a #\a)
;; T

(eql 'foo 'foo)
(eql 3.6 3.6)
(eql #\q #\q)
;; Todos => T

(eql "Bob" "bob")
;; NIL
(equalp "Bob" "bob")
;; T

(eql 0 0.0)
(eq 0 0.0)
(equal 0 0.0)
;; NIL => Todos

(equalp 0 0.0)
;; T