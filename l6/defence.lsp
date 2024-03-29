((2 ((3)) 9) 8 ((7)) 5 (4) 1)

(defun flatten* (lst res)
  (cond ((null lst) res)
        ((consp lst) (append (flatten* (car lst) nil)
                             (flatten* (cdr lst) res)))
        ((atom lst) (cons lst res))
        (t (flatten (cdr lst) (cons (car lst) res)))))

(defun insert* (x lst res)
  (cond ((null lst) (reverse (cons x res)))
        ((< x (car lst)) (append (reverse (cons x res)) lst))
        (t (insert* x (cdr lst) (cons (car lst) res)))))

(defun sort* (lst res)
  (cond ((null lst) res)
        (t (sort* (cdr lst) (insert* (car lst) res nil)))))

(defun solve (lst)
  (reverse (sort* (flatten* lst nil) nil)))

; -----------------------------------------------------------------
; Tail-recursion version

4 (1 2 5 7 9) ()
4 (2 5 7 9) (1)
4 (5 7 9) (2 1)
5 (7 9) (4 2 1)
7 (9) (5 4 2 1)
9 () (7 5 4 2 1)
(9 7 5 4 2 1)
(1 2 4 5 7 9)

(defun insert* (x lst res)
  (cond ((null lst) (reverse (cons x res)))
        ((< x (car lst))
         (insert* (car lst) (cdr lst) (cons x res)))
        (t (insert* x (cdr lst) (cons (car lst) res)))))

((2 ((3)) 9) 8 ((7)) 5 (4) 1) ()
(2 (((3)) 9) 8 ((7)) 5 (4) 1) ()
((((3)) 9) 8 ((7)) 5 (4) 1) (2)
(((3)) (9) 8 ((7)) 5 (4) 1) (2)
((3) (9) 8 ((7)) 5 (4) 1) (2)
(3 (9) 8 ((7)) 5 (4) 1) (2)
((9) 8 ((7)) 5 (4) 1) (2 3)
(9 8 ((7)) 5 (4) 1) (2 3)
(8 ((7)) 5 (4) 1) (2 3 9)
(((7)) 5 (4) 1) (2 3 8 9)
((7) 5 (4) 1) (2 3 8 9)
(7 5 (4) 1) (2 3 8 9)
(5 (4) 1) (2 3 7 8 9)
((4) 1) (2 3 5 7 8 9)
(4 1) (2 3 5 7 8 9)
(1) (2 3 4 5 7 8 9)
() (1 2 3 4 5 7 8 9)
(1 2 3 4 5 7 8 9)

(defun f* (lst res)
  (cond ((null lst) res)
        ((consp (car lst))
         (cond ((null (cdar lst)) (f* (cons (caar lst)
                                            (cdr lst)) res))
               (t (f* (cons (caar lst)
                            (cons (cdar lst)
                                  (cdr lst))) res))))
        ((numberp (car lst))
         (f* (cdr lst) (insert* (car lst) res nil)))))

(defun f (lst)
  (f* lst nil))
