(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Функция для переключения между английским и русским
(defun toggle-russian-input-method ()
  "Переключить метод ввода между английским и русским."
  (interactive)
  (if (string-equal current-input-method "russian-computer")
      (deactivate-input-method)
    (set-input-method "russian-computer")))

;; Отображение текущего метода ввода в строке состояния
(setq-default mode-line-misc-info
              (append mode-line-misc-info
                      '((:eval (when current-input-method
                                 (format " [%s]" current-input-method))))))
;; Центрировать строку с курсором
;; (evil-define-key 'normal 'global (kbd "C-;") 'recenter-top-bottom) 
;; (evil-define-key 'insert 'global (kbd "C-;") 'recenter-top-bottom) 


;; Делаем так, чтобы после выделения куросор после yank не перемещался в начало
;; Определяем новый оператор, который:
;; 1) делает yank текста
;; 2) ставит курсор на метку ">", которую Evil хранит в конце визуального региона
;; 3) выходит из визуального режима

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

(evil-define-key 'normal 'global (kbd "<leader>km") 'describe-bindings) 
(evil-define-key 'normal 'global (kbd "C-e") 'move-end-of-line) 
(evil-define-key 'insert 'global (kbd "C-e") 'move-end-of-line) 
(evil-define-key 'normal 'global (kbd "C-a") 'move-beginning-of-line) 
(evil-define-key 'insert 'global (kbd "C-a") 'move-beginning-of-line) 
(evil-define-key 'normal 'global (kbd "<leader>h") 'evil-ex-nohighlight)  
(evil-define-key 'normal 'global (kbd "<leader>chk") 'describe-key)  
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key '(normal insert) org-mode-map (kbd "TAB") 'org-cycle)
(evil-define-key 'normal 'global (kbd "C-'") 'comment-line)
(evil-define-key 'visual 'global (kbd "C-'") 'comment-dwim)
(evil-define-key 'normal 'global (kbd "<leader><") 'switch-to-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>,") 'switch-to-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>`") 'evil-switch-to-windows-last-buffer) 
(evil-define-key 'normal 'global (kbd "<leader><escape>") 'evil-switch-to-windows-last-buffer) 
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>.") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>:") 'execute-extended-command) 
;; Привязка функции к C-SPC в режиме вставки Evil
(evil-define-key 'insert global-map (kbd "C-SPC") 'toggle-russian-input-method)

;; вертикальное разделение экрана
(evil-define-key 'normal 'global (kbd "<leader>w/") 'split-window-right)
(evil-define-key 'normal racket-mode-map (kbd "<leader>rc") 'racket-run)
(evil-define-key 'normal racket-mode-map (kbd "<leader>rn") 'racket-xp-rename)
(evil-define-key 'normal 'global (kbd "<leader>wv") 'split-window-right)

;; горизонтальное разделение экрана
(evil-define-key 'normal 'global (kbd "<leader>w-") 'split-window-below)
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
(evil-define-key 'normal 'global (kbd "<leader>rc") 'my/run-current-python-file)


(evil-define-key 'insert 'global (kbd "C-k") (kbd "RET"))
(evil-define-key 'insert global-map (kbd "C-h") (kbd "DEL"))

;; закрытие всех окон, кроме текущего
(evil-define-key 'normal 'global (kbd "<leader>w1") 'delete-other-windows) 

;; переход к другому окну
(evil-define-key 'normal 'global (kbd "<leader>ww") 'other-window)  


;; toggle trancate lines
(evil-define-key 'normal 'global (kbd "<leader>tl") 'toggle-truncate-lines) 

(evil-define-key 'insert 'global (kbd "C-w") 'backward-kill-word)
;; (evil-define-key 'insert 'global (kbd "C-h") 'backward-delete-char-untabify)
(define-key evil-normal-state-map (kbd "C-p")
            (lambda ()
              (interactive)
              (save-excursion
                (end-of-line)
                (newline))))

;; Start Ace-jump-mode
(global-set-key (kbd "C-c SPC") 'ace-jump-word-mode)
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

;; ;; Переназначаем на M-<tab>
(define-key yas-minor-mode-map (kbd "M-<tab>") 'yas-expand) 

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

(define-key org-mode-map (kbd "TAB") nil)
