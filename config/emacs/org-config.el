(add-hook 'org-mode-hook #'org-indent-mode)

;; Exclude holidays
(setq holiday-bahai-holidays nil
      holiday-hebrew-holidays nil
      holiday-islamic-holidays nil)

(setq org-agenda-include-diary t)

(setq org-log-done 'time)
(setq org-priority-faces '((?A . (:foreground "#F1DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

(setq agenda-files (list "projects.org"
                         "birthdays.org"))

(setq org-agenda-files (mapcar
                        (lambda (s) (f-join org-agenda-directory s))
                        agenda-files))

;; (setq org-capture-templates
;;       `(("w" "Work Todo" entry
;;          (file+headline ,(f-join org-agenda-directory "work.org") "Tasks")
;;          "* TODO %?\n  %i\n  %a")
;;         ("c" "Call someone" entry
;;          (file+headline ,(f-join org-agenda-directory "call.org") "To call")
;;          "* TODO %?\n  %i\n")
;;         ))
