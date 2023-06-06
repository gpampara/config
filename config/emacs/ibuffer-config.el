(setq ibuffer-saved-filter-groups
      '(("default"
         ("emacs-config" (or (filename . ".emacs.d")
                             (filename . "emacs-config")))
         ("Org" (or (mode . org-mode)
                    (filename . "OrgMode")))
         ("Magit" (name . "magit.*"))
         ("Help" (or (mode . help-mode)
                     (mode . Info-mode)
                     (name . ".*Apropos.*"))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)

(setq ibuffer-expert t)
