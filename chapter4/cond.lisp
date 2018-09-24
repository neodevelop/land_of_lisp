(defvar *arch-enemy* nil)
(defun pudding-eater (person)
  (cond 
    ( (eq person 'henry) 
        (setf *arch-enemy* 'stupid-lisp-alien)
        '(curse you lisp alien - you ate my pudding) )
    ( (eq person 'johnny) 
        (setf *arch-enemy* 'useless-old-johnny)
        '(i hope you choked my puddin johnny) )
    ( t 
        (setf *arch-enemy* 'lisper-stranger)
        '(why you eat my puddin strangers ?) ) ) )