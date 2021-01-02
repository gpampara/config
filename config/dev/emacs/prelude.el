(setq inhibit-startup-screen t)

;; Stop creating backup and autosave files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customise a few things if the current system is macOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq system-type 'darwin)
  ;; Swap the super and option keys
  (setq mac-command-modifier 'meta
        mac-option-modifier 'super)

  (setq mac-pass-command-to-system nil) ; Prevent the system interpretting commands

  ;; Start Emacs fullscreen
  (setq ns-use-native-fullscreen t)
  ;;(set-frame-parameter nil 'fullscreen 'maximized))
  (add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

  ;; The version of `ls` on darwin does not support an option which is
  ;; present in GNU coreutils' version of `ls`
  (setq ls-lisp-use-insert-directory-program nil)
  (require 'ls-lisp)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some basic configuration changes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq sentence-end-double-space nil)   ; Sentences _SHOULD_ end with only a point.
(setq require-final-newline t)         ; Ensure there is a final newline
(setq confirm-kill-emacs 'y-or-n-p)    ; Confirm really quit emacs
(defalias 'yes-or-no-p 'y-or-n-p)      ; Shorten yes/no prompts to y/n

;; Always get rid of trailing whitespace. Always.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; I don't want tabs for indenting
(setq-default indent-tabs-mode nil)

;; Use the "forward" uniquify scheme for buffer disambiguation
(setq uniquify-buffer-name-style 'forward)

;; Automatically fill comments
(add-hook 'prog-mode (lambda ()
                       ((auto-fill-mode 1)
                        (setq comment-auto-fill-only-comments t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic spelling configurations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ispell-personal-dictionary (f-join (getenv "HOME") ".emacs.d" "personal_dictionary"))
(setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
;;(setq ispell-extra-args '("-t" "--lang=en_GB" "--add-tex-command='citep op'" "--add-tex-command='citet op'"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Common variables for org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst org-root-directory (f-join (getenv "HOME") "org"))
(defconst org-agenda-directory (f-join org-root-directory "agenda") "Filesystem location of agenda files.")
(defconst org-notes-directory (f-join org-root-directory "roam") "Filesystem location of org-roam knowledge base.")
(defconst zotero-bib-file (f-join org-root-directory "zotLib.bib") "Filesystem location of Zotero bibfile.")

;;###autoload
(defun gp/magit-fetch-and-prune-gone-remotes ()
  "Run the git alias 'gone' asynchronously within the magit interface."
  (interactive)
  (magit-run-git-async "gone"))


(defconst ledger-home-directory (f-join (getenv "HOME") "ledger") "Location of ledger files.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helper functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun xah-title-case-region-or-line (@begin @end)
  "Title case text between nearest brackets, or current line, or text selection.
  Capitalize first letter of each word, except words like {to, of, the, a, in, or, and, …}. If a word already contains cap letters such as HTTP, URL, they are left as is.

  When called in a elisp program, *begin *end are region boundaries.
  URL `http://ergoemacs.org/emacs/elisp_title_case_text.html'
  Version 2017-01-11"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let (
           $p1
           $p2
           ($skipChars "^\"<>(){}[]“”‘’‹›«»「」『』【】〖〗《》〈〉〔〕"))
       (progn
         (skip-chars-backward $skipChars (line-beginning-position))
         (setq $p1 (point))
         (skip-chars-forward $skipChars (line-end-position))
         (setq $p2 (point)))
       (list $p1 $p2))))
  (let* (
         ($strPairs [
                     [" A " " a "]
                     [" And " " and "]
                     [" At " " at "]
                     [" As " " as "]
                     [" By " " by "]
                     [" Be " " be "]
                     [" Into " " into "]
                     [" In " " in "]
                     [" Is " " is "]
                     [" It " " it "]
                     [" For " " for "]
                     [" Of " " of "]
                     [" Or " " or "]
                     [" On " " on "]
                     [" Via " " via "]
                     [" The " " the "]
                     [" That " " that "]
                     [" To " " to "]
                     [" Vs " " vs "]
                     [" With " " with "]
                     [" From " " from "]
                     ["'S " "'s "]
                     ["'T " "'t "]
                     ]))
    (save-excursion
      (save-restriction
        (narrow-to-region @begin @end)
        (upcase-initials-region (point-min) (point-max))
        (let ((case-fold-search nil))
          (mapc
           (lambda ($x)
             (goto-char (point-min))
             (while
                 (search-forward (aref $x 0) nil t)
               (replace-match (aref $x 1) "FIXEDCASE" "LITERAL")))
           $strPairs))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DWIM function overrides
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)
(global-set-key (kbd "M-c") 'capitalize-dwim)
