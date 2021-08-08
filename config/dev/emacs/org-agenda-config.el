(setq org-agenda-custom-commands
      '(("n" "Next Actions without Schedule or Deadline"
	 ((org-ql-block '(and (todo "NEXT")
			      (not (scheduled))
			      (not (deadline)))
			((org-ql-block-header "Next Actions without SCHEDULE OR DEADLINE")))
	  (org-ql-block '(todo "DONE")
			((org-ql-block-header "Tasks marked as DONE")))))))
