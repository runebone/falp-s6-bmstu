(defparameter main "main.lisp")
(sb-ext:save-lisp-and-die "main" :executable t :toplevel (lambda () (load main) (sb-ext:quit)))
