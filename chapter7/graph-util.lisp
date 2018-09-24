(cons 1 (cons 2 (cons 3 nil)))
;;(1 2 3)
(cons 1 (cons 2 3))
;;(1 2 . 3)
'(1 . (2 . (3 . nil)))
;;(1 2 3)
(cons 2 3)
;(2 . 3)
(defparameter *foo* '(1 2 3))
(setf (cdddr *foo*) *foo*)
;; #1=(1 2 3 . #1#)
(defparameter *drink-order* '(
  (bill . double-espresso)
  (lisa . small-drip-coffee) 
  (john . medium-latte)))

(assoc 'lisa *drink-order*)
;;(LISA . SMALL-DRIP-COFFEE)
(push '(lisa . large-mocha-with-whipped-cream) *drink-order*)
;;((LISA . LARGE-MOCHA-WITH.WHIPPED-.CREAM) (BILL . DOUBLE-ESPRESSO) (LISA . SMALL-DRIP-COFFEE) (JOHN . MEDIUM-LATTE))
(assoc 'lisa *drink-order*)
;(LISA . LARGE-MOCHA-WITH.WHIPPED-.CREAM)
(defparameter *house* '( 
  (walls 
    (mortar 
      (cement) 
      (water) 
      (sand)) 
    (bricks)) 
  (windows 
    (glass) 
    (frame) 
    (curtains)) 
  (roof 
    (shingles) 
    (chimney)) ))

(defparameter *wizard-nodes* '(
  (living-room (you are in the living-room. a wizard is snoring on the couch.)) 
  (garden (you are in a beatiful garden. there is a well in front of you.)) 
  (attic (you are in the attic. there is a giant welding torch in the corner.))))
(defparameter *wizard-edges* '(
  (living-room 
    (garden west door) 
    (attic upstairs ladder))
  (garden 
    (living-room east door))
  (attic 
    (living-room downstairs ladder))))

(defun dot-name(exp)
  (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

;; (substitute-if #\e #'digit-char-p "I'm a l33t hack3r.")
;; "I'm a leet hacker."
;; (substitute-if 0 #'oddp '(1 2 3 4 5 6 7 8 9))
;; (0 2 0 4 0 6 0 8 0)
(defparameter *max-label-length* 30)

(defun dot-label (exp)
  (if exp
    (let ((s (write-to-string exp :pretty nil)))
      (if (> (length s) *max-label-length*)
        (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
        s))
    ""))

(defun nodes->dot (nodes)
  (mapc (lambda (node)
          (fresh-line)
          (princ (dot-name (car node)))
          (princ "[label=\"")
          (princ (dot-label node))
          (princ "\"];"))
        nodes))

(defun edges->dot (edges)
  (mapc (lambda (node)
          (mapc (lambda (edge)
                  (fresh-line)
                  (princ (dot-name (car node)))
                  (princ "->")
                  (princ (dot-name (car edge)))
                  (princ "[label=\"")
                  (princ (dot-label (cdr edge)))
                  (princ "\"];"))
                (cdr node)))
        edges))

(defun graph->dot (nodes edges)
  (princ "digraph {")
  (nodes->dot nodes)
  (edges->dot edges)
  (princ "}"))

(defun dot->png (fname thunk)
  (with-open-file (*standard-output*
                    fname
                    :direction :output
                    :if-exists :supersede)
    (funcall thunk))
  (ext:shell (concatenate 'string "dot -Tpng -O " fname )))

(defun graph->png (fname nodes edges)
  (dot->png fname
            (lambda ()
              (graph->dot nodes edges))))

(defun uedges->dot (edges)
  (maplist (lambda (lst)
             (mapc (lambda (edge)
                   (unless (assoc (car edge) (cdr lst))
                     (fresh-line)
                     (princ (dot-name (caar lst)))
                     (princ "--")
                     (princ (dot-name (car edge)))
                     (princ "[label=\"")
                     (princ (dot-name (cdr edge)))
                     (princ "\"];")))
                   (cdar lst)))
           edges))

(defun ugraph->dot (nodes edges)
  (princ "graph {")
  (nodes->dot nodes)
  (uedges->dot edges)
  (princ "}"))

(defun ugraph->png (fname nodes edges)
  (dot->png fname
            (lambda ()
              (ugraph->dot nodes edges))))
