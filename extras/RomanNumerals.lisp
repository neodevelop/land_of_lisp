;; -*- coding: utf-8; mode: common-lisp -*-
;; num-roman.lisp

(setq matriz-numerales 
      (make-array '(10 4) 
        :initial-contents '((""     ""     ""     "" )
                            ("I"    "X"    "C"    "M")
                            ("II"   "XX"   "CC"   "MM")
                            ("III"  "XXX"  "CCC"  "MMM")
                            ("IV"   "XL"   "CD"   "")
                            ("V"    "L"    "D"    "")
                            ("VI "  "LX"   "DC"   "")
                            ("VII"  "LXX"  "DCC"  "")
                            ("VIII" "LXXX" "DCCC" "")
                            ("IX"   "XC"   "CM"   "")) ))

(defun num-roman (n) 
  (setq retval "")
  (setq cad-num (reverse (princ-to-string n)))
  (loop for pos from (- (length cad-num) 1) downto 0 do
       (setq num (parse-integer (string (elt cad-num pos))))
       (setq retval (concatenate 'string 
                                 retval 
                                 (aref matriz-numerales num pos))) )
  retval )
