(defun ales/fill-paragraph (&optional P)
  "When called with prefix argument call `fill-paragraph'.
  Otherwise split the current paragraph into one sentence per line.
  Optional argument P Dunno?"
  (interactive "P")
  (if (not P)
      (save-excursion
        (let ((fill-column 12345678)) ;; relies on dynamic binding
          (fill-paragraph) ;; this will not work correctly if the paragraph is
          ;; longer than 12345678 characters (in which case the
          ;; file must be at least 12MB long. This is unlikely.)
          (let ((end (save-excursion
                       (forward-paragraph 1)
                       (backward-sentence)
                       (point-marker))))  ;; remember where to stop
            (beginning-of-line)
            (while (progn (forward-sentence)
                          (<= (point) (marker-position end)))
              (just-one-space) ;; leaves only one space, point is after it
              (delete-char -1) ;; delete the space
              (newline)        ;; and insert a newline
              (LaTeX-indent-line) ;; I only use this in combination with late, so this makes sense
              ))))
    ;; otherwise do ordinary fill paragraph
    (fill-paragraph P)))

(setq-default TeX-master nil)
(setq TeX-auto-save t
      TeX-parse-self t
      TeX-save-query nil
      TeX-PDF-mode t
      reftex-plug-into-AUCTeX t
      reftex-use-external-file-finders t
      LaTeX-csquotes-open-quote "\\enquote{"
      LaTeX-csquotes-close-quote "}"
      reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource") ;; Make reftex try play nicer with biblatex
      reftex-cite-format 'natbib)

(add-hook 'LaTeX-mode-hook 'LaTeX-preview-setup)
(add-hook 'LaTeX-mode-hook 'flymake-aspell-setup)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)

;; Highlight the current line which works really well for writing
(add-hook 'LaTeX-mode-hook 'hl-line-mode)

;; to use pdfview with auctex
;;(add-hook 'LaTeX-mode-hook 'pdf-tools-install)

;; to use pdfview with auctex
;; (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
;;       TeX-source-correlate-start-server t)
;; (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))

;; Fancy verbatim config for code blocks in thesis
(add-to-list 'LaTeX-verbatim-environments "code")
(add-to-list 'LaTeX-indent-environment-list '("code" current-indentation))


;; Spelling
(setq ispell-tex-skip-alists
      '((
         ;;("%\\[" . "%\\]") ; AMStex block comment...
         ;; All the standard LaTeX keywords from L. Lamport's guide:
         ;; \cite, \hspace, \hspace*, \hyphenation, \include, \includeonly
         ;; \input, \label, \nocite, \rule (in ispell - rest included here)
         ("[^\\]\\$" . "[^\\]\\$") ;; For inline math. e.g., $\mathbf{\hat{y}}$
         ("_\\\\{" . "\\\\}") ;; subscripts need to be excluded explicitly??
         ("\\\\addcontentsline"              ispell-tex-arg-end 2)
         ("\\\\add\\(tocontents\\|vspace\\)" ispell-tex-arg-end)
         ("\\\\\\([aA]lph\\|arabic\\)"       ispell-tex-arg-end)
         ("\\\\author"                       ispell-tex-arg-end)
         ;; New regexps here --- kjh
         ("\\\\\\(text\\|paren\\)cite"       ispell-tex-arg-end)
         ("\\\\\\(c\\|C\\)ite\\(t\\|p\\|year\\|yearpar\\|author\\)" ispell-tex-arg-end)
         ("\\\\bibliographystyle"            ispell-tex-arg-end)
         ("\\\\\\(g\\|G\\)\\(l\\|L\\)\\(s\\|S\\)\\(pl\\)?"         ispell-tex-arg-end)
         ("\\\\\\(c\\|v\\|C\\|V\\)ref"                 ispell-tex-arg-end)
         ("\\\\label"                        ispell-tex-arg-end)
         ("\\\\makebox"                      ispell-tex-arg-end 0)
         ("\\\\e?psfig"                      ispell-tex-arg-end)
         ("\\\\\\(g\\|G\\)\\(l\\|L\\)\\(s\\|S\\)\\(pl\\)"   ispell-tex-arg-end)
         ("\\\\document\\(class\\|style\\)" .
          "\\\\begin[ \t\n]*{[ \t\n]*document[ \t\n]*}"))
        (
         ;; delimited with \begin.  In ispell: displaymath, eqnarray,
         ;; eqnarray*, equation, minipage, picture, tabular,
         ;; tabular* (ispell)
         ("\\(figure\\|table\\)\\*?"         ispell-tex-arg-end 0)
         ;;("\\(equation\\|eqnarray\\)\\*?"     ispell-tex-arg-end 0)
         ("equation"                         ispell-tex-arg-end 0)
         ;;("algorithm"                        ispell-tex-arg-end 0)
         ("list"                             ispell-tex-arg-end 2)
         ("program" . "\\\\end[ \t\n]*{[ \t\n]*program[ \t\n]*}")
         ("tikzpicture" . "\\\\end[ \t\n]*{[ \t\n]*tikzpicture[ \t\n]*}")
         ("verbatim\\*?"."\\\\end[ \t\n]*{[ \t\n]*verbatim\\*?[ \t\n]*}")
         ("lstlisting\\*?"."\\\\end[ \t\n]*{[ \t\n]*lstlisting\\*?[ \t\n]*}"))))
