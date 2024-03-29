(defmacro wk.eval-return (&rest body)
  `(catch '37_04_18_101335
     (progn ,@body)))
(defmacro wk.return (&optional args)
  `(throw '37_04_18_101335 ,args))
;; (wk.eval-return (wk.return))
;; (wk.eval-return (if t (wk.return '("a" 1))))
;; (wk.eval-return (if nil (wk.return '("a" 1))) (message "37_04_18_104329"))
(defmacro wk.repeat (&rest body)
  (if body
      `(catch '37_04_18_101335
         (while t ,@body))))

(setq wk.obarray [])
(defun wk.intern (string1 &optional wk.obarray)
  (intern string1 wk.obarray))
