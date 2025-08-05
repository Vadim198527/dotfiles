;;; Compiled snippets and support files for `org-mode'
;;; contents of the .yas-setup.el support file:
;;;
(defun my-yas-get-snippet-text (snippet-name)
  "Возвращает текст сниппета по его имени."
  (let ((snippet (cl-find snippet-name
                          (yas--all-templates (yas--get-snippet-tables))
                          :key #'yas--template-name
                          :test #'string=)))
    (when snippet
      (yas--template-content snippet))))
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
		     '(("theor" "** Theorem-$1 :theorem:\n*** Formulation: $2\n*** Proof: $3" "theoremFrame" nil nil nil "/Users/chestnykh/.emacs.d/snippets/org-mode/theoremFrame" nil nil)
		       ("lemma" "*** Lemma-$1\n**** Formulation: $2\n**** Proof: $3\n" "lemmaFrame" nil nil nil "/Users/chestnykh/.emacs.d/snippets/org-mode/lemmaFrame" nil nil)
		       ("def" "** Definition-$1 :def:\n*** Term: $2\n*** Notation: $3\n*** Def: $4" "DefFrame" nil nil nil "/Users/chestnykh/.emacs.d/snippets/org-mode/def" nil nil)
		       ("rdet" "R = \\bigcup_{X \\in \\mathcal{F}} (X \\times X)" "EquivalenceRelationDeterminedByR" nil nil nil "/Users/chestnykh/.emacs.d/snippets/org-mode/EquivRelDetR" nil nil)
		       ("(" "( $1 )\n\n " "Comas" nil nil nil "/Users/chestnykh/.emacs.d/snippets/org-mode/+new-snippet+" nil nil)))


;;; Do not edit! File generated at Fri Aug 23 02:48:55 2024
