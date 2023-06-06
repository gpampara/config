;; Update the load-path to consider mu4e
(add-hook 'emacs-startup-hook 'load-mu4e t)

(defun load-mu4e ()
  (add-to-list 'load-path mu4e-load-path)
  (require 'mu4e)

  ;; Configutation of mu4e itself

  ;; Make sure that moving a message (like to Trash) causes the
  ;; message to get a new file name.  This helps to avoid the
  ;; dreaded "UID is N beyond highest assigned" error.
  ;; See this link for more info: https://stackoverflow.com/a/43461973
  (setq mu4e-change-filenames-when-moving t)

  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Maildir")

  ;; Set up contexts for email accounts
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "Personal"
          :enter-func (lambda () (mu4e-message "Entering Private context"))
          :leave-func (lambda () (mu4e-message "Leaving Private context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/gpampara@gmail.com" (mu4e-message-field msg :maildir))))
          :vars '( (user-full-name     . "Gary Pamparà")
                   (user-mail-address  . "gpampara@gmail.com")
                   (mu4e-drafts-folder . "/gpampara@gmail.com/[Gmail]/Drafts")
                   (mu4e-sent-folder   . "/gpampara@gmail.com/[Gmail]/Sent Mail")
                   (mu4e-refile-folder . "/gpampara@gmail.com/[Gmail]/All Mail")
                   (mu4e-trash-folder  . "/gpampara@gmail.com/[Gmail]/Trash")
                   (mu4e-sent-messages-behavior . sent)
                   ))

         (make-mu4e-context
          :name "Work"
          :enter-func (lambda () (mu4e-message "Entering Private context"))
          :leave-func (lambda () (mu4e-message "Leaving Private context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/garyp@circuithub.com" (mu4e-message-field msg :maildir))))
          :vars '( (user-full-name     . "Gary Pamparà")
                   (user-mail-address  . "garyp@circuithub.com")
                   (mu4e-drafts-folder . "/garyp@circuithub.com/[Gmail]/Drafts")
                   (mu4e-sent-folder   . "/garyp@circuithub.com/[Gmail]/Sent Mail")
                   (mu4e-refile-folder . "/garyp@circuithub.com/[Gmail]/All Mail")
                   (mu4e-trash-folder  . "/garyp@circuithub.com/[Gmail]/Trash")
                   (mu4e-sent-messages-behavior . sent)
                   ))
         ))

  ;; (setq mu4e-context-policy 'pick-first)

  ;; Display options
  (setq mu4e-view-show-images t)
  (setq mu4e-view-show-addresses 't)
  (setq mu4e-headers-date-format "%F") ; ISO8601 date format because american format is retarded

  ;; Composing mail
  (setq mu4e-compose-dont-reply-to-self t)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t))
