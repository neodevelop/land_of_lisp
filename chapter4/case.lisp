(defvar *archi-enemigo* nil)

(defun pudding-eater(person) 
  (case person 
    ( (henry) (setf *archi-enemigo* 'estupido-alien-lisp)
              '(curse you lisp alien - ypou ate my pudding) ) 
    ( (johnny) (setf *archi-enemigo* 'viejo-inutil-john)
              '(Espero que te haga daño Juanito) ) 
    ( otherwise '(Quiene res tu extraño?) ) ) )