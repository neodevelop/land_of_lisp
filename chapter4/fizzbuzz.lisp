;; función fizzbuzz con el uso de cond
(defun fizz-buzz(n)
  (cond ( (eq (mod n (* 3 5) ) 0) '(fizzbuzz) )
        ( (eq (mod n 5 ) 0) '(buzz) )
        ( (eq (mod n 3 ) 0) '(fizz) )
        ( t n ) ) )

;; Este loop no me sifrve solo estaba probando
(defvar *n* 1)
(loop
  ( setf *n* (+ *n* 1) )
  ( when (> *n* 100) ( return ) ) )

;; Ejecución de fizzbuzz
(do
  ( (x 1 (+ x 1)) )
  ((> x 100))
  (print (fizz-buzz x)) )
