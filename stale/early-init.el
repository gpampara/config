;;; For performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))

(setq package-enable-at-startup nil)

(setq inhibit-startup-screen t)  ; don't display the help screen
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Prevent the glimpse of un-styled Emacs by setting these early.
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))
