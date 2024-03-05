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
(defun easy (lst) (car (last lst)))

(defun hard (lst) ; FIXME (cdr lst) DRY
  (cond ((and (consp lst) (not (atom (cdr lst))) (consp (cdr lst)))
         (hard (cdr lst))) ; cdr until we can't
        ((null (cdr lst))
         (car lst))
        (t lst))) ; lst is dotted pair

; 4. Написать, по крайней мере, два варианта функции, которая возвращает свой список аргументов без последнего элемента
(defun f4v1 (lst)
  (cond ((and (not (null lst)) (atom (cdr lst)))
         nil)
        (t (cons (car lst) (f4v1 (cdr lst))))))

; TODO v2

; 5. Напишите функицю swap-first-last, которая переставляет в списке-аргументе первый и последний элементы
(defun swap-first-last (lst)
  (let ((tmp (cons (car lst) (car (last lst)))))
    (setf (car lst) (cdr tmp))
    (setf (car (last lst)) (car tmp)))
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

; 7. Написать функцию, которая по своему списку-аргументу lst определяет, является ли он палиндромом (то есть равны ли lst и (reverse lst))
(defun listeq (lst1 lst2)
  (cond ((and (null lst1) (null lst2)) t)
        ((eql (car lst1) (car lst2))
         (listeq (cdr lst1) (cdr lst2)))
        (t nil)))

(defun is-palindrome (lst)
  (listeq lst (reverse lst)))

; 8. Напишите свои необходимые функции, которые обрабатывают таблицу из 4-х точечных пар: (страна . столица), и возвращают по стране - столицу, а по столице - страну.
(defun insert (key value table)
  (setf table (acons key value table)))

(defun get-value (key table)
  (cond ((null table) nil)
        ((eql (car (car table)) key)
         (cdr (car table)))
        (t (get-value key (cdr table)))))

(defun get-key (value table)
  (cond ((null table) nil)
        ((eql (cdr (car table)) value)
         (car (car table)))
        (t (get-key value (cdr table)))))

; 9. Напишите функцию, которая умножает на заданное число-аргумент первый числовой элемент списка из заданного 3-х элементного списка-аргумента, когда а) все элементы списка - числа, б) элементы списка - любые объекты.
(defun strange-rec (x lst3 count)
  (let ((head (car lst3)))
    (cond ((numberp head)
           (setf (car lst3) (* x head)))
          ((> count 1)
           (strange-rec x (cdr lst3) (- count 1))))))

(defun strange (x lst3)
  ((lambda ()
    (strange-rec x lst3 3)
    lst3)))
