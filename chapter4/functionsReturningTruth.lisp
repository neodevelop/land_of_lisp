(if ( member 1 '(3 4 1 5) ) 
  'number-is-in-the-list 
  'number-is-NOT-in-the-list )

(member 1 '(3 4 1 5))
;; regresa (1 5)

(if ( member nil '(3 4 nil 5) ) 
  'nil-is-in-the-list 
  'nil-is-NOT-in-the-list )
;; NIL-IS-IN-THE-LIST

( member nil '(3 4 nil 5) )
;; (NIL 5)

(find-if #'oddp '(2 4 5 6))
;; 5

(if ( find-if #'oddp '(2 4 5 6) ) 
  'there-is-an-odd-number
  'there-is-not-an-odd-number )
;; THERE-IS-AN-ODD-NUMBER

( find-if #'null '(2 4 nil 6) )
;; NIL