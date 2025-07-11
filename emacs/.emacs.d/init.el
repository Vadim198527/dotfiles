;; -*- lexical-binding: t; -*-

;; Установка и настройка package management
(setq evil-want-keybinding nil      ;; ← ДО обращения к evil
      evil-want-integration t
      evil-want-C-u-scroll t
      evil-undo-system 'undo-tree
      )
; ─── только пробелы, без символа TAB ──────────────────────────────
(setq-default indent-tabs-mode nil)   ;; никакого \t в файлах

;; ─── шаг отступа ──────────────────────────────────────────────────
(setq-default tab-width 4)            ;; один «визуальный таб» = 4 пробела
(setq-default evil-shift-width 4)     ;; ⇐ если пользуетесь evil-shift (>>/<<)


(require 'package)
(global-auto-revert-mode 1)

;; Теперь " перестает совпадать с системным регистром
(setq select-enable-clipboard nil   ; не трогать Clipboard
      select-enable-primary  nil)   ; не трогать Primary


(setq auto-revert-use-notify t) 
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))

;; Отключаем центрирование при перемещении вниз экрана
(setq scroll-conservatively 101)

(setq native-comp-async-report-warnings-errors nil)  ;; Отключить все предупреждения
;; Или, чтобы отключить только предупреждения о ширине docstring:
(setq native-comp-warning-on-missing-source nil
      native-comp-warning-on-restriction t
      native-comp-always-compile nil
      native-comp-deferred-compilation nil
      native-comp-async-report-warnings-errors 'silent)

;; ;; Включаем отображение номеров строк
;; (global-display-line-numbers-mode 1)

;; Включаем номера строк для всех режимов программирования
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Включаем номера строк для текстовых режимов
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;; Оставляем вашу настройку типа нумерации (это правильно)
(setq display-line-numbers-type 'relative)

;; Оставляем вашу настройку типа нумерации
(setq display-line-numbers-type 'relative)
;; --- Конец настройки отображения номеров строк ---
;; Set line number type to relative (current line absolute, others relative)
(setq display-line-numbers-type 'relative)

;; Установка use-package, если он не установлен
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Включение use-package
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

;; (desktop-save-mode 1)                         ; автосохранение включено
(require 'desktop)
(setq desktop-buffers-not-to-save
      (cons "\\.pdf$" desktop-buffers-not-to-save))
(desktop-save-mode 1)

;; (use-package exec-path-from-shell
;;   :defer nil ;; ← обязательно nil
;;   :config
;;   (exec-path-from-shell-initialize))
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

(use-package avy
  :config
  (with-eval-after-load 'evil
    ;; (evil-define-key 'normal 'global (kbd "C-/") 'avy-goto-char-timer)
    ;; (evil-define-key 'normal 'global (kbd "C-/") 'avy-goto-char-2)
    ;; Не
    (setq avy-orders-alist
 	  '((avy-goto-char-2 . avy-order-closest)
            (avy-goto-char-timer . avy-order-closest)))
    ;; (global-set-key (kbd "C-/") #'avy-goto-char-2)   ; глобально
    (global-set-key (kbd "C-/") #'avy-goto-char-timer)   ; глобально
    ;; (global-set-key (kbd "C-/") #'avy-goto-char)   ; глобально

    )
  )

;; Настройка тем и интерфейса
(use-package modus-themes
  :init
  ;; Настройки перед загрузкой темы
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil
        modus-themes-to-toggle '(modus-operandi modus-vivendi)
        modus-themes-common-palette-overrides
        '((bg-mode-line-active bg-sage)
          (fg-mode-line-active fg-main)
          (border-mode-line-active bg-green-intense)
          (bg-tab-bar bg-main)
          (bg-tab-current bg-active)
          (bg-tab-other bg-dim)
          (fringe unspecified)
          (underline-link unspecified)
          (underline-link-visited unspecified)
          (underline-link-symbolic unspecified)
          (fg-completion-match-0 blue)
          (fg-completion-match-1 magenta-warmer)
          (fg-completion-match-2 cyan)
          (fg-completion-match-3 red)
          (bg-completion-match-0 bg-blue-nuanced)
          (bg-completion-match-1 bg-magenta-nuanced)
          (bg-completion-match-2 bg-cyan-nuanced)
          (bg-completion-match-3 bg-red-nuanced)
          (comment yellow-faint)
          (string green-warmer)
          (prose-done green-faint)
          (prose-todo red-faint)))
  :config
  (load-theme 'modus-operandi :no-confirm)
  (define-key global-map (kbd "<f12>") #'modus-themes-toggle))
;; Настройка шрифтов
(set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 155)
(set-face-attribute 'variable-pitch nil :family "Iosevka Aile")

;; (use-package catppuccin-theme
;;   :ensure t
;;   :config
;;   (setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
;;   (catppuccin-reload)
;;   (set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 160)
;;   ;; (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160)
;;   )

;; Настройки org-mode
(use-package org
  :ensure nil
  :hook
  (org-mode . org-indent-mode)
  :config
  (setq org-auto-align-tags nil
        org-tags-column 0
        org-catch-invisible-edits 'show-and-error
        org-special-ctrl-a/e t
        org-hide-emphasis-markers t
        org-ellipsis "…"
        org-agenda-files (directory-files-recursively "~/docs" "\\.org$")
        org-agenda-tags-column 0
        org-agenda-block-separator ?─
        org-agenda-time-grid '((daily today require-timed)
			       (800 1000 1200 1400 1600 1800 2000)
			       " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
        org-agenda-current-time-string "◀── now ─────────────────────────────────────────────────"
        org-format-latex-options (plist-put org-format-latex-options :scale 1.9)))

;; Настройка yasnippet
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
  ;; ;; ;; Переназначаем на M-<tab>
  (define-key yas-minor-mode-map (kbd "<tab>") yas-maybe-expand)
  )

;; Настройка cdlatex
(use-package cdlatex
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (org-mode . turn-on-org-cdlatex)
	 (cdlatex-mode . my-cdlatex-disable-keys))
  :config
  (defun my-cdlatex-disable-keys ()
    ;; убираем автопару для "(" и ")"
    (define-key cdlatex-mode-map (kbd "(") nil)
    (define-key cdlatex-mode-map (kbd ")") nil)
    ;; убираем обработку апострофа
    (define-key cdlatex-mode-map (kbd "'") nil)))

;; (use-package pdf-tools
;;   :ensure t
;;   :hook (pdf-view-mode . (lambda () (display-line-numbers-mode -1))) ; <-- ДОБАВИТЬ ЭТО
;;   :config
;;   (pdf-tools-install)
;;   ;; вот эта строчка и снимет номера строк при входе в pdf-view-mode
;;   )

(defun my-latex-mode-keybindings ()
  "Custom keybindings for LaTeX mode."
  ;; Ваша существующая привязка для отступов
  (local-set-key (kbd "C-c i") 'indent-for-tab-command)
  ;; Новая привязка для компиляции и просмотра в Evil normal state
  ;; <leader>cv расшифровывается как "compile view" (или выберите свою комбинацию)
  )

;; Настройка AUCTeX
(use-package tex
  :ensure auctex
  :defer t

  :custom
  ;; общий отступ в LaTeX-окружениях
  (LaTeX-indent-level       4)
  ;; отступ внутри {…}
  (TeX-brace-indent-level   4)
  ;; отступ для \item
  (LaTeX-item-indent        0)

  :hook ((LaTeX-mode . (lambda () (TeX-fold-mode 1)))
	 (LaTeX-mode . my-latex-mode-keybindings)
	 (LaTeX-mode . (lambda ()
			 ;;  𝓔 𝓗 𝓘 𝓙 𝓚 𝓛 𝓜 𝓝 𝓞  𝓠 𝓡 𝓢 𝓣 𝓤 𝓥 𝓦 𝓧 𝓨 𝓩
                         (dolist (pair
                                  '(("\\blank"      . ?—)
                                    ("\\otimes"     . ?⨂)
                                    ("\\defeq"      . ?≔)
                                    ("\\mathcal{A}" . ?𝓐)
                                    ("\\mathcal{B}" . ?𝓑)
                                    ("\\mathcal{C}" . ?𝓒)
                                    ("\\mathcal{D}" . ?𝓓 )
                                    ("\\mathcal{G}" . ?𝓖 )
                                    ("\\mathcal{F}" . ?𝓕 )
                                    ("\\mathcal{P}" . ?𝓟 )
                                    ("\\mathrm{A}" . ?A )
                                    ("\\mathrm{B}" . ?B )
                                    ("\\mathrm{C}" . ?C )
                                    ("\\mathrm{D}" . ?D )
                                    ("\\mathrm{E}" . ?E )
                                    ("\\mathrm{L}" . ?L )
                                    ("\\mathrm{P}" . ?P )
                                    ("\\mathrm{R}" . ?R )
                                    ("\\mathrm{S}" . ?S )
                                    ("\\mathrm{T}" . ?T )
                                    ("\\mathrm{X}" . ?X )
                                    ("\\mathrm{Y}" . ?Y )
                                    ("\\mathrm{Z}" . ?Z )
                                    ("\\!\\upharpoonright" . ?↾ )
                                    ("\\implies" . ?⇒ )
                                    ("\\land" . ?∧)
                                    ("\\varnothing" . ?∅)
                                    ("\\cat{C}"     . ?𝓒)))
                           (push pair prettify-symbols-alist))
                         (prettify-symbols-mode 1))))
  :config
  (setopt TeX-fold-macro-spec-list '(("{1}" ("emph" "text"))))
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  ;; (add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode)
  (setq-default TeX-PDF-mode t)
  ;; (setq TeX-engine 'pdflatex)
  ;; (setq TeX-engine 'latexmk)
  (setq TeX-engine 'luatex)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-start-server t)
  (setq TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  )
(setq-default TeX-engine 'xetex) ; или 'luatex
;; (setq-default TeX-engine 'luatex) ; или 'luatex

;; (use-package tex
;;   :ensure auctex
;;   :defer t
;;   :hook ((LaTeX-mode . (lambda () (TeX-fold-mode 1)))
;; 	 (LaTeX-mode . my-latex-mode-keybindings)
;; 	 (LaTeX-mode . (lambda ()
;; 			 ;; ... ваш код с prettify-symbols-alist ...
;;                          (dolist (pair
;;                                   '(("\\blank"      . ?—)
;;                                     ("\\otimes"     . ?⨂)
;;                                     ("\\defeq"      . ?≔)
;;                                     ("\\mathcal{A}" . ?𝓐)
;;                                     ("\\mathcal{B}" . ?𝓑)
;;                                     ("\\mathcal{C}" . ?𝓒)
;;                                     ("\\mathcal{D}" . ?𝓓 )
;;                                     ("\\mathcal{G}" . ?𝓖 )
;;                                     ("\\mathcal{F}" . ?𝓕 )
;;                                     ("\\mathcal{P}" . ?𝓟 )
;;                                     ("\\mathrm{A}" . ?A )
;;                                     ("\\mathrm{B}" . ?B )
;;                                     ("\\mathrm{C}" . ?C )
;;                                     ("\\mathrm{D}" . ?D )
;;                                     ("\\mathrm{E}" . ?E )
;;                                     ("\\mathrm{L}" . ?L )
;;                                     ("\\mathrm{P}" . ?P )
;;                                     ("\\mathrm{R}" . ?R )
;;                                     ("\\mathrm{S}" . ?S )
;;                                     ("\\mathrm{T}" . ?T )
;;                                     ("\\mathrm{X}" . ?X )
;;                                     ("\\mathrm{Y}" . ?Y )
;;                                     ("\\mathrm{Z}" . ?Z )
;;                                     ("\\!\\upharpoonright" . ?↾ )
;;                                     ("\\implies" . ?⇒ )
;;                                     ("\\land" . ?∧)
;;                                     ("\\varnothing" . ?∅)
;;                                     ("\\cat{C}"     . ?𝓒)))
;;                            (push pair prettify-symbols-alist))
;;                          (prettify-symbols-mode 1))))
;;   :config
;;   ;; --- ОСНОВНЫЕ НАСТРОЙКИ ---
;;   (setq TeX-auto-save t)
;;   (setq TeX-parse-self t)
;;   (setq-default TeX-PDF-mode t)

;;   ;; --- НАСТРОЙКА ПРОСМОТРА PDF ---
;;   (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
;;   (setq TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
;;   (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;;   ;; --- НАСТРОЙКА СИНХРОНИЗАЦИИ ---
;;   (setq TeX-source-correlate-mode t)
;;   (setq TeX-source-correlate-start-server t)

;;   ;; --- ЖЕСТКОЕ ПЕРЕОПРЕДЕЛЕНИЕ КОМАНДЫ КОМПИЛЯЦИИ ---
;;   ;; 1. Добавляем новую команду "LuaLaTeX" в список
;;   (add-to-list 'TeX-command-list
;;                '("LuaLaTeX" "lualatex -synctex=1 -interaction=nonstopmode -file-line-error %s"
;;                  TeX-run-TeX nil (latex-mode) :help "Run LuaLaTeX"))

;;   ;; 2. Устанавливаем эту новую команду как команду по умолчанию
;;   (setq TeX-command-default "LuaLaTeX"))

(use-package pdf-tools
  :defer t
  :magic ("%PDF")
  :config
  ;; ШАГ 1: "Обманываем" проверку, чтобы убрать предупреждение.
  ;; Мы удаляем display-line-numbers-mode из списка несовместимых режимов.
  (setq pdf-view-incompatible-modes
        (remove 'display-line-numbers-mode pdf-view-incompatible-modes))

  ;; ШАГ 2: "Наводим порядок", отключая режим, который нам не нужен.
  ;; Этот хук сработает после проверки и тихо выключит номера строк.
  (add-hook 'pdf-view-mode-hook #'display-line-numbers-mode-off-in-pdf)
  (defun display-line-numbers-mode-off-in-pdf ()
    "Отключает display-line-numbers-mode в буферах PDF."
    (display-line-numbers-mode -1))

  ;; --- Остальные ваши рабочие настройки ---
  (pdf-tools-install :no-query)
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))



;; (defun my-latex-compile-and-view ()
;;   "Compile LaTeX document and view PDF without prompting."
;;   (interactive)
;;   (save-buffer) ;; Сохраняем текущий буфер

;;   ;; Запускаем компиляцию
;;   (TeX-command "LaTeX" 'TeX-master-file)

;;   ;; Устанавливаем таймер для просмотра после компиляции
;;   (run-with-timer 1.0 nil
;;                   (lambda ()
;;                     ;; Напрямую вызываем функцию просмотра без запроса
;;                     (TeX-view))))


;; ;; Обеспечиваем автоматическое обновление PDF буферов
;; (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
;; (setq auto-revert-interval 0.5)

;; ;; Гарантируем, что PDF-буфер обновляется после компиляции
;; (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)

;; Привязка клавиш в режиме LaTeX
(with-eval-after-load 'evil
  (evil-define-key 'normal LaTeX-mode-map
    (kbd "<leader>cv") 'my-latex-compile-and-view))

;; Настройка aas
(use-package aas
  :hook ((LaTeX-mode . aas-activate-for-major-mode)
         (org-mode . aas-activate-for-major-mode)
         (TeX-mode . aas-activate-for-major-mode))
  :config
  (defun my/real-math-p ()
    "Истинно только внутри $…$, \\(…\\), \\[…\\] или *реального* math‑env."
    (let ((info (texmathp)))
      (and info
           (memq (car info)         ; первый элемент описывает «где» мы находимся
		 '(in-dollar in-paren in-env)))))
  (aas-set-snippets 'text-mode
    ";o-" "ō"
    ";i-" "ī"
    ";a-" "ā"
    ";u-" "ū"
    ";e-" "ē")
  (aas-set-snippets 'org-mode
    ";latex" (lambda ()
	       (interactive)
	       (yas-expand-snippet (yas-lookup-snippet "latexCode")))
    ;; Добавьте остальные сниппеты здесь
    )
  (aas-set-snippets 'LaTeX-mode
    "mk" (lambda ()
	   (interactive)
	   (yas-expand-snippet (yas-lookup-snippet "makeMathEnv")))
    "dm" (lambda ()
	   (interactive)
	   (yas-expand-snippet (yas-lookup-snippet "makeMathBlockEnv")))

    "RR" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathbb{R} ")
	     (insert "$\\mathbb{R}$ ")))
    ";A" "$\\mathrm{A}$"
    ";B" "$\\mathrm{B}$"
    ";L" "$\\mathrm{L}$"
    ";P" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathrm{P}")
	     (insert "$\\mathrm{P}$")))
    ";R" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathrm{R}")
	     (insert "$\\mathrm{R}$")))
    ";S" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathrm{S}")
	     (insert "$\\mathrm{S}$")))
    ";T" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathrm{T}")
	     (insert "$\\mathrm{T}$")))

    ";X" (lambda ()
	   (interactive)
	   (if (not (texmathp)) 
	       (insert "$\\mathrm{X}$")
	     ))

    ";Y" "$\\mathrm{Y}$"
    ";Z" (lambda ()
	   (interactive)
	   (if (not (texmathp)) 
	       (insert "$\\mathrm{Z}$")
	     ))


    ",F" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathcal{F}")
	     (insert "$\\mathcal{F}$")))
    ",G" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathcal{G}")
	     (insert "$\\mathcal{G}$")))
    ",R" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\mathcal{R}")
	     (insert "$\\mathcal{R}$")))
    ",P" "$\\mathcal{P}$"


    "=>" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\implies ")
	     (insert "$\\implies$ ")))

    "->" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\to ")
	     (insert "$\\to $ ")))

    "!=" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\neq ")
	     (insert "$\\neq$")))
    "OO" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\varnothing ")
	     (insert "$\\varnothing$ ")))
    "CC" (lambda ()
	   (interactive)
	   (if (texmathp) 
	       (insert "\\subseteq ")
	     (insert "$\\subseteq$ ")))

    ";CC" (lambda ()
	    (interactive)
	    (if (texmathp) 
		(insert "\\supseteq")
	      (insert "$\\supseteq$")))
    ;; "oo" (lambda ()
    ;; 	   (interactive)
    ;; 	   (if (texmathp)
    ;; 	       (insert "\\circ ")))

    :cond #'texmathp
    "oo" "\\circ "
    "aa" "\\forall "
    "ee" "\\exists "
    "eu" "\\exists! "
    "inn" "\\in "
    "iff" "\\iff "
    "&&" "\\land "
    "==" "&= "
    "**" "\\cdot "

    "nn" "\\cap "

    "xx" "\\times "

    "rct" "\\!\\upharpoonright "
    "txt" (lambda ()
	    (interactive)
	    (yas-expand-snippet (yas-lookup-snippet "text")))
    ))



;; Настройка org-roam
(use-package org-roam
  :custom
  (org-roam-directory "~/Desktop/org-roam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(use-package vterm)

(use-package undo-tree
  :ensure t
  :demand t
  :diminish
  ;; -------------------- Параметры ДО включения режима --------------------
  :init
  ;; сохранять историю между сессиями
  (setq undo-tree-auto-save-history t)
  ;; складываем все файлы вида *.~undo-tree~ в одну папку
  (setq undo-tree-history-directory-alist
        `(("." . ,(expand-file-name "undo-tree-history/" user-emacs-directory))))
  (unless (file-directory-p (cdr (assoc "." undo-tree-history-directory-alist)))
    (make-directory (cdr (assoc "." undo-tree-history-directory-alist)) t))

  ;; показывать для каждого узла, когда он был создан
  (setq undo-tree-visualizer-timestamps t)          ; абсолютное «2025-05-08 19:23»

  ;; сразу показывать diff при навигации (необязательно — уберите, если мешает)
  (setq undo-tree-visualizer-diff t)

  ;; желаемые лимиты памяти (опционально)
  (setq undo-limit        400000    ; ~400 KB: когда Emacs начинает выбрасывать undo-записи
        undo-strong-limit 600000    ; ~600 KB: прежде чем удалять связанные редактирования
        undo-outer-limit  800000    ; ~800 KB: жёсткий предел на один шаг
        undo-tree-enable-undo-in-region t)

  ;; -------------------- Включаем глобально --------------------
  :config
  ;; можно добавить прямо после (use-package undo-tree …)
  (with-eval-after-load 'undo-tree
    ;; убираем лишние клавиши
    (define-key undo-tree-map (kbd "C-/") nil)
    (define-key undo-tree-map (kbd "C-_") nil))   ; ← опционально

  (global-undo-tree-mode 1))

;; Настройка evil-mode
(use-package evil
  :ensure t
  :after undo-tree  ;; Загружать только после undo-tree
  :init
  (setq evil-disable-insert-state-bindings t)
  (setq evil-undo-system 'undo-tree) ; Можно оставить или убрать, т.к. уже задано выше
  ;; ;; Делаем курсор в inert mode блоком с цветом #b6bff9
  ;; ;; Set cursor to change only color in insert mode (not shape)
  ;; (setq evil-normal-state-cursor '(box "black")       ;; Normal mode: box cursor, white color
  ;; 	;; evil-insert-state-cursor '(box "#57cc99")     ;; Insert mode: box cursor, blue color
  ;; 	;; evil-insert-state-cursor '(box "#2b9348")     ;; Insert mode: box cursor, blue color
  ;; 	evil-insert-state-cursor '(box "#8F00FF")     ;; Insert mode: box cursor, blue color
  ;; 	evil-visual-state-cursor '(box "red")      ;; Visual mode: box cursor, orange color
  ;; 	evil-replace-state-cursor '(box "red"))       ;; Replace mode: box cursor, red color
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "SPC"))
  (defun my/lisp-symbol-words ()
    ;; локально в буфере paredit'а
    ;; (setq-local evil-symbol-word-search t)
    (defalias #'forward-evil-word #'forward-evil-symbol))

  (add-hook 'paredit-mode-hook #'my/lisp-symbol-words)

  ;; Добавляем привязку leader ut для undo-tree-visualize
  (evil-define-key 'normal 'global (kbd "<leader>ut") 'undo-tree-visualize))


;;; ─── полноценные vi$ / va$ ────────────────────────────────────────────
;; положите *после* (evil-mode 1)

(evil-define-text-object my/evil-dollar-inner (count &optional beg end type)
  "Взять текст между ближайшими $ … $."
  (evil-select-quote ?$ beg end type count))      ; ← здесь quote, а не paren

(evil-define-text-object my/evil-dollar-outer (count &optional beg end type)
  "Взять вместе с долларами."
  (evil-select-quote ?$ beg end type count t))

(define-key evil-inner-text-objects-map "$" #'my/evil-dollar-inner)
(define-key evil-outer-text-objects-map "$" #'my/evil-dollar-outer)


(use-package evil-collection
  :after evil
  :ensure t
  :init
  (evil-collection-init)
  (evil-collection-org-setup)
  ;; :config
  ;; (add-hook 'org-agenda-mode-hook 'evil-normal-state)
  )

;; Настройка vertico
(use-package vertico
  :demand t  ;; Загружать пакет немедленно, не откладывая
  :init
  (vertico-mode)  ;; Активировать сразу при загрузке
  :bind (:map minibuffer-local-map
	      ("C-n" . vertico-next)
	      ("C-p" . vertico-previous)))

;; Настройка consult
(use-package consult
  :ensure t
  :after recentf
  :config
  ;; (setq consult-project-root-function #'projectile-project-root)
  (evil-define-key 'normal 'global (kbd "<leader>,") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>fg") 'consult-grep)
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'consult-recent-file)
  (evil-define-key 'normal 'global (kbd "<leader>oa") 'org-agenda))

;; Настройка embark и embark-consult
(use-package embark
  :bind (("C-." . embark-act))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

;; Настройка savehist
(use-package savehist
  :init
  (savehist-mode))

;; Настройка expand-region
(use-package expand-region
  :bind (("C-=" . er/expand-region)))

;; Настройка recentf
(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  :custom
  (recentf-max-saved-items 100))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; Отключение стартового экрана и звукового сигнала
(setq inhibit-startup-message t)
;; (setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Настройка функций навигации окон
(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(defun other-window-forward (&optional n)
  "Select Nth next window."
  (interactive "P")
  (other-window (prefix-numeric-value n)))

;; Настройка функций прокрутки
(defun scroll-n-lines-ahead (&optional n)
  "Scroll N lines ahead."
  (interactive "P")
  (scroll-up (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "Scroll N lines behind."
  (interactive "P")
  (scroll-down (prefix-numeric-value n)))



(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((python-mode . lsp)
	 (c-mode . lsp)) ; запуск lsp при открытии python-файлов
  :init
  ;; Настройки, опционально
  (setq lsp-keymap-prefix "C-c l") ; быстрый доступ к командам lsp
  (setq lsp-log-io t)
  ;; (with-eval-after-load 'lsp-mode
  ;;   (setq lsp-pylsp-plugins-pylint-args '("--disable=C0111")))

  :config
  ;; Для небольших проектов можно отключить персистентный серверный кэш
  (setq lsp-enable-file-watchers nil))
;;;; ─── Pyright ─────────────────────────────────────────────────────────
(use-package lsp-pyright
  :ensure t                 ;; скачает пакет с MELPA
  :after lsp-mode           ;; подгрузится после lsp-mode
  :init
  ;; полезные (необязательные) параметры
  (setq lsp-pyright-typechecking-mode "basic"      ; или "strict"
        lsp-pyright-auto-import-completions t
        lsp-pyright-use-library-code-for-types t)
  :hook
  ;; в Python-буфере подгружаем lsp-pyright и запускаем lsp
  ;; (lsp-deferred стартует сервер лениво, чуть ускоряет открытие файла)
  (python-mode . (lambda ()
                   (require 'lsp-pyright)
                   (lsp-deferred)))
  :config
  (with-eval-after-load 'lsp-mode
    (setq lsp-disabled-clients '(pyls pylsp mspyls jedi)))

  )
;;;; ─────────────────────────────────────────────────────────────────────

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package clang-format
  :ensure t
  :bind (:map c-mode-map
	      ("C-c f" . clang-format-region)))


;; (use-package corfu
;;   ;; ---------- ПЕРЕМЕННЫЕ ----------
;;   :custom
;;   (corfu-cycle          t)
;;   (corfu-auto           t)
;;   (corfu-auto-prefix    2)
;;   (corfu-auto-delay     0.0)
;;   (corfu-preselect      'prompt)

;;   ;; ---------- НАСТРОЙКА ДО ЗАПУСКА ----------
;;   :init
;;   ;; Добавляем LaTeX‑режимы в список исключений
;;   (setq corfu-excluded-modes '(latex-mode LaTeX-mode))

;;   ;; Теперь можно включать глобально
;;   (global-corfu-mode)

;;   ;; Дополнительные мини‑моды
;;   (corfu-popupinfo-mode)
;;   (corfu-history-mode)

;;   ;; ---------- ПОСЛЕ ЗАГРУЗКИ ----------
;;   :config
;;   ;; убираем TAB из keymap, если нужно
;;   (keymap-unset corfu-map "TAB")
;;   ;; (global-set-key (kbd "TAB") nil)
;;   )


;; (use-package cape
;;   ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
;;   ;; Press C-c p ? to for help.
;;   :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
;;   :init
;;   (add-hook 'completion-at-point-functions #'cape-dabbrev)
;;   (add-hook 'completion-at-point-functions #'cape-file)
;;   (add-hook 'completion-at-point-functions #'cape-elisp-block))
;; ;; ;; ── Отключить штатный elisp-CAPF во всех .el-буферах ────────────────
;; ;; (defun my/elisp-disable-default-capf ()
;; ;;   "Убрать `elisp-completion-at-point' из списка CAPF'ов в текущем буфере."
;; ;;   (remove-hook 'completion-at-point-functions
;; ;;                #'elisp-completion-at-point
;; ;;                t))                ;; «t» ⇒ правим *локальную* копию списка

;; ;; (add-hook 'emacs-lisp-mode-hook #'my/elisp-disable-default-capf)

;;; --- Corfu --------------------------------------------------------------
(use-package corfu
  :custom
  (corfu-auto t) (corfu-cycle t)
  (corfu-auto-prefix 2) (corfu-auto-delay 0)
  (corfu-preselect 'prompt)
  :init
  (setq corfu-excluded-modes '(latex-mode LaTeX-mode))
  (global-corfu-mode)
  (corfu-popupinfo-mode) (corfu-history-mode)
  :config (keymap-unset corfu-map "TAB"))

;;; --- Cape ---------------------------------------------------------------
;; (use-package cape
;;   :bind ("C-c p" . cape-prefix-map)
;;   :init
;;   ;;------------------------------------------------------------
;;   ;; 1. Elisp-символы + dabbrev → один Capf
;;   ;;------------------------------------------------------------
;;   (defun my/elisp+dabbrev-capf ()
;;     "Show Elisp symbols **and** words from buffers at the same time."
;;     (let* (;; вызов штатного Capf без флага :exclusive
;;            (elisp-res (funcall (cape-wrap-nonexclusive
;;                                 #'elisp-completion-at-point)))
;;            (dabbrev-res (funcall #'cape-dabbrev)))
;;       (when (and elisp-res dabbrev-res)
;;         ;; обе функции вернули список (beg end table . props)
;;         (pcase-let* ((`(,beg ,end ,table1 . ,plist1) elisp-res)
;;                      (`(,_   ,_   ,table2)           dabbrev-res))
;;           (list
;;            beg end
;;            ;; объединяем две таблицы кандидатов
;;            (completion-table-merge table1 table2)
;;            ;; передаём полезные метаданные Elisp-Capf,
;;            ;; плюс своя функция сортировки
;;            :annotation-function  (plist-get plist1 :annotation-function)
;;            :company-docsig       (plist-get plist1 :company-docsig)
;;            :category             (plist-get plist1 :category)
;;            :display-sort-function
;;            (lambda (cands)
;;              ;; сначала более точные/короткие, потом по алфавиту
;;              (sort cands
;;                    (lambda (a b)
;;                      (if (= (length a) (length b))
;;                          (string-lessp a b)
;;                        (< (length a) (length b)))))))))))

;;   (defun my/setup-elisp-capfs ()
;;     ;; NB: `cape-file` оставляем отдельным: это «многошаговый» Capf
;;     (setq-local completion-at-point-functions
;;                 (list #'my/elisp+dabbrev-capf
;;                       #'cape-file)))

;;   (add-hook 'emacs-lisp-mode-hook        #'my/setup-elisp-capfs)
;;   (add-hook 'lisp-interaction-mode-hook  #'my/setup-elisp-capfs)

;;   ;;------------------------------------------------------------
;;   ;; 2. В остальных режимах — просто добавляем dabbrev в конец
;;   ;;------------------------------------------------------------
;;   (defun my/append-dabbrev ()
;;     (add-hook 'completion-at-point-functions #'cape-dabbrev -1 t))
;;   (add-hook 'after-change-major-mode-hook #'my/append-dabbrev))


;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion)))
					(command (styles orderless basic))
					(variable (styles orderless basic))
					(symbol (styles orderless basic)))
        orderless-component-separator "[ -]"))

;; https://www.racket-mode.com/#Install-Update-and-Uninstall 
(use-package racket-mode
  :mode ("\\.rkt\\'")
  :hook (racket-mode . racket-xp-mode)
  :config
  (evil-define-key 'normal racket-mode-map (kbd "<leader>de") '(lambda () (interactive)
								 (racket-xp-mode t)))
  (evil-define-key 'normal racket-mode-map (kbd "<leader>dd") '(lambda () (interactive) 
								 (racket-xp-mode -1))))
;; Удобное редактирование Lisp-кода (структурное редактирование)
(use-package paredit
  :config
  (dolist (m '(emacs-lisp-mode-hook
	       racket-mode-hook
	       racket-repl-mode-hook))
    (add-hook m #'paredit-mode)) 
  (evil-define-key 'normal paredit-mode-map (kbd "<)") 'paredit-forward-slurp-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd ">)") 'paredit-forward-barf-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd ">(") 'paredit-backward-slurp-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd "<(") 'paredit-backward-barf-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd "|") 'paredit-split-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>jn") 'paredit-join-sexps)
  ;; (evil-define-key 'normal paredit-mode-map (kbd "<leader>(") 'paredit-wrap-round)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>d(") 'paredit-splice-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd "C-f") 'paredit-forward)
  (evil-define-key 'normal paredit-mode-map (kbd "C-b") 'paredit-backward)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>bu") 'paredit-backward-up)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>bd") 'paredit-backward-down)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>fu") 'paredit-forward-up)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>fd") 'paredit-forward-down)
  (evil-define-key 'insert paredit-mode-map (kbd "RET") 'paredit-newline)
  (evil-define-key 'insert paredit-mode-map (kbd "C-k") 'paredit-newline)
  (evil-define-key 'normal racket-repl-mode (kbd "C-h") 'evil-window-left)  
  (evil-define-key 'insert racket-repl-mode (kbd "C-h") 'evil-window-left)  
  (evil-define-key 'insert paredit-mode-map (kbd "C-h") 'paredit-backward-delete))


(use-package cmuscheme
  :ensure nil               ;; т.к. это встроенный пакет Emacs
  :commands (run-scheme)    ;; автозагрузка при вызове M-x run-scheme
  :config
  ;; Указываем, что основная программа для Scheme — это MIT Scheme
  (setq scheme-program-name "mit-scheme")

  ;; Опционально: если хотите, чтобы при M-x run-scheme создавался
  ;; буфер с именем "MIT Scheme" вместо "*scheme*":
  (setq cmuscheme-name "MIT Scheme"))

(use-package evil-mc
  :after evil
  :config
  (global-evil-mc-mode 1)
  ;; (evil-define-key 'normal evil-mc-key-map (kbd "C-n") #'evil-mc-make-and-goto-next-cursor)
  (with-eval-after-load 'evil-mc
    ;; Привязываем C-n к команде evil-mc-make-and-goto-next-match в normal state
    (evil-define-key 'normal evil-mc-key-map (kbd "C-n") #'evil-mc-make-and-goto-next-match)
    ;; (опционально) Аналогично для visual state
    (evil-define-key 'visual evil-mc-key-map (kbd "C-n") #'evil-mc-make-and-goto-next-match)
    (evil-define-key 'normal evil-mc-key-map (kbd "<leader>cl") #'evil-mc-undo-all-cursors)
    ))

;; Установка через package.el
(use-package evil-goggles
  :ensure t
  :config
  ;; Активируем режим
  (evil-goggles-mode)
  
  ;; Настройка длительности подсветки (в секундах)
  (setq evil-goggles-duration 0.040)
  
  ;; Настройка цвета для операции yank
  (custom-set-faces
   '(evil-goggles-yank-face ((t (:background "#00afff" :foreground "black")))))
  
  ;; Включение эффекта пульсации
  (setq evil-goggles-pulse t)
  
  ;; Переопределяем функцию yank, чтобы курсор оставался на месте
  (defun my/evil-yank-with-cursor-stay (orig-fun beg end &optional type register yank-handler)
    "Оберточная функция для evil-yank, которая сохраняет позицию курсора."
    (let ((pos (point)))
      (funcall orig-fun beg end type register yank-handler)
      (goto-char pos)))
  
  ;; Применяем наш совет к функции evil-yank
  (advice-add 'evil-yank :around #'my/evil-yank-with-cursor-stay)
  
  ;; Обеспечиваем сохранение позиции для visual-режима
  (defun my/evil-visual-yank-with-cursor-stay (orig-fun beg end &optional type register)
    "Оберточная функция для evil-visual-yank, которая сохраняет позицию курсора."
    (let ((pos (point)))
      (funcall orig-fun beg end type register)
      (goto-char pos)))
  
  (advice-add 'evil-yank-lines :around #'my/evil-visual-yank-with-cursor-stay))

;; if you don’t already have use-package installed:
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


(use-package treemacs
  :ensure t
  :defer t                               ; не грузится, пока не вызовете
  :init
  ;; <leader> t — показать / скрыть дерево
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "<leader>t") #'treemacs)) ; «treemacs» уже умеет переключать

  :config
  ;; немного косметики (меняйте по вкусу)
;;;; ─── C-h/j/k/l работают и в Treemacs ────────────────────────────────
  (with-eval-after-load 'treemacs-evil      ; после того, как создано состояние treemacs
    (with-eval-after-load 'evil
      ;; <leader> t внутри treemacs-state
      (evil-define-key 'treemacs treemacs-mode-map
	(kbd "<leader>t") #'treemacs)             ; ← добавили!
      (dolist (state '(treemacs normal))    ; дублируем в оба
	(evil-define-key state treemacs-mode-map
          (kbd "C-h") #'evil-window-left
          (kbd "C-l") #'evil-window-right
          (kbd "C-j") #'evil-window-down
          (kbd "C-k") #'evil-window-up))))
;;;; ─────────────────────────────────────────────────────────────────────

  (setq treemacs-width                 35
        treemacs-show-hidden-files      t
        treemacs-follow-after-init      t
        treemacs-filewatch-mode         t
        treemacs-git-mode              'deferred)

  ;; включаем вспомогательные режимы
  (treemacs-follow-mode          1)
  (treemacs-filewatch-mode       1)
  (treemacs-fringe-indicator-mode 'always))

;; Evil-специфические клавиши внутри окна Treemacs
(use-package treemacs-evil
  :after (treemacs evil))

;; Если пользуетесь Projectile / project.el
(use-package treemacs-projectile
  :after (treemacs projectile))


;;;; ─────────────────────────────────────────────────────────────────────
(use-package harpoon
  :ensure t                ;; берём из MELPA
  :custom
  ;; 1) полностью игнорировать систему проектов
  (harpoon-project-package nil)       ;; → буфер считается «вне проекта»
  ;; 2) не плодить отдельные списки на git-ветки
  (harpoon-separate-by-branch nil)
  ;; 3) а когда «вне проекта» — всегда использовать
  ;;    ОДНО и то же имя кеш-файла (здесь: "global")
  (harpoon-without-project-function (lambda () "global"))
  ;; :bind
  ;; (("<leader>;"       . harpoon-quick-menu-hydra)  ;; меню сбоку
  ;;  ("<leader>ha"   . harpoon-add-file)          ;; добавить текущий файл
  ;;  ;; мгновенные прыжки
  ;;  ("C-c h 1" . harpoon-go-to-1)
  ;;  ("C-c h 2" . harpoon-go-to-2)
  ;;  ("C-c h 3" . harpoon-go-to-3)
  ;;  ("C-c h 4" . harpoon-go-to-4)
  ;;  ("C-c h 5" . harpoon-go-to-5)
  ;;  ("C-c h 6" . harpoon-go-to-6)
  ;;  ("C-c h 7" . harpoon-go-to-7)
  ;;  ("C-c h 8" . harpoon-go-to-8)
  ;;  ("C-c h 9" . harpoon-go-to-9))
  :config 
  (evil-define-key 'normal 'global (kbd "<leader>;") #'harpoon-quick-menu-hydra)
  (evil-define-key 'normal 'global (kbd "<leader>a h") #'harpoon-add-file))

;; ;; === chrome emacs ===
;; (use-package atomic-chrome
;;   :ensure t                       ;; автоматическая установка из melpa
;;   :hook (after-init . atomic-chrome-start-server) ;; старт сервера после загрузки emacs
;;   :custom
;;   ;; синхронизация «на лету» — правки сразу уходят обратно в браузер
;;   (atomic-chrome-enable-auto-update t)   ; отключите, если хотите отправлять c-c c-s :contentreference[oaicite:0]{index=0}
;;   ;; какой major-mode включать, если сайт не распознан
;;   (atomic-chrome-default-major-mode 'markdown-mode)
;;   ;; куда открывать буфер (frame | split | full)
;;   (atomic-chrome-buffer-open-style 'frame)
;;   ;; разные режимы для разных сайтов
;;   (atomic-chrome-url-major-mode-alist
;;    '(("github\\.com"       . gfm-mode)
;;      ("stackoverflow\\.com". markdown-mode)))
;;   ;; если стандартный порт 4001 занят, поменяйте так:
;;   (atomic-chrome-server-port 4001)
;;   :config
;;   ;; сообщение для уверенности, что всё запустилось
;;   (message "✅ atomic-chrome server is running"))

;; === Atomic-Chrome + Brave =============================================
(use-package atomic-chrome
  :ensure t
  :hook (after-init . atomic-chrome-start-server)
  :custom
  (atomic-chrome-buffer-open-style 'frame)
  :config
  ;; Имя процесса/класса/приложения Brave для каждой платформы
  (defconst my/brave-target
    (pcase system-type
      ('darwin      "Brave Browser")          ; имя приложения в AppleScript
      ('gnu/linux   "brave")                  ; WM_CLASS → wmctrl/xdotool
      ('windows-nt  "brave.exe")))            ; исполняемый файл

  (defun my/atomic-chrome-return-to-brave ()
    "Закрыть временный фрейм и вернуть фокус в Brave."
    ;; 1. Удаляем только «временной» фрейм, созданный atomic-chrome
    (when (frame-parameter nil 'atomic-chrome-edit-frame)
      (delete-frame))
    ;; 2. Активируем Brave ― способы зависят от ОС
    (pcase system-type
      ;; macOS — AppleScript
      ('darwin
       (start-process
        "" nil "osascript"
        "-e" (format "tell application \"%s\" to activate"
                     my/brave-target)))                       ; :contentReference[oaicite:0]{index=0}
      ;; Linux/X11 — wmctrl (или xdotool, если wmctrl не найден)
      ('gnu/linux
       (cond ((executable-find "wmctrl")
              (call-process "wmctrl" nil nil nil "-xa" my/brave-target)) ; :contentReference[oaicite:1]{index=1}
             ((executable-find "xdotool")
              (call-process "xdotool" nil nil nil "search" "--onlyvisible"
                            "--class" my/brave-target "windowactivate"))))
      ;; Windows — NirCmd (portable)
      ('windows-nt
       (when (executable-find "nircmd.exe")
         (call-process "nircmd.exe" nil nil nil
                       "win" "activate" "process" my/brave-target))))) ; :contentReference[oaicite:2]{index=2}
  ;; Вешаем функцию на завершение редактирования
  (add-hook 'atomic-chrome-edit-done-hook #'my/atomic-chrome-return-to-brave))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("0a2168af143fb09b67e4ea2a7cef857e8a7dad0ba3726b500c6a579775129635"
     "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d"
     "51fa6edfd6c8a4defc2681e4c438caf24908854c12ea12a1fbfd4d055a9647a3"
     "99d1e29934b9e712651d29735dd8dcd431a651dfbe039df158aa973461af003e"
     "0517759e6b71f4ad76d8d38b69c51a5c2f7196675d202e3c2507124980c3c2a3"
     "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2"
     "e410458d3e769c33e0865971deb6e8422457fad02bf51f7862fa180ccc42c032"
     "48042425e84cd92184837e01d0b4fe9f912d875c43021c3bcb7eeb51f1be5710"
     "3f1dcd824a683e0ab194b3a1daac18a923eed4dba5269eecb050c718ab4d5a26"
     "8ccbbbf5c197f80c9dce116408a248fde1ac4fedd9b5b7883e729eba83c9c64e"
     default))
 '(evil-emacs-state-modes
   '(5x5-mode bbdb-mode biblio-selection-mode blackbox-mode
	      bookmark-edit-annotation-mode browse-kill-ring-mode
	      bs-mode bubbles-mode bzr-annotate-mode calc-mode
	      cfw:calendar-mode completion-list-mode
	      custom-theme-choose-mode delicious-search-mode
	      desktop-menu-blist-mode desktop-menu-mode dun-mode
	      dvc-bookmarks-mode dvc-diff-mode dvc-info-buffer-mode
	      dvc-log-buffer-mode dvc-revlist-mode dvc-revlog-mode
	      dvc-status-mode dvc-tips-mode ediff-mode ediff-meta-mode
	      efs-mode Electric-buffer-menu-mode emms-browser-mode
	      emms-mark-mode emms-metaplaylist-mode emms-playlist-mode
	      ess-help-mode etags-select-mode fj-mode gc-issues-mode
	      gdb-breakpoints-mode gdb-disassembly-mode
	      gdb-frames-mode gdb-locals-mode gdb-memory-mode
	      gdb-registers-mode gdb-threads-mode gist-list-mode
	      git-rebase-mode gomoku-mode google-maps-static-mode
	      jde-javadoc-checker-report-mode magit-cherry-mode
	      magit-diff-mode magit-log-mode magit-log-select-mode
	      magit-popup-mode magit-popup-sequence-mode
	      magit-process-mode magit-reflog-mode magit-refs-mode
	      magit-revision-mode magit-stash-mode magit-stashes-mode
	      magit-status-mode mh-folder-mode monky-mode mpuz-mode
	      mu4e-main-mode mu4e-headers-mode mu4e-view-mode
	      notmuch-hello-mode notmuch-search-mode notmuch-show-mode
	      notmuch-tree-mode org-agenda-mode proced-mode rcirc-mode
	      rebase-mode recentf-dialog-mode sldb-mode
	      slime-inspector-mode slime-thread-control-mode
	      slime-xref-mode snake-mode solitaire-mode
	      sr-buttons-mode sr-mode sr-tree-mode sr-virtual-mode
	      tetris-mode tla-annotate-mode tla-archive-list-mode
	      tla-bconfig-mode tla-bookmarks-mode tla-branch-list-mode
	      tla-browse-mode tla-category-list-mode
	      tla-changelog-mode tla-follow-symlinks-mode
	      tla-inventory-file-mode tla-inventory-mode tla-lint-mode
	      tla-logs-mode tla-revision-list-mode tla-revlog-mode
	      tla-tree-lint-mode tla-version-list-mode twittering-mode
	      urlview-mode vc-annotate-mode vc-dir-mode vm-mode
	      vm-summary-mode w3m-mode wab-compilation-mode
	      xgit-annotate-mode xgit-changelog-mode xgit-diff-mode
	      xgit-revlog-mode xhg-annotate-mode xhg-log-mode xhg-mode
	      xhg-mq-mode xhg-mq-sub-mode xhg-status-extra-mode))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(0x0 aas atomic-chrome auctex cape catppuccin-theme cdlatex
	 clang-format doom-themes embark-consult evil-cleverparens
	 evil-collection evil-goggles evil-leader evil-mc
	 evil-surround exec-path-from-shell expand-region
	 gruvbox-theme harpoon hop iedit lsp-pyright lsp-ui marginalia
	 modus-themes orderless org-roam paredit pdf-tools racket-mode
	 treemacs-evil treemacs-icons-dired treemacs-projectile
	 treesit-auto undo-tree vertico vterm yasnippet))
 '(package-vc-selected-packages
   '((pcre :url "https://github.com/syohex/emacs-pcre.git" :branch
	   "master")
     (hop :url "https://github.com/Animeshz/hop.el.git" :branch "main")))
 '(warning-suppress-types '((use-package))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-yank-face ((t (:background "#00afff" :foreground "black")))))

(load-file "~/dotfiles/emacs/.emacs.d/config.el")

