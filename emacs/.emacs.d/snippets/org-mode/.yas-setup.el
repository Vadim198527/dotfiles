(defun my-yas-get-snippet-text (snippet-name)
  "Возвращает текст сниппета по его имени."
  (let ((snippet (cl-find snippet-name
                          (yas--all-templates (yas--get-snippet-tables))
                          :key #'yas--template-name
                          :test #'string=)))
    (when snippet
      (yas--template-content snippet))))
