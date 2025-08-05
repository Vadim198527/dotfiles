;; -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Глобальный флаг текущей раскладки и единая точка правды
(defvar my/input-ru-p nil
  "Нон-nil, если активна русская раскладка (input-method), nil — английская.")

(defun my/apply-input-method-according-to-flag ()
  "Применяет метод ввода в соответствии с `my/input-ru-p`.
Использовать ЭТУ функцию только в insert state.
В normal state метод ввода всегда выключаем (см. hook выше)."
  (if my/input-ru-p
      (set-input-method "russian-computer")
    (deactivate-input-method)))

(defun my/toggle-input-method-flag ()
  "Переключает глобальный флаг раскладки.
- В normal: меняем только флаг и индикатор (input всегда EN).
- В insert: меняем флаг и сразу применяем метод по флагу."
  (interactive)
  (setq my/input-ru-p (not my/input-ru-p))
  (if my/input-ru-p
      (message "RU")
    (message "EN"))
  (if (evil-insert-state-p)
      (my/apply-input-method-according-to-flag)
    ;; В normal: EN, индикатор — это «что будет в insert», поэтому input не трогаем иначе
    (deactivate-input-method))
  ;; Важно: перерисовать mode-line немедленно, чтобы в normal сразу увидеть будущую раскладку.
  (force-mode-line-update t)
  (redraw-display))

;; Старая функция оставлена как обёртка для обратной совместимости
(defun toggle-russian-input-method ()
  "Переключить метод ввода между английским и русским через общий флаг."
  (interactive)
  (my/toggle-input-method-flag))

;; Следим за переходами состояний Evil и синхронизируем индикатор.
;; Требование: в normal state ВСЕГДА английская раскладка (input-method выключен),
;; индикатор U/RUU — это «какая будет раскладка при входе в insert».
(with-eval-after-load 'evil
  (add-hook 'evil-normal-state-entry-hook
            (lambda ()
              ;; В normal: всегда EN, индикатор отображает ПРЕДНАМЕРЕННУЮ раскладку в insert
              (deactivate-input-method)
              (force-mode-line-update t)))
  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              ;; Перед входом в insert: НИКОГДА не меняем флаг здесь, только применяем по флагу
              (my/apply-input-method-according-to-flag)
              (force-mode-line-update t)))
  ;; Важно: при выходе из insert ничего не трогаем (флаг остаётся как «выбор пользователя»)
  (add-hook 'evil-insert-state-exit-hook
            (lambda ()
              ;; Гарантируем EN после выхода из insert, но индикатор не меняем (это «предпросмотр insert»)
              (deactivate-input-method)
              (force-mode-line-update t))))


(evil-define-operator my-evil-yank (beg end type register yank-handler)
  "Yank text from BEG to END in Evil, then go to the end of that region."
  :move-point nil
  (interactive "<R><x><y>")
  (evil-yank beg end type register yank-handler)
  (evil-goto-mark ?>)
  (evil-exit-visual-state))

;; Теперь в Visual-mode на "y" вешаем наш оператор:
(define-key evil-visual-state-map (kbd "y") #'my-evil-yank)

(defun my-evil-format-whole-buffer ()
  "Форматирует (выравнивает) весь буфер без изменения позиции курсора."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

;; Привяжем функцию к сочетанию <leader> b f.
;; Для примера, если leader = SPC, это будет SPC b f.
(evil-define-key 'normal 'global (kbd "<leader> b f")
  #'my-evil-format-whole-buffer)


(defun my-recenter-above-center-4 ()
  "Перемещает курсор так, чтобы он располагался на 4 строки выше центра окна."
  (interactive)
  ;; вычисляем «центр» текущего окна:
  (let ((center (floor (/ (window-body-height) 2))))
    ;; вычитаем 4 строки от центра:
    (recenter (max 0 (- center 4)))))

(with-eval-after-load 'evil
  ;; В normal-state назначаем сочетание C-;:
  (define-key evil-normal-state-map (kbd "C-;") #'my-recenter-above-center-4)
  (define-key evil-insert-state-map (kbd "C-;") #'my-recenter-above-center-4)
  )

(defun my-evil-select-whole-buffer ()
  "Выделяет весь буфер в visual state и запоминает исходную позицию в jumplist Evil."
  (interactive)
  (evil-set-jump)  ; Добавляем текущую позицию в jumplist
  (evil-visual-select (point-min) (point-max) 'char))

;; Привязываем к <leader>sa
(evil-define-key 'normal 'global (kbd "<leader>sa") #'my-evil-select-whole-buffer)

;;(evil-define-key 'normal LaTeX-mode-map (kbd "<leader> p s t") 'prettify-symbols-mode)
(evil-define-key 'normal 'global (kbd "<leader>km") 'describe-bindings) 
(evil-define-key 'normal 'global (kbd "C-e") 'move-end-of-line) 
(evil-define-key 'insert 'global (kbd "C-e") 'move-end-of-line) 
(evil-define-key 'normal 'global (kbd "C-a") 'move-beginning-of-line) 
(evil-define-key 'insert 'global (kbd "C-a") 'move-beginning-of-line) 
(evil-define-key 'normal 'global (kbd "<leader>h") 'evil-ex-nohighlight)  
(evil-define-key 'normal 'global (kbd "<leader>chk") 'describe-key)  
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
;; (evil-define-key '(normal insert) org-mode-map (kbd "TAB") 'org-cycle)
(evil-define-key 'normal 'global (kbd "C-'") 'comment-line)
(evil-define-key 'visual 'global (kbd "C-'") 'comment-dwim)
(evil-define-key 'normal 'global (kbd "<leader><") 'switch-to-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>,") 'switch-to-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>`") 'evil-switch-to-windows-last-buffer) 
(evil-define-key 'normal 'global (kbd "<leader><escape>") 'evil-switch-to-windows-last-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>.") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>:") 'execute-extended-command) 
(evil-define-key 'normal 'lisp-interaction-mode-map (kbd "<leader>rc") 'eval-buffer) 
(evil-define-key 'normal 'global (kbd ",ee") 'eval-last-sexp) 
;; Привязка функции к C-SPC и в insert, и в normal, чтобы менять единый флаг.
;; Используем оба варианта написания клавиши пробела, так как разные билды Emacs
;; и разные раскладки клавиатуры могут по-разному репортить модификатор:
(evil-define-key 'insert global-map (kbd "C-SPC") 'my/toggle-input-method-flag)
(evil-define-key 'normal global-map (kbd "C-SPC") 'my/toggle-input-method-flag)
(evil-define-key 'insert global-map (kbd "C-@")   'my/toggle-input-method-flag)
(evil-define-key 'normal global-map (kbd "C-@")   'my/toggle-input-method-flag)

(with-eval-after-load 'evil
  ;; C-f как backspace в командном режиме Evil
  (define-key evil-ex-completion-map (kbd "C-h") 'backward-delete-char)
  (define-key evil-ex-search-keymap (kbd "C-h") 'backward-delete-char))

(evil-define-key 'insert global-map (kbd "C-l") (lambda ()
                                                  (interactive)
                                                  (insert "\t")))

(defun paredit-forward-drag-sexp (&optional n)
  "Переместить текущий s-expression вперёд (вправо) на N позиций.
Если N отрицательно — двигаем влево.  Без префикса N = 1.

▪ Точка остаётся в начале перемещённого s-expression.  
▪ Если переставлять уже некуда, буфер и точка не изменяются."
  (interactive "p")
  (setq n (or n 1))
  (let ((direction (cl-signum n)))
    (dotimes (_ (abs n))
      (let ((orig (point)))             ;запоминаем исходную позицию
        (paredit-lose-if-not-in-sexp 'paredit-forward-drag-sexp)
        (condition-case nil
            (progn
              ;; курсор между текущим и соседним s-exp
              (goto-char (paredit-point-at-sexp-start))
              (forward-sexp direction)
              ;; убедимся, что сосед существует
              (save-excursion (forward-sexp direction))
              ;; перестановка
              (transpose-sexps direction)
              ;; вернуть точку к началу перемещённого выражения
              (backward-sexp 1)
              (save-excursion
                (backward-up-list) (indent-sexp)))
          (error                       ;двигать некуда → откат
           (goto-char orig)            ;полный возврат курсора
           (cl-return)))))))           ;и прекращаем дальнейшие попытки

(defun paredit-backward-drag-sexp (&optional n)
  "Переместить текущий s-expression влево на N позиций внутри списка.

▪ N < 0 ― передаём -N в `paredit-forward-drag-sexp`.  
▪ Точка всегда оказывается в начале перемещённого sexp.  
▪ При отсутствии соседей слева буфер и курсор не изменяются."
  (interactive "p")
  (setq n (or n 1))
  (cond
   ((< n 0)                               ; перенаправляем на «вперёд»
    (paredit-forward-drag-sexp (- n)))
   ((= n 0) nil)                          ; ничего не делать
   (t
    (dotimes (_ n)
      (let ((orig (point)))               ; запомним позицию
        (paredit-lose-if-not-in-sexp 'paredit-backward-drag-sexp)
        (condition-case nil
            (progn
              ;; курсор между левым и текущим sexp
              (goto-char (paredit-point-at-sexp-start))
              (save-excursion (backward-sexp 1)) ; убеждаемся в наличии левого
              (transpose-sexps 1)         ; обмен
              (backward-sexp 2)           ; ←← к началу перемещённого
              (save-excursion            ; чинить отступы родителя
                (backward-up-list) (indent-sexp)))
          (error                         ; двигать некуда
           (goto-char orig)              ; откат позиции
           (cl-return))))))))

(defun paredit-forward-move-form ()
  "Move current s-expression (list) forward one position."
  (interactive)
  (let ((current-bounds (paredit-get-current-sexp-bounds)))
    (when current-bounds
      (let ((next-bounds (paredit-get-next-sexp-bounds current-bounds))
            (cursor-offset (- (point) (car current-bounds))))
        (when next-bounds
          (paredit-swap-sexps current-bounds next-bounds)
          ;; Find where our moved sexp ended up
          (goto-char (car current-bounds))  ; Go to start of swapped region
          (forward-sexp)                    ; Skip first sexp (former next-bounds)
          (skip-chars-forward " \t\n")     ; Skip whitespace
          ;; Now we're at the start of our moved sexp
          (goto-char (+ (point) cursor-offset)))))))

(defun paredit-get-current-sexp-bounds ()
  "Get bounds of current s-expression, only if it's a list."
  (save-excursion
    (cond
     ;; Case 1: cursor at the beginning of a list
     ((eq (char-after) ?\()
      (let ((start (point)))
        (forward-sexp)
        (cons start (point))))
     
     ;; Case 2: cursor inside a list  
     ((and (paredit-inside-list-p)
           (save-excursion (backward-up-list) (eq (char-after) ?\()))
      (backward-up-list)
      (let ((start (point)))
        (forward-sexp)
        (cons start (point))))
     
     ;; Case 3: Don't handle atoms or other cases
     (t nil))))

(defun paredit-inside-list-p ()
  "Check if cursor is inside a list."
  (save-excursion
    (condition-case nil
        (progn (backward-up-list) t)
      (error nil))))

(defun paredit-get-next-sexp-bounds (current-bounds)
  "Get bounds of next s-expression at the same level."
  (save-excursion
    (goto-char (cdr current-bounds))  ; Go to end of current sexp
    (skip-chars-forward " \t\n")      ; Skip whitespace
    (when (not (eobp))
      ;; Make sure we don't go outside the parent container
      (let ((parent-end (save-excursion
                          (condition-case nil
                              (progn (up-list) (point))
                            (error (point-max))))))
        (when (< (point) parent-end)
          (condition-case nil
              (let ((start (point)))
                (forward-sexp)
                (when (<= (point) parent-end)  ; Stay within parent
                  (cons start (point))))
            (error nil)))))))

(defun paredit-swap-sexps (bounds1 bounds2)
  "Swap two s-expressions given their bounds."
  (let ((text1 (buffer-substring (car bounds1) (cdr bounds1)))
        (text2 (buffer-substring (car bounds2) (cdr bounds2))))
    ;; Replace second sexp first (to avoid position shifts)
    (goto-char (car bounds2))
    (delete-region (car bounds2) (cdr bounds2))
    (insert text1)
    ;; Replace first sexp
    (goto-char (car bounds1))
    (delete-region (car bounds1) (cdr bounds1))
    (insert text2)))

(defun paredit-backward-move-form ()
  "Move current s-expression (list) backward one position."
  (interactive)
  (let ((current-bounds (paredit-get-current-sexp-bounds)))
    (when current-bounds
      (let ((prev-bounds (paredit-get-prev-sexp-bounds current-bounds))
            (cursor-offset (- (point) (car current-bounds))))
        (when prev-bounds
          (paredit-swap-sexps prev-bounds current-bounds)
          ;; Find where our moved sexp ended up (at the position of prev-bounds)
          (goto-char (+ (car prev-bounds) cursor-offset)))))))

(defun paredit-get-prev-sexp-bounds (current-bounds)
  "Get bounds of previous s-expression at the same level."
  (save-excursion
    (goto-char (car current-bounds))  ; Go to start of current sexp
    (skip-chars-backward " \t\n")     ; Skip whitespace
    (when (not (bobp))
      ;; Make sure we don't go outside the parent container
      (let ((parent-start (save-excursion
                            (condition-case nil
                                (progn (backward-up-list) (1+ (point)))
                              (error (point-min))))))
        (when (> (point) parent-start)
          (condition-case nil
              (let ((end (point)))
                (backward-sexp)
                (when (>= (point) parent-start)  ; Stay within parent
                  (cons (point) end)))
            (error nil)))))))

(defun paredit-wrap-around-sexp ()
  "Wrap the current list in parentheses.
If a region is active, wrap the region.
If cursor is on an opening parenthesis, wrap that expression.
Otherwise, wrap the current list that contains the cursor.
Place the cursor after the opening parenthesis of the new list."
  (interactive)
  (cond 
   ((paredit-region-active-p)
    ;; If region is active, wrap the region
    (let ((start (region-beginning))
          (end (region-end)))
      (goto-char end)
      (insert ")")
      (goto-char start)
      (insert "( ")
      (forward-char 1)
      (evil-insert-state)))
   ((or (paredit-in-string-p) (paredit-in-comment-p))
    (error "Cannot wrap around sexp in string or comment"))
   ((eq (char-syntax (char-after)) ?\()
    ;; Cursor is on an opening parenthesis - wrap this expression
    (let ((start (point)))
      (forward-sexp)
      (let ((end (point)))
        (goto-char end)
        (insert ")")
        (goto-char start)
        (insert "( ")
	    (backward-char 1)
	    (evil-insert-state)
        (save-excursion
          (backward-char 1)
          (indent-sexp)))))
   (t
    ;; Cursor is inside a list - wrap the containing list
    (paredit-handle-sexp-errors
        (progn
          (backward-up-list)
          (let ((start (point)))
            (forward-sexp)
            (let ((end (point)))
              (goto-char end)
              (insert ")")
              (goto-char start)
              (insert "( ")
	          (backward-char 1)
	          (evil-insert-state)
              (save-excursion
                (backward-char 1)
                (indent-sexp)))))
      (error "Not inside a list")))))

(defun paredit-wrap-around-sexp-end ()
  "Wrap the current list in parentheses.
If a region is active, wrap the region.
If cursor is on an opening parenthesis, wrap that expression.
Otherwise, wrap the current list that contains the cursor.
Place the cursor after the closing parenthesis of the new list."
  (interactive)
  (cond 
   ((paredit-region-active-p)
    ;; If region is active, wrap the region
    (let ((start (region-beginning))
          (end (region-end)))
      (goto-char end)
      (insert ")")
      (goto-char start)
      (insert "(")
      (goto-char (+ end 1))
      (evil-insert-state)))  ; Move to after closing paren (+2 for both parens)
   ((or (paredit-in-string-p) (paredit-in-comment-p))
    (error "Cannot wrap around sexp in string or comment"))
   ((eq (char-syntax (char-after)) ?\()
    ;; Cursor is on an opening parenthesis - wrap this expression
    (let ((start (point)))
      (forward-sexp)
      (let ((end (point)))
        (insert ")")
        (goto-char start)
        (insert "(")
        (goto-char (+ end 1))  ; Move to after closing paren
	    (evil-insert-state)
        (save-excursion
          (backward-sexp)
          (indent-sexp)))))
   (t
    ;; Cursor is inside a list - wrap the containing list
    (paredit-handle-sexp-errors
        (progn
          (backward-up-list)
          (let ((start (point)))
            (forward-sexp)
            (let ((end (point)))
              (insert ")")
              (goto-char start)
              (insert "(")
              (goto-char (+ end 1))  ; Move to after closing paren
	          (evil-insert-state)
              (save-excursion
                (backward-sexp)
                (indent-sexp)))))
      (error "Not inside a list")))))

(defun paredit-wrap-around-symbol ()
  "Wrap the current symbol in parentheses.
Place the cursor after the opening parenthesis with a space and enter insert mode.
Example: ab|d -> (| abd)"
  (interactive)
  (cond 
   ((paredit-region-active-p)
    ;; If region is active, wrap the region
    (let ((start (region-beginning))
          (end (region-end)))
      (goto-char end)
      (insert ")")
      (goto-char start)
      (insert "( ")
      ;; (forward-char 1)
      (backward-char 1)
      (evil-insert-state)))
   ((or (paredit-in-string-p) (paredit-in-comment-p))
    (error "Cannot wrap around symbol in string or comment"))
   (t
    ;; Find symbol boundaries
    (let ((bounds (paredit-get-symbol-bounds)))
      (if bounds
          (let ((start (car bounds))
                (end (cdr bounds)))
            (goto-char end)
            (insert ")")
            (goto-char start)
            (insert "( ")
	        ;; (forward-char 1)
	        (backward-char 1)
            (evil-insert-state))
        (error "No symbol at point"))))))

(defun paredit-wrap-around-symbol-end ()
  "Wrap the current symbol in parentheses.
Place the cursor before the closing parenthesis and enter insert mode.
Example: ab|d -> (abd|)"
  (interactive)
  (cond 
   ((paredit-region-active-p)
    ;; If region is active, wrap the region
    (let ((start (region-beginning))
          (end (region-end)))
      (goto-char end)
      (insert ")")
      (goto-char start)
      (insert "(")
      (goto-char (+ end 1))  ; Move to before closing paren
      (evil-insert-state)))
   ((or (paredit-in-string-p) (paredit-in-comment-p))
    (error "Cannot wrap around symbol in string or comment"))
   (t
    ;; Find symbol boundaries
    (let ((bounds (paredit-get-symbol-bounds)))
      (if bounds
          (let ((start (car bounds))
                (end (cdr bounds)))
            (goto-char end)
            (insert ")")
            (goto-char start)
            (insert "(")
            (goto-char (+ end 1))  ; Move cursor before closing ")"
            (evil-insert-state))
        (error "No symbol at point"))))))

(defun paredit-get-symbol-bounds ()
  "Get bounds of the current symbol under cursor."
  (save-excursion
    (let ((original-point (point)))
      ;; Try to get bounds using thing-at-point first
      (let ((bounds (bounds-of-thing-at-point 'symbol)))
        (if bounds
            bounds
          ;; If that fails, try to manually find symbol boundaries
          (when (paredit-symbol-char-p (char-after))
            ;; Move to beginning of symbol
            (while (and (not (bobp))
                        (paredit-symbol-char-p (char-before)))
              (backward-char))
            (let ((start (point)))
              ;; Move to end of symbol
              (while (and (not (eobp))
                          (paredit-symbol-char-p (char-after)))
                (forward-char))
              (when (> (point) start)
                (cons start (point))))))))))

(defun paredit-symbol-char-p (char)
  "Check if CHAR is a valid symbol character."
  (and char
       (not (memq char '(?\s ?\t ?\n ?\r ?\( ?\) ?\[ ?\] ?\{ ?\} ?\" ?\' ?\` ?\, ?\; ?\#)))
       (not (eq (char-syntax char) ?\ ))   ; not whitespace
       (not (eq (char-syntax char) ?\())   ; not open paren
       (not (eq (char-syntax char) ?\)))))  ; not close paren

(evil-define-key 'normal 'paredit-mode-map (kbd ">e") 'paredit-forward-drag-sexp)
(evil-define-key 'normal 'paredit-mode-map (kbd "<e") 'paredit-backward-drag-sexp)
(evil-define-key 'normal 'paredit-mode-map (kbd ">f") 'paredit-forward-move-form)
(evil-define-key 'normal 'paredit-mode-map (kbd "<f") 'paredit-backward-move-form)
(evil-define-key 'normal 'paredit-mode-map (kbd "<leader>(") 'paredit-wrap-around-sexp)
(evil-define-key 'normal 'paredit-mode-map (kbd "<leader>)") 'paredit-wrap-around-sexp-end)
(evil-define-key 'normal 'paredit-mode-map (kbd "<leader>]") 'paredit-wrap-square)
(evil-define-key 'normal 'paredit-mode-map (kbd "<leader>e(") 'paredit-wrap-around-symbol)
(evil-define-key 'normal 'paredit-mode-map (kbd "<leader>e)") 'paredit-wrap-around-symbol-end)


;; вертикальное разделение экрана
(evil-define-key 'normal 'global (kbd "<leader>w/") 'split-window-right)
(evil-define-key 'normal racket-mode-map (kbd "<leader>rc") 'racket-run)
(evil-define-key 'normal racket-mode-map (kbd "<leader>rn") 'racket-xp-rename)
(evil-define-key 'normal 'global (kbd "<leader>wv") 'split-window-right)
(evil-define-key 'normal 'global (kbd "<leader><escape>") 'nil)

;; горизонтальное разделение экрана
(evil-define-key 'normal 'global (kbd "<leader>w-") 'split-window-below)
(evil-define-key 'normal 'global (kbd "<leader>ws") 'split-window-below)
(evil-define-key 'normal 'global (kbd "<leader>ws") 'split-window-below)

;; закрытие текущего окна
;; (evil-define-key 'normal 'global (kbd "<leader>wd") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>x") 'delete-window)
;; закрытие всех окон, кроме текущего
(evil-define-key 'normal 'global (kbd "<leader>w1") 'delete-other-windows) 

(defun my-evil-copy-whole-buffer ()
  "Копирует весь буфер в kill-ring, не двигая курсор."
  (interactive)
  (save-excursion
    (kill-ring-save (point-min) (point-max))))
;; Предположим, что <leader> = пробел (SPC).
;; Если у вас другой <leader>, подставьте нужное сочетание.
(evil-define-key 'normal 'global (kbd "<leader> c p")
  #'my-evil-copy-whole-buffer)
;; переход к другому окну
(evil-define-key 'normal 'global (kbd "<leader>ww") 'other-window)
;; Перемещение между окнами
(evil-define-key 'normal 'global (kbd "C-h") 'evil-window-left)  
(evil-define-key 'normal 'global (kbd "C-l") 'evil-window-right)  
(evil-define-key 'normal 'global (kbd "C-j") 'evil-window-down)  
(evil-define-key 'normal 'global (kbd "C-k") 'evil-window-up)  

(evil-define-key 'normal 'global (kbd "<leader>mx") 'execute-extended-command)  

;; Открлючаем и включаем обратно подсветку Lsp
(evil-define-key 'normal 'global (kbd "<leader>dd") (lambda ()
						                              (interactive)
						                              (flymake-mode -1)))  
(evil-define-key 'normal 'global (kbd "<leader>de") (lambda ()
						                              (interactive)
						                              (flymake-mode 1)))  

(defun my/run-current-python-file ()
  "Compile the current buffer's Python file using 'python file.py'."
  (interactive)
  (if buffer-file-name
      ;; Проверяем (необязательно), что это .py файл
      (if (string= (file-name-extension buffer-file-name) "py")
          (compile (concat "python3 " (shell-quote-argument buffer-file-name)))
	    (message "Current buffer is not a Python (.py) file"))
    (message "Current buffer is not visiting a file")))

;; Назначаем <leader>rc в normal state для запуска функции
;; (evil-define-key 'normal 'python-mode-map (kbd "<leader>rc") 'my/run-current-python-file)


(evil-define-key 'insert 'global (kbd "C-k") (kbd "RET"))
(evil-define-key 'insert global-map (kbd "C-h") (kbd "DEL"))

;; закрытие всех окон, кроме текущего
(evil-define-key 'normal 'global (kbd "<leader>w1") 'delete-other-windows) 

;; переход к другому окну
(evil-define-key 'normal 'global (kbd "<leader>ww") 'other-window)  


;; toggle trancate lines
;; (evil-define-key 'normal 'global (kbd "<leader>tl") 'toggle-truncate-lines) 

(evil-define-key 'insert 'global (kbd "C-w") 'backward-kill-word)

;; Вставка из регистра в insert-state
(define-key evil-insert-state-map (kbd "C-r") #'evil-paste-from-register)
;; При желании то же в minibuffer (поле ввода `:`/`/` и т. д.)
(define-key minibuffer-local-map (kbd "C-r") #'evil-paste-from-register)

(defun my/save-buffer ()
  "Сохраняет текущий файл, если он изменён."
  (interactive)
  (when (and buffer-file-name (buffer-modified-p))
    (save-buffer)))

(dolist (state '(normal insert visual emacs))       ; где хотим?
  (define-key (symbol-value (intern (format "evil-%s-state-map" state)))
	          (kbd "C-s") #'my/save-buffer))

;; Оператор для копирования в системный буфер (например, <leader>yiw)
(evil-define-operator my/clipboard-yank (beg end type \_ \_)
  "Yank to system clipboard."
  (interactive "<R><x>") ; <R> - region, <x> - опциональный регистр (здесь игнорируется)
  (evil-yank beg end type ?+)) ; ?+ это регистр системного буфера

;; Назначаем <leader>y на наш оператор копирования в системный буфер
(define-key evil-normal-state-map (kbd "<leader>y") #'my/clipboard-yank)

;; Назначаем <leader>p на вставку из системного буфера
(define-key evil-normal-state-map (kbd "<leader>p")
	        (lambda () 
	          (interactive) 
	          (evil-paste-after 1 ?+))) ; 1 - count, ?+ - регистр системного буфера


;; (evil-define-key 'insert 'global (kbd "C-h") 'backward-delete-char-untabify)
(define-key evil-normal-state-map (kbd "C-p")
            (lambda ()
	          (interactive)
	          (save-excursion
                (end-of-line)
                (newline))))

;; Функция для копирования в системный буфер
(evil-define-operator my/clipboard-yank (beg end type _ _)
  "Копирует текст из редактора в системный буфер обмена."
  :move-point nil
  :repeat nil
  (interactive "<R><x>")
  (evil-yank beg end type ?+))

;; Глобальная переменная для хранения ссылки на оверлей подсветки
(defvar my/yank-overlay nil
  "Оверлей, используемый для подсветки при копировании.")

;; Улучшенная функция подсветки с гарантированным удалением
(defun my/highlight-region-temporarily (beg end)
  "Временно подсвечивает область от BEG до END."
  ;; Удаляем предыдущий оверлей, если он существует
  (when (overlayp my/yank-overlay)
    (delete-overlay my/yank-overlay))
  
  ;; Создаем новый оверлей
  (setq my/yank-overlay (make-overlay beg end))
  (overlay-put my/yank-overlay 'face '(:background "#00afff" :foreground "black"))
  
  ;; Гарантированно удаляем оверлей через таймер
  (run-with-timer 0.050 nil
                  (lambda ()
                    (when (overlayp my/yank-overlay)
		              (delete-overlay my/yank-overlay)
		              (setq my/yank-overlay nil)))))
(evil-define-operator my/clipboard-yank (beg end type _ _)
  "Копирует текст из редактора в системный буфер обмена с подсветкой."
  :move-point nil ;; Курсор останется на исходной позиции
  :repeat nil
  (interactive "<R><x>")
  ;; Сохраняем текущую позицию курсора
  (let ((point-before (point)))
    ;; Копируем в системный буфер
    (evil-yank beg end type ?+)
    ;; Подсвечиваем область
    (my/highlight-region-temporarily beg end)
    ;; Возвращаем курсор на исходную позицию
    (goto-char point-before)))


;; Назначаем <leader>y на копирование в системный буфер обмена
(evil-define-key 'normal 'global (kbd "<leader>y") 'my/clipboard-yank)
(evil-define-key 'visual 'global (kbd "<leader>y") 'my/clipboard-yank)
(evil-define-key 'visual 'global (kbd "s-c") 'my/clipboard-yank)

;; Назначаем <leader>p на вставку из системного буфера обмена
(evil-define-key 'normal 'global (kbd "<leader>p") 
  (lambda () 
    (interactive) 
    (evil-paste-after 1 ?+)))

(defun my/copy-whole-buffer-to-clipboard ()
  "Copy entire buffer to clipboard with visual feedback."
  (interactive)
  ;; Сохраняем текущее значение select-enable-clipboard и позицию курсора
  (let ((old-clipboard-setting select-enable-clipboard)
        (old-point (point)))
    ;; Сохраняем позицию окна
    (save-excursion
      ;; Временно включаем взаимодействие с буфером обмена
      (setq select-enable-clipboard t)
      ;; Выбираем весь буфер и копируем
      (clipboard-kill-ring-save (point-min) (point-max))
      ;; Даем визуальную обратную связь
      (pulse-momentary-highlight-region (point-min) (point-max) 'highlight)
      ;; Восстанавливаем старое значение select-enable-clipboard
      (setq select-enable-clipboard old-clipboard-setting)
      ;; Сообщение о том, что буфер скопирован
      (message "Buffer copied to clipboard!"))
    ;; Возвращаем курсор на исходную позицию
    (goto-char old-point)))

;; Привязка к <leader>cp в normal режиме
(with-eval-after-load 'evil
  (evil-define-key 'normal 'global (kbd "<leader>cp") 'my/copy-whole-buffer-to-clipboard))


;; Start Ace-jump-mode
;; избегаем конфликта с нашим единым переключателем C-SPC
;; (оставим ace-jump на другой жест, например C-c j)
(global-set-key (kbd "C-c j") 'ace-jump-word-mode)
(global-set-key (kbd "C-c C-c SPC") 'ace-jump-char-mode)
(global-set-key (kbd "C-c C-c C-c SPC") 'ace-jump-line-mode)
;; End Ace-jump-mode 

;; Start Avy
(global-set-key (kbd "C-;") 'avy-goto-char)
;; End Avy


;; Start keybindings
(global-set-key (kbd "<backsace>") 'delete-char)
(global-set-key "\C-x\C-k" 'kill-region) 
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "C-т") 'next-line)
(global-set-key (kbd "C-з") 'previous-line)
(global-set-key (kbd "C-а") 'forward-char)
(global-set-key (kbd "C-и") 'backward-char)
(global-set-key (kbd "C-.") 'undo)
(global-set-key (kbd "C-ч C-у") 'eval-last-sexp)
(global-set-key (kbd "C-ф") 'move-beginning-of-line) 
(global-set-key (kbd "C-у") 'move-end-of-line)
(global-set-key (kbd "C-ч 1") 'delete-other-windows)
(global-set-key (kbd "M-а") 'forward-word)
(global-set-key (kbd "M-и") 'backward-word)
(global-set-key (kbd "C-щ") 'open-line)
(global-set-key (kbd "C-л") 'kill-line)
(global-set-key (kbd "C-п") 'keyboard-quit)
(global-set-key (kbd "C-м") 'scroll-up-command)

                                        ;scroll one window up
(global-set-key (kbd "M-м") 'scroll-down-command)

(global-set-key "\C-x\C-p" 'other-window-backward)
(global-set-key (kbd "C-ч C-з") 'other-window-backward)
;; (global-set-key "\C-x\C-n" 'other-window-forward)
(global-set-key (kbd "C-ч C-т") 'other-window-forward)
(global-set-key (kbd "C-ч щ") 'other-window)


(global-set-key (kbd "C-н") 'yank)
(global-set-key (kbd "M-ц") 'kill-ring-save)
(global-set-key "\C-z" 'scroll-n-lines-ahead)
(global-set-key "\C-q" 'scroll-n-lines-behind)
(global-set-key (kbd "C-я") 'scroll-n-lines-ahead)
(global-set-key (kbd "C-й") 'scroll-n-lines-behind)
(global-set-key (kbd "C-ч C-=") 'text-scale-adjust)
(global-set-key (kbd "C-ч C--") 'text-scale-adjust)

(global-set-key (kbd "C-ч C-ы") 'save-buffer)
(global-set-key (kbd "C-ч C-а") 'find-file)
(global-set-key (kbd "C-в") 'delete-char)

;; (global-set-key "\M-," 'point-to-top)	

(global-set-key (kbd "C-с C-е") 'org-todo)
(global-set-key (kbd "C-с C-ч C-д") 'org-latex-preview)
(global-set-key (kbd "C-с C-д") 'org-insert-link)
(global-set-key (kbd "M-ч") 'execute-extended-comand)
(global-set-key "\C-x\C-q" 'quoted-insert)

;; Переназначаем set-mark-command на С-\
(global-set-key (kbd "C-\\") 'set-mark-command)


;;конец переназначения

;; Org keys
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c M-&") #'org-mark-ring-goto)
(global-set-key (kbd "C-c M-&") #'org-mark-ring-goto)
(global-set-key (kbd "C-c TAB") #'org-fold-show-children)
;; End of Org keys

(global-set-key (kbd "C-=") 'er/expand-region)

;; Отключаем старую функцию в Org-mode
(define-key org-mode-map (kbd "C-c C-x C-l") nil)

;; Назначаем новую функцию для этого сочетания клавиш в Org-mode
(define-key org-mode-map (kbd "C-c C-x C-l") 'math-preview-at-point)

;; Если вы хотите переназначить org-latex-preview на другое сочетание клавиш в Org-mode
(define-key org-mode-map (kbd "C-c C-x C-k") 'org-latex-preview)

;; (define-key org-mode-map (kbd "TAB") nil)

(defvar my/accent-map
'((?a . ?á) (?A . ?Á)
(?e . ?é) (?E . ?É)
(?i . ?í) (?I . ?Í)
(?o . ?ó) (?O . ?Ó)
(?u . ?ú) (?U . ?Ú)
(?n . ?ñ) (?N . ?Ñ))
"Mapping of base characters to their accented versions for Spanish.")
(defun my/insert-accent ()
"Replace the character before point with its accented version if applicable.
Does nothing if the character is not a vowel or 'n'."
(interactive)
(when (> (point) (point-min))
(let* ((char (char-before))
(new-char (cdr (assoc char my/accent-map))))
(when new-char
(delete-char -1)
(insert new-char)))))
(evil-define-key 'insert 'global (kbd "C-'") 'my/insert-accent)
