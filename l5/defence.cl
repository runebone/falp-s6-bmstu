(load "~/University/falp/l5/quicklisp.lisp")
(load "~/quicklisp/setup.lisp")
(ql:quickload "fiveam")

(in-package :cl-user)
(defpackage my-test (:use :cl :fiveam))
(in-package :my-test)

(setf b '(-3 -2 0 1 a))

(setf a 'b)

(defun a (lst)
  (cond 
    ((and (numberp (car lst)) (> 0 (car lst)) (oddp (car lst)))
     (cons (* (car lst) (car lst)) (a (cdr lst))))
    ((and (numberp (car lst)) (> 0 (car lst)) (evenp (car lst)))
     (cons (+ 20 (car lst)) (a (cdr lst))))
    ((and (numberp (car lst)) (= 0 (car lst)))
     (cons (car lst) (a (cdr lst))))
    ((and (numberp (car lst)) (< 0 (car lst)))
     (cons (- (car lst) 10) (a (cdr lst))))
    ((and (atom lst) (not (null lst)) (not (numberp lst)))
     (cons (car lst) (a (cdr lst))))
    (t lst)))

(a (eval a))

(def-suite my-system
  :description "Test my system")

(test all
  (is (and (equal (a (eval a)) '(9 18 0 -9 a))
           (equal b '(-3 -2 0 1 a))))
  (is (equal (a nil) nil)))

(run! 'all)
