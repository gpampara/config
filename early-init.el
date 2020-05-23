;; For Emacs 27 and above
(setq package-enable-at-startup nil)

;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Prevent the glimpse of un-styled Emacs by setting these early.
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))
