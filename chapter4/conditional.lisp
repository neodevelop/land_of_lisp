(and (oddp 2) (oddp 7) (oddp 7))
(or (oddp 2) (oddp 7) (oddp 7))

;; Trucos de qasignación con lisp
(defparameter *is-it-even* nil)
*is-it-even*
(or (oddp 4) (setf *is-it-even* t))
*is-it-even*

