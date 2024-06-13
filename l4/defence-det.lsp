(load "~/quicklisp/setup.lisp")
(ql:quickload "fiveam")

; (defun gen-nil-list* (n res)
;   (cond ((= n 0) res)
;         ((and (= n 1) (null res)) (cons nil nil))
;         (t (gen-nil-list* (- n 1) (cons nil res)))))

; (defun gen-nil-list (n)
;   (gen-nil-list* n nil))

; (defun form-minor* (matr dim res)
;   (cond ((null res) (form-minor* matr dim (gen-nil-list dim)))
;         ((= 0 dim) res)
;         (t (form-minor* (mapcar #'cdr matr)
;                        (- dim 1)
;                        (mapcar #'(lambda (lst1 lst2)
;                                    (cons (car lst1)
;                                          lst2)) matr res)))))

; (defun form-minor (matr dim)
;   (mapcar #'reverse (form-minor* matr dim nil)))

(defun transpose (lst)
  (apply 'mapcar 'list lst))

; (defun get-minor* (matr row col n)
;   (cond ((and (= row 0) (= col 0)) (form-minor matr n))
;         ((> row 0) (get-minor* (cdr matr) (- row 1) col n))
;         ((> col 0) (get-minor* (transpose matr) col row n))))

; (defun get-minor (matr row col n)
;   (cond ((and (= row 0) (= col 0)) (form-minor matr n))
;         (t (transpose (get-minor* matr row col n)))))

(defun delete-nth-row (matr n res)
  (cond ((= 0 n) (if (null res)
                   (cdr matr)
                   (append res (cdr matr))))
        (t (delete-nth-row (cdr matr)
                           (- n 1)
                           (append res (cons (car matr) nil))))))

(defun get-leftover-minor (matr i j)
  ; ((lambda () (princ matr) (terpri) (princ i) (terpri) (princ j) (terpri)
  (cond ((and (= -1 i) (= -1 j)) (transpose matr))
        ((= -1 i) (get-leftover-minor (transpose matr) j i))
        ((> i -1) (get-leftover-minor
                    (delete-nth-row matr i nil) -1 j))));))

(defun get-det-sum (row matr dim cnt res)
  ; ((lambda ()
  ;    (princ row) (terpri)
  ;    (princ matr) (terpri)
  ;    (princ dim) (terpri)
  ;    (princ cnt) (terpri)
  ;    (princ res) (terpri)
  (cond ((null row) res)
        ((evenp cnt)
         (get-det-sum (cdr row) matr dim (+ 1 cnt)
                      (+ res (* (car row)
                         (det (get-leftover-minor matr 0 cnt)
                              (- dim 1))))))
        ((oddp cnt)
         (get-det-sum (cdr row) matr dim (+ 1 cnt)
                      (- res (* (car row)
                         (det (get-leftover-minor matr 0 cnt)
                              (- dim 1))))))));))

(defun det (matr dim)
  (cond ((null matr) nil)
        ((numberp matr) matr)
        ((and (numberp (car matr)) (= 1 dim))
         (car matr))
        ((= 2 dim)
         (- (* (caar matr)
               (cadadr matr))
            (* (cadar matr)
               (caadr matr))))
        (t (get-det-sum (car matr) matr dim 0 0))))

(defun multrow (nrow matr k res)
  (cond ((= 0 nrow) (if (null res)
                      (append (list
                                (mapcar #'(lambda (x) (* x k))
                                        (car matr))) (cdr matr))
                      (append res (list
                                    (mapcar #'(lambda (x) (* x k))
                                            (car matr))) (cdr matr))))
        (t (multrow (- nrow 1)
                    (cdr matr)
                    k
                    (append res (cons (car matr) nil))))))

(defun getnrow (matr n)
  (cond ((= 0 n) (car matr))
        (t (getnrow (cdr matr) (- n 1)))))

(defun diffrow* (matr row fromnrow res)
  (cond ((= 0 fromnrow) (if (null res)
                          (append (list
                                    (mapcar #'(lambda (x y) (- y x))
                                        row (car matr))) (cdr matr))
                          (append res (list
                                    (mapcar #'(lambda (x y) (- y x))
                                        row (car matr))) (cdr matr))))
        (t (diffrow* (cdr matr) row (- fromnrow 1)
                     (append res (cons (car matr) nil))))))

(defun diffrow (matr nrow fromnrow res)
  (diffrow* matr (getnrow matr nrow) fromnrow res))

; (defun diffrow (matr nrow fromrow tmprow res)
;   (cond ((= 0 nrow) (if (null res)
;                       (append (list
;                                 (mapcar #'(lambda (x y) (+ x y))
;                                         (car matr))) (cdr matr))
;                       (append res (list
;                                     (mapcar #'(lambda (x) (* x k))
;                                             (car matr))) (cdr matr))))

(defun gen-nil-list* (n res)
  (cond ((= n 0) res)
        ((and (= n 1) (null res)) (cons nil nil))
        (t (gen-nil-list* (- n 1) (cons nil res)))))

(defun gen-nil-list (n)
  (gen-nil-list* n nil))

(defun form-minor* (matr dim res)
  (cond ((null res) (form-minor* matr dim (gen-nil-list dim)))
        ((= 0 dim) res)
        (t (form-minor* (mapcar #'cdr matr)
                       (- dim 1)
                       (mapcar #'(lambda (lst1 lst2)
                                   (cons (car lst1)
                                         lst2)) matr res)))))

(defun form-minor (matr dim)
  (mapcar #'reverse (form-minor* matr dim nil)))

(defun get-minor* (matr row col n)
  (cond ((and (= row 0) (= col 0)) (form-minor matr n))
        ((> row 0) (get-minor* (cdr matr) (- row 1) col n))
        ((> col 0) (get-minor* (transpose matr) col row n))))

(defun get-minor (matr row col n)
  (cond ((and (= row 0) (= col 0)) (form-minor matr n))
        (t (transpose (get-minor* matr row col n)))))

(defun get2x2 (matr i j)
  (get-minor matr i j 2))

(defun get-condensed-row* (matr dim-cnt nrow res)
  (cond ((= dim-cnt 0) res)
        (t (get-condensed-row* matr (- dim-cnt 1) nrow
                               (append res (get2x2 matr nrow dim-cnt))))))

(defun get-condensed-row (matr dim nrow)
  (get-condensed-row* matr dim nrow nil))

(defun get-condensed-matrix (matr dim res)


(defun dc (matr dim)
  (cond ((null matr) nil)
        ((numberp matr) matr)
        ((and (numberp (car matr)) (= 1 dim))
         (car matr))
        ((= 2 dim)
         (- (* (caar matr)
               (cadadr matr))
            (* (cadar matr)
               (caadr matr))))
        (

(fiveam:test test1
  (fiveam:is (equal (det '() 5) nil)))

(fiveam:test test2
  (fiveam:is (equal (det '(1) 1) 1)))

(fiveam:test test3
  (fiveam:is (equal (det '(-1) 1) -1)))

(fiveam:test test4
  (fiveam:is (equal (det '((3 5) (7 11)) 2) -2)))

(fiveam:test test5
  (fiveam:is (equal (det '((1 2 3) (4 5 6) (7 8 9)) 3) 0)))

(fiveam:test test6
  (fiveam:is (equal (det '((1 0 0 0 0) (0 3 0 0 0) (0 0 5 0 0) (0 0 0 7 0) (0 0 0 0 11)) 5) 1155)))

(fiveam:test test7
  (fiveam:is (equal (det '((0 3 -1 1) (1 2 0 0) (0 4 3 5) (2 -1 -4 -2)) 4) -58)))

(fiveam:run!)
