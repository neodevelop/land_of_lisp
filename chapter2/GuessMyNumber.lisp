(defparameter *small* 1)
(defparameter *big* 100)

(defun guess-my-number()
  (ash (+ *small* *big*) -1))

(defun smaller()
  (setf *big* (1- (guess-my-number)))
  (guess-my-number)
)

(defun bigger()
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number)
)

(defun start-over()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))
  
(let ((a 5)
      (b 7)
      (c 9))
    (+ a b c)
)

(flet ( (f(n)
          (+ n 10) )
        (g(n)
          (- n 8) ))
  (f (g 5)))

(labels ( (a(n)
            (+ n 10))
          (b(n)
            (+ (a n) 5))
        )
  (b 6))