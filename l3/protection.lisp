(defun get_diskr (a b c)
  (- (* b b) (* 4 a c)))

(defun get_real_roots (a b c)
  (cons (- (- (/ b (* 2 a))) (sqrt (get_diskr a b c)))
        (cons (+ (- (/ b (* 2 a))) (sqrt (get_diskr a b c))) nil)))

(defun get_complex_roots (a b c)
  (cons (cons (- (/ b (* 2 a))) (- (sqrt (abs (get_diskr a b c)))))
        (cons (cons (- (/ b (* 2 a))) (+ (sqrt (abs (get_diskr a b c))))) nil)))

(defun f (a b c)
  (cond ((= a 0)
         (cond ((= b 0)
                (cond ((= c 0) 'R)
                      (t nil)))
               (t (cons (- (/ c b)) nil))))
        (t
           (cond ((< (get_diskr a b c) 0) (get_complex_roots a b c))
                 (t (get_real_roots a b c))))))
