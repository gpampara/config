;;;###autoload
(defun gp/magit-fetch-and-prune-gone-remotes ()
  "Run the git alias 'gone' asynchronously within the magit interface."
  (interactive)
  (magit-run-git-async "gone" "-f"))

(defun gp/writing-mode ()
  "Helper function to allow for better writing configutations using Olivetti mode."
  (interactive)
  (olivetti-mode)
  (olivetti-set-width 110)
  (turn-on-visual-line-mode)
  (unless flyspell-mode
    (flyspell-mode)))

;; Ledger functions
(defun gp/open-current-postings-file ()
  "Open the current postings file."
  (interactive)
  (let* ((current-year (format-time-string "%Y" (current-time)))
         (ledger-file-name (f-join ledger-home-directory current-year "postings.ledger")))
    (find-file ledger-file-name)))
