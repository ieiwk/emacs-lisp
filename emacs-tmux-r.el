(defun wk.tmux.send.a-line (&optional line1 target)
  (if line1
      (progn
        (if (not target)
            (setq target "R:R"))
        (call-process "tmux" nil nil nil "send-keys" "-t" target "-l" line1)
        (call-process "tmux" nil nil nil "send-keys" "-t" target "enter" " "))))
(defun wk.tmux.send ()
  (interactive)
  (mapcar
   'wk.tmux.send.a-line
   (if (region-active-p)
       (wk.split-lines (wk-region-string))
     (list (wk-line-string))))
  (deactivate-mark))
(defun wk.split-lines (s1 &optional trim)
  ;; trim: if true, remove "\n" at the end, if any
  (split-string (if trim (wk-string-rm-eol s1) s1) "\n"))
(defun wk-region-string ()
  ;; return as a string the content in the region
  (buffer-substring-no-properties
    (region-beginning) (region-end)))
(defun wk-line-string ()
  (buffer-substring-no-properties
    (line-beginning-position) (line-end-position)))
(defun wk-string-rm-eol (a-string &optional end)
  (if (> (length a-string) 0)
      (progn
	(if (string= (substring a-string -1) (if end end "\n"))
	    (wk-string-head a-string -1)
	  a-string))
    a-string))
(defun wk-string-head (a-string &optional n1)
  (if (not n1)
      (setq n1 10))
  (cond ((not n1)
         (setq n1 10))
	((< n1 0)
	 (setq n1 (+ (length a-string) n1))))
  (if (> n1 0)
      (progn
	(if (> n1 (length a-string))
	    (setq n1 (length a-string)))
	  (substring a-string 0 n1))))
(if (not
    (cl-member
      "R" (wk.split-lines (shell-command-to-string "tmux list-window -t R -F '#{window_name}'"))
      :test 'equal))
  (call-process "tmux" nil nil nil "new" "-s" "R" "-d" "R");启动tmux会话R
  )
(define-key ess-mode-map (kbd "C-c C-r") 'wk.tmux.send)
