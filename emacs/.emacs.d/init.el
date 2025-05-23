;; Установка и настройка package management
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
;; Установка размера шрифта для HiDPI
;; (set-face-attribute 'default nil :height 200) ;; 200 соответствует 10pt * 20

;; Отключаем центрирование при перемещении вниз экрана
(setq scroll-conservatively 101)

(setq native-comp-async-report-warnings-errors nil)  ;; Отключить все предупреждения
;; Или, чтобы отключить только предупреждения о ширине docstring:
(setq native-comp-warning-on-missing-source nil
      native-comp-warning-on-restriction t
      native-comp-always-compile nil
      native-comp-deferred-compilation nil
      native-comp-async-report-warnings-errors 'silent)

;; Включаем отображение номеров строк
(global-display-line-numbers-mode 1)

;; Установка use-package, если он не установлен
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Включение use-package
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

(desktop-save-mode 1)

;; Автосохранение файлов
(use-package files
  :ensure nil
  :config
  (auto-save-visited-mode 1)
  (setq auto-save-visited-interval 3))

(use-package avy
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal 'global (kbd "C-/") 'avy-goto-char-timer)
    ;; (evil-define-key 'normal 'global (kbd "C-/") 'avy-goto-char)
    )
  )

;; Настройка тем и интерфейса
;; (use-package modus-themes
;;   :init
;;   ;; Настройки перед загрузкой темы
;;   (setq modus-themes-italic-constructs t
;;         modus-themes-bold-constructs nil
;;         modus-themes-to-toggle '(modus-operandi modus-vivendi)
;;         modus-themes-common-palette-overrides
;;         '((bg-mode-line-active bg-sage)
;;           (fg-mode-line-active fg-main)
;;           (border-mode-line-active bg-green-intense)
;;           (bg-tab-bar bg-main)
;;           (bg-tab-current bg-active)
;;           (bg-tab-other bg-dim)
;;           (fringe unspecified)
;;           (underline-link unspecified)
;;           (underline-link-visited unspecified)
;;           (underline-link-symbolic unspecified)
;;           (fg-completion-match-0 blue)
;;           (fg-completion-match-1 magenta-warmer)
;;           (fg-completion-match-2 cyan)
;;           (fg-completion-match-3 red)
;;           (bg-completion-match-0 bg-blue-nuanced)
;;           (bg-completion-match-1 bg-magenta-nuanced)
;;           (bg-completion-match-2 bg-cyan-nuanced)
;;           (bg-completion-match-3 bg-red-nuanced)
;;           (comment yellow-faint)
;;           (string green-warmer)
;;           (prose-done green-faint)
;;           (prose-todo red-faint)))
;;   :config
;;   (load-theme 'modus-operandi :no-confirm)
;;   (define-key global-map (kbd "<f12>") #'modus-themes-toggle))
;; ;; Настройка шрифтов
;; (set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 170)
;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")

;;Gruvbox
;; (use-package gruvbox-theme
;;   :ensure t
;;   :config
;;   (load-theme 'gruvbox-dark-medium t)
;;   (set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 170)
;;   ;; (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160)
;;   )

;; ;; Вариант 2: Использование doom-gruvbox
;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   (load-theme 'doom-gruvbox t)
;;   (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160))

(use-package catppuccin-theme
  :ensure t
  :config
  (setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
  (catppuccin-reload)
  (set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 170)
  ;; (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160)
  )




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

;; ;; Настройка org-modern
;; (use-package org-modern
;;   ;; :hook ((org-mode . org-modern-mode)
;;   ;; (org-agenda-finalize . org-modern-agenda))
;;   )

;; Настройка yasnippet
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; Настройка cdlatex
(use-package cdlatex
  :hook ((LaTeX-mode . turn-on-cdlatex)
         (org-mode . turn-on-org-cdlatex)))

;; Настройка AUCTeX
(use-package tex
  :ensure auctex
  :hook (LaTeX-mode . my-latex-mode-keybindings)
  :config
  (defun my-latex-mode-keybindings ()
    "Custom keybindings for LaTeX mode."
    (local-set-key (kbd "C-c i") 'indent-for-tab-command)))

;; Настройка aas
(use-package aas
  :hook ((LaTeX-mode . aas-activate-for-major-mode)
         (org-mode . aas-activate-for-major-mode)
         (TeX-mode . aas-activate-for-major-mode))
  :config
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
		    ";beg" (lambda ()
			     (interactive)
			     (yas-expand-snippet (yas-lookup-snippet "begin")))
		    ;; Добавьте остальные сниппеты здесь
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

;; Настройка vterm
;; (use-package vterm)

;; Настройка evil-mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-disable-insert-state-bindings t
        evil-want-C-u-scroll t
        evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  (evil-set-leader nil (kbd "SPC"))
  )

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

;; ;; Настройка marginalia
;; (use-package marginalia
;;   :after vertico
;;   :config
;;   (marginalia-mode))

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

;; ;; Настройка projectile
;; (use-package projectile
;;   :config
;;   (projectile-mode 1)
;;   (setq projectile-project-search-path '("~/projects/")))

;; Отключение стартового экрана и звукового сигнала
(setq inhibit-startup-message t)
(setq visible-bell t)

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


(use-package exec-path-from-shell
  :ensure t
  :init
  (exec-path-from-shell-initialize)
  ;; (exec-path-from-shell-copy-env "PATH")
  )

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

  ;; Указываем, что для Python используется pyright
  (setq lsp-pyright-server-type 'pyright) ; Явно указываем pyright
  ;; Отключаем ненужные функции, если хотите
  (setq lsp-enable-file-watchers nil)
  ;; Дополнительные настройки pyright, если нужно
  (setq lsp-pyright-auto-import-completions t)
  (setq lsp-pyright-type-checking-mode "basic") ; "off", "basic", "strict"
  (with-eval-after-load 'lsp-mode
    (lsp-register-client
     (make-lsp-client
      :new-connection (lsp-stdio-connection "pyright")
      :major-modes '(python-mode)
      :server-id 'pyright)))
  
  :config
  ;; Для небольших проектов можно отключить персистентный серверный кэш
  (setq lsp-enable-file-watchers nil)
  ;; (setq lsp-file-watch-threshold 15000)
  ;; (setq lsp-clients-clangd-executable "/usr/bin/clangd")
  ;; Можно настроить логирование или другие параметры через
  ;; (setq lsp-log-io t) для отладки
  )

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package clang-format
  :ensure t
  :bind (:map c-mode-map
	      ("C-c f" . clang-format-region)))

;; (use-package ccls
;;   :ensure t
;;   :config
;;   :hook ((c-mode) .
;;          (lambda () (require 'ccls) (lsp)))
;;   (setq ccls-executable "/usr/local/bin/ccls")
;;   ;; (setq ccls-initialization-options
;; 	;; '(:index (:comments 2) :completion (:detailedLabel t))
;; 	)


(use-package corfu
  :custom
  (corfu-cycle t)	       ;; Циклическая навигация
  (corfu-auto t)	       ;; Включить автоматическое дополнение
  (corfu-auto-prefix 2)	       ;; Показывать после ввода 1 символа
  (corfu-auto-delay 0.0)       ;; Без задержки перед показом
  ;; (corfu-quit-at-boundary nil) ;; Не закрывать на границах
  ;; (corfu-quit-no-match t) ;; Не закрывать, даже если нет совпадений
  ;; (corfu-preview-current -1) ;; Предпросмотр текущего кандидата
  (corfu-preselect 'prompt) ;; Предвыбор подсказки
  :init
  (global-corfu-mode)
  ;; Дополнительные полезные режимы
  (corfu-popupinfo-mode) ;; Показывает дополнительную информацию
  (corfu-history-mode)
  :config
  (keymap-unset corfu-map "TAB")
  )          ;; Сохраняет историю выбора

(use-package cape
  ;; Bind prefix keymap providing all Cape commands under a mnemonic key.
  ;; Press C-c p ? to for help.
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  ;; Alternatively bind Cape commands individually.
  ;; :bind (("C-c p d" . cape-dabbrev)
  ;;        ("C-c p h" . cape-history)
  ;;        ("C-c p f" . cape-file)
  ;;        ...)
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  ;; (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  ;; (add-hook 'completion-at-point-functions #'cape-history)
  ;; ...
  )

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
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>(") 'paredit-wrap-round)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>d(") 'paredit-splice-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>pr") 'paredit-raise-sexp)
  (evil-define-key 'normal paredit-mode-map (kbd "F") 'paredit-forward)
  (evil-define-key 'normal paredit-mode-map (kbd "B") 'paredit-backward)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>bu") 'paredit-backward-up)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>bd") 'paredit-backward-down)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>fu") 'paredit-forward-up)
  (evil-define-key 'normal paredit-mode-map (kbd "<leader>fd") 'paredit-forward-down)
  (evil-define-key 'insert paredit-mode-map (kbd "RET") 'paredit-newline)
  (evil-define-key 'insert paredit-mode-map (kbd "C-k") 'paredit-newline)
  (evil-define-key 'normal racket-repl-mode (kbd "C-h") 'evil-window-left)  
  (evil-define-key 'insert racket-repl-mode (kbd "C-h") 'evil-window-left)  
  (evil-define-key 'insert paredit-mode-map (kbd "C-h") 'paredit-backward-delete))

;; (use-package flycheck
;;   :ensure t
;;   :init (global-flycheck-mode))


(use-package cmuscheme
  :ensure nil               ;; т.к. это встроенный пакет Emacs
  :commands (run-scheme)    ;; автозагрузка при вызове M-x run-scheme
  :config
  ;; Указываем, что основная программа для Scheme — это MIT Scheme
  (setq scheme-program-name "mit-scheme")

  ;; Опционально: если хотите, чтобы при M-x run-scheme создавался
  ;; буфер с именем "MIT Scheme" вместо "*scheme*":
  (setq cmuscheme-name "MIT Scheme"))


;; (use-package multiple-cursors
;;   :config
;;   (global-unset-key (kbd "M-<down-mouse-1>"))
;;   (global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)
;;   (evil-define-key 'normal 'global (kbd "C-n") 'mc/mark-next-like-this)
;;   (setq mc/always-run-for-all t)
;;   ;; (evil-define-key 'normal 'global (kbd "C-n") 'mc/mark-all-like-this)
;;   )

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
    (evil-define-key 'visual evil-mc-key-map (kbd "<leader>cl") #'evil-mc-undo-all-cursors)
    ))

;; Установка через package.el
(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-mode)
  ;; Настройка длительности подсветки (в секундах)
  (setq evil-goggles-duration 0.200)
  ;; Настройка цвета только для операции yank
  (custom-set-faces
   '(evil-goggles-yank-face ((t (:background "#00afff" :foreground "black")))))
  ;; Включение эффекта пульсации
  (setq evil-goggles-pulse t))


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
	      notmuch-tree-mode org-agenda-mode
	      pdf-outline-buffer-mode pdf-view-mode proced-mode
	      rcirc-mode rebase-mode recentf-dialog-mode sldb-mode
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
	      urlview-mode vc-annotate-mode vc-dir-mode
	      vc-hg-log-view-mode vc-svn-log-view-mode vm-mode
	      vm-summary-mode w3m-mode wab-compilation-mode
	      xgit-annotate-mode xgit-changelog-mode xgit-diff-mode
	      xgit-revlog-mode xhg-annotate-mode xhg-log-mode xhg-mode
	      xhg-mq-mode xhg-mq-sub-mode xhg-status-extra-mode))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(aas auctex avy cape catppuccin-theme cdlatex clang-format corfu
	 embark-consult evil-collection evil-goggles evil-mc
	 exec-path-from-shell expand-region iedit lsp-ui marginalia
	 modus-themes orderless org-roam paredit racket-mode vertico
	 yasnippet)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-goggles-yank-face ((t (:background "#00afff" :foreground "black")))))

;; Загрузка внешнего файла конфигурации (если требуется)
;; (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
(load-file "~/dotfiles/emacs/.emacs.d/config.el")
