(setq dashboard-week-agenda t)

(setq dashboard-projects-backend 'project-el)

;; TODO: add the agenda for the current day that is more flexible than the default implementation in dashboard.el
;; The filter should take all agenda items for the current day and display them (including birthdays)
(setq dashboard-items '((agenda . 10)
                        (projects . 10)
                        (recents . 10)))

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(setq default-directory (concat (getenv "HOME") "/"))

(setq dashboard-agenda-release-buffers t) ;; Release org buffers for agenda data

;; Show buttons
(setq dashboard-set-navigator t)

;; Format: "(icon title help action face prefix suffix)"
(setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-octicon "mail" :height 1.1 :v-adjust 0.0)
          "Email"
          "Open email"
          (lambda (&rest _) (mu4e))))))


;; new agenda generator
;;(seq-mapcat (lambda (file) (org-agenda-get-day-entries file (calendar-current-date))) (org-agenda-files))

;;(setq dashboard-projects-switch-function (lambda (projectDir)
;;                                           (magit-status projectDir)))

(dashboard-setup-startup-hook)
