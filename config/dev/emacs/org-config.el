(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'flyspell-mode)

;; Exclude holidays
(setq holiday-bahai-holidays nil
      holiday-hebrew-holidays nil
      holiday-islamic-holidays nil)

(setq org-agenda-include-diary t)

(setq org-log-done 'time)
(setq org-priority-faces '((?A . (:foreground "#F1DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

(setq agenda-files (list "thesis-todo.org"
                         "gtd.org"
                         "projects.org"
                         "work.org"
                         "calendar.org"
                         "call.org"
                         "birthdays.org"))

(setq org-agenda-files (mapcar
                        (lambda (s) (f-join org-agenda-directory s))
                        agenda-files))

(setq org-capture-templates
      `(("T" "Thesis todo" entry
         (file+headline ,(f-join org-agenda-directory "thesis-todo.org") "Thesis Tasks")
         "* TODO %?\n  %i\n  %a")
        ("t" "Todo" entry
         (file+headline ,(f-join org-agenda-directory "gtd.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("p" "Project Todo" entry
         (file+headline ,(f-join org-agenda-directory "projects.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("w" "Work Todo" entry
         (file+headline ,(f-join org-agenda-directory "work.org") "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("c" "Call someone" entry
         (file+headline ,(f-join org-agenda-directory "call.org") "To call")
         "* TODO %?\n  %i\n")
        ))
