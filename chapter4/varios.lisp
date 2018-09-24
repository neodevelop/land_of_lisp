(if '()
	'i-am-true
	'i-am-false )

(if '(1)
    'i-am-true
    'i-am-false )

;;Calculo de una longitud de lista
(defun my-length(list)
  (if list
    (1+ (my-length (cdr list)))
    0))
    
(my-length '(list with four symbols))

(eq '() nil)
(eq '() ())
(eq '() 'nil)

(if (= (+ 2 3) 5 )
  'yup
  'nope )

(if (= (+ 2 2) 5 )
  'yup
  'nope )
  
(if (oddp 5)
  'odd-number
  'even-number)
  
(if (oddp 5)
  'odd-number
  (/ 1 0))

