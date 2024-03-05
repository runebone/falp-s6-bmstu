; 1. Чем принципиально отличаются функции cons, list, append?
; Пусть
(setf lst1 '(a b c))
(setf lst2 '(d e))
; Каковы результаты вычисления следующих выражений
(cons lst1 lst2) ; ((A B C) D E)
(list lst1 lst2) ; ((A B C) (D E))
(append lst1 lst2) ; (A B C D E)

; 2. Каковы результаты вычисления следующих выражений и почему?
(reverse '(a b c)) ; (C B A)
; (reverse l) возвращает список элементов l в обратном порядке, не разрушая структуру l
(reverse ()) ; NIL
(reverse '(a b (c (d)))) ; ((C (D)) B A)
; Встроенные функции lisp работают только со списковыми ячейками верхнего уровня
(reverse '((a b c))) ; ((A B C))
(reverse '(a)) ; (A)
(last '(a b c)) ; (C)
; (last l) возвращает последнюю списковую ячейку l
(last '(a)) ; (A)
(last '((a b c))) ; ((A B C))
; ((a b c)) - список, состоящий из одной списковой ячейки, у которой car-указатель указывает на список (a b c), а cdr-указатель - на nil
(last '(a b (c))) ; ((C))
; (a b (c)) - список, состоящий из трех списковых ячеек; car-указатель последней указывает на список (C)
(last ()) ; NIL

; 3. Написать, по крайней мере, два варианта функции, которая возвращает последний элемент своего списка-аргумента
(defun easy (l) (car (last l)))

(defun hard (l) ; FIXME (cdr l) DRY
  (cond ((and (consp l) (not (atom (cdr l))) (consp (cdr l)))
         (hard (cdr l))) ; cdr until we can't
        ((null (cdr l))
         (car l))
        (t l))) ; l is dotted pair

; 4. Написать, по крайней мере, два варианта функции, которая возвращает свой список аргументов без последнего элемента
(defun f4v1 (l)
  (cond ((and (not (null l)) (atom (cdr l)))
         nil)
        (t (cons (car l) (f4v1 (cdr l))))))

; TODO v2

; 5. Напишите функицю swap-first-last, которая переставляет в списке-аргументе первый и последний элементы
(defun swap-first-last (l)
  (let ((tmp (cons (car l) (car (last l)))))
    (setf (car l) (cdr tmp))
    (setf (car (last l)) (car tmp)))
  l)

; 6. Написать простой вариант игры в кости, в котором бросаются две правильные кости. Если сумма выпавших очков равна 7 или 11 - выигрыш, если выпало (1,1) или (6,6) - игрок имеет право снова бросить кости, во всех остальных случаях ход переходит ко второму игроку, но запоминается сумма выпавших очков. Если второй игрок не выигрывает абсолютно, то выигрывает тот игрок, у которого больше очков. Результат игры и значения выпавших костей выводить на экран с помощью функции print.
(defun throw-one-dice ()
  (+ 1 (random 6)))

(defun throw-two-dice ()
  (cons (throw-one-dice) (throw-one-dice)))

(defun is-rethrow-possible (dice)
  (cond ((and (equal (car dice) (cdr dice))
              (or (equal (car dice) 1) (equal (car dice) 6)))
         t)
        (t nil)))

(defun get-dice-sum (dice)
  (+ (car dice) (cdr dice)))

(defun is-absolute-win (dice)
  (let ((sum (get-dice-sum dice)))
    (cond ((or (equal sum 7) (equal sum 11)) t)
          (t nil))))

(defun play-dice-rethrow (pr)
  (let ((nr (cons nil nil))
        (ans nil))
    (setf nr (throw-two-dice))
    (cond ((is-rethrow-possible nr)
           ((lambda ()
              (princ "Результат - ")
              (princ nr)
              (terpri)
              (princ "Хотите перебросить? [y/n] > ")
              (setf ans (read))
              (cond ((or (eql ans 'y) (eql ans 'yes))
                     (play-dice-rethrow pr))
                    (t nr))
              )))
          (t nr))))


(defun play-dice ()
  (let ((fpr (cons nil nil))
        (spr (cons nil nil)))
    (princ "Ход игрока 1.")
    (terpri)
    (setf fpr (play-dice-rethrow fpr))
    (cond ((is-absolute-win fpr)
           ((lambda ()
                (princ fpr)
                (princ " - ")
                (princ "Игрок 1 выигрывает абслютно.")
                (terpri)
                fpr
            )))
          (t ((lambda ()
                  (princ "Результат игрока 1 - ")
                  (princ fpr)
                  (terpri)
                  (princ "Ход игрока 2.")
                  (terpri)
                  (setf spr (play-dice-rethrow spr))
                  (cond ((is-absolute-win spr)
                         ((lambda ()
                              (princ spr)
                              (princ " - ")
                              (princ "Игрок 2 выигрывает абслютно.")
                              (terpri)
                              (princ "Счет игрока 1 - ")
                              (princ fpr)
                                (princ " | ")
                                (princ (get-dice-sum fpr))
                                (terpri)
                                (princ "Счет игрока 2 - ")
                                (princ spr)
                                (princ " | ")
                                (princ (get-dice-sum spr))
                              (terpri)
                              spr
                          )))
                        (t ((lambda ()
                                (princ "Счет игрока 1 - ")
                                (princ fpr)
                                (princ " | ")
                                (princ (get-dice-sum fpr))
                                (terpri)
                                (princ "Счет игрока 2 - ")
                                (princ spr)
                                (princ " | ")
                                (princ (get-dice-sum spr))
                                (terpri)
                                (cond ((< (get-dice-sum fpr) (get-dice-sum spr))
                                       ((lambda ()
                                            (princ "Игрок 2 побеждает.")
                                            spr
                                        )))
                                      ((> (get-dice-sum fpr) (get-dice-sum spr))
                                       ((lambda ()
                                            (princ "Игрок 1 побеждает.")
                                            fpr
                                        )))
                                      (t ((lambda ()
                                              (princ "Ничья.")
                                              fpr
                                          )))
                            ))))
              )))))))

