(defmacro wk.eval-return (body)
  `(catch '37_04_18_101335
     ,body))
(defmacro wk.return (&optional args)
  `(throw '37_04_18_101335 ,args))
;; (wk.eval-return (wk.return))
;; (wk.eval-return (if t (wk.return '("a" 1))))
