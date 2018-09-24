;; wizards_adventure_game.lisp
(defparameter *nodes* '( (living-room (you are in living room. a wizard is snoring loudly on the couch.))
	(garden (you are in a beatiuful garden. there is a well in front of you.) ) 
	(attic (you are in the attic. there is a giant welding torch in the corner.) ) ) )

;; ( print (assoc 'garden *nodes*) )

(defun describe-location(location nodes)
  ( cadr (assoc location nodes) ) )

;; (describe-location 'living-room *nodes*)
;; (print (describe-location 'living-room *nodes*))

(defparameter *edges* '((living-room (garden west door) (attic upstairs ladder))
  (garden (living-room east door))
  (attic (living-room downstairs ladder))))

(defun describe-path(edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.)) ;; Ojo con el primer caracter, FLIP-FLOP

;; (describe-path '(garden west door))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path(cdr (assoc location edges)))))

;; (cdr (assoc 'living-room *edges*))

;; (mapcar #'describe-path '((GARDEN WEST DOOR) (ATTIC UPSTAIRS LADDER)))

;; (mapcar #'sqrt '(1 2 3 4 5))

;; (mapcar #'car '((foo bar) (baz bax))) ;; (FOO BAZ)
;; (mapcar (function car) '((foo bar) (baz bax)))

;; (append '(mary had) '(a) '(little lamb)) ;; (MARY HAD A LITTLE LAMB)
;; (append '((mary had) (a) (little lamb))) ;; ((MARY HAD) (A) (LITTLE LAMB)) Difference
;; (apply #'append '((mary had) (a) (little lamb))) ;; (MARY HAD A LITTLE LAMB)   Yeah!!!

;; (apply #'append '( (there is a door going west from here.) (there is a ladder going upstairs from here.)))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '( 
	(whiskey living-room) 
	(bucket living-room) 
	(chain garden) 
	(frog garden) ))

(defun objects-at (loc objs obj-locs)
	(labels ((at-loc-p (obj)
		(eq (cadr (assoc obj obj-locs)) loc)))
		(remove-if-not #'at-loc-p objs)))
;; (objects-at 'living-room *objects* *object-locations*) ;; (WHISKEY BUCKET)
;; (remove-if-not #'oddp '(1 2 3 4 5 6 7 8)) ;; (1 3 5 7)

(defun describe-objects (loc objs obj-loc)
	(labels ((describe-obj (obj)
    `(you see a ,obj on the floor.)))
  (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

(defparameter *location* 'living-room)

;; Esto no es puramente funcional por que esta leyendo una variable externa
(defun look()
  (append (describe-location *location* *nodes*)
    (describe-paths *location* *edges*)
    (describe-objects *location* *objects* *object-locations*))) 

(defun walk(direction)
  (let ((next (find direction 
    (cdr (assoc *location* *edges*))
    :key #'cadr))) ;; next = (edge) o NIL
  (if next
    (progn (setf *location* (car next))
      (look))
    '(you cannot go that way.))))

;; (find 'y '((5 x) (3 y) (7 z)) :key #'cadr) ;; => (3 Y)
;; (find 4 '((2) (4) (6) (8)))
;; (find 4 '((2) (4) (6) (8)) :key #'car)
;; (assoc *location* *edges*) ;; => (LIVING-ROOM (GARDEN WEST DOOR) (ATTIC UPSTAIRS LADDER))
;; (cdr (assoc *location* *edges*)) ;; => ((GARDEN WEST DOOR) (ATTIC UPSTAIRS LADDER))
;; (find 'west (cdr (assoc *location* *edges*)) :key #'cadr) => (GARDEN WEST DOOR)
;; (find 'noplace (cdr (assoc *location* *edges*)) :key #'cadr)
;; NIL

(defun pickup(object)
  (cond ((member object
    (objects-at *location* *objects* *object-locations*))
  (push (list object 'body) *object-locations*)
    `(you are now carrying ,object))
  (t '(you cannot get that.))))

;; (defparameter *foo* '(1 2 3))
;; (push 7 *foo*) ;; => (7 1 2 3)
;; (push (list object 'body) *object-locations*) ;; => ((CHAIN BODY) (WHISKEY BODY) (WHISKEY BODY)  ...)

(defun inventory()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))