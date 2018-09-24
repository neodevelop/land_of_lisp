(load "../chapter5/wizards_adventure_game.lisp")

(progn (print "this")
	(print "is")
	(print "a")
 	(print "text"))

(progn (prin1 "this")
	(prin1 "is")
	(prin1 "a")
 	(prin1 "text"))

(defun say-hello()
	(print "Please type yout name.")
	(let ((name (read)))
    (print "Nice to meet you, ")
    (print name)))

(defun add-five()
  (print "Please type a number.")
  (let ((num (read)))
    (print "When I add five(5) is: ")
    (print (+ 5 num))))

(print '3) ;; entero
(print '3.4) ;; flotante
(print 'foo) ;; symbol
(print '"foo") ;; string
(print '#\a) ;; caracter
(print '#\newline)
(print '#\tab)
(print '#\space)

(princ '3)
(princ '3.1416)
(princ 'foo)
(princ '"foo")
(princ '#\newline)

(progn (princ "This sentence will be interrupted")
	(princ #\newline)
  (princ '#\tab)
  (princ "by an annoying newline character."))

(defun new-say-hello()
  (princ "Say your name:")
  (let ((name (read-line)))
    (princ "Nice to meet you:")
    (princ name)))

; (+ 1 2 3) ; => 6
; '(+ 1 2 3) ; => '(+ 1 2 3)

(defparameter *foo* '(+ 1 2 3)) ;; => '(+ 1 2 3) como dato
(eval *foo*) ;; => 6

(defun game-repl()
  (loop (print (eval (read)))))

(defun new-game-repl()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit) 
      (game-print (game-eval cmd)) 
      (new-game-repl))))

(defun game-read ()
  (let ((cmd (read-from-string 
    (concatenate 'string "(" (read-line) ")"))))
  (flet ((quote-it (x) 
    (list 'quote x)))
  (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))
; Poniendo comandos validos
(defparameter *allowed-commands* '(look walk pickup inventory))
; Funcion eval personalizad con el match de comandos validos
(defun game-eval(sexp)
  (if (member (car sexp) *allowed-commands*)
    (eval sexp) 
    '(i do not know that command.)))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
      (rest (cdr lst))) 
    (cond ( (eql item #\space) (cons item (tweak-text rest caps lit)) )
      ( (member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)) )
      ( (eql item #\") (tweak-text rest caps (not lit)) )
      (lit (cons item (tweak-text rest nil lit)))
      (caps (cons (char-upcase item) (tweak-text rest nil lit)))
      (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  (princ (coerce (tweak-text (coerce (string-trim "() " 
    (prin1-to-string lst)) 
  'list) 
  t 
  nil) 
  'string)) 
  (fresh-line))
