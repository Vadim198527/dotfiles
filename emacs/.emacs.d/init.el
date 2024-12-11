;; Установка и настройка package management
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
;; Установка размера шрифта для HiDPI
;; (set-face-attribute 'default nil :height 200) ;; 200 соответствует 10pt * 20

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
(set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 170)
(set-face-attribute 'variable-pitch nil :family "Iosevka Aile")

;; ;; ;;Gruvbox
;; ;; (use-package gruvbox-theme
;; ;;   :ensure t
;; ;;   :config
;; ;; (load-theme 'gruvbox-dark-medium t)
;; ;; (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160))
;;
;; ;; ;; Вариант 2: Использование doom-gruvbox
;; ;; (use-package doom-themes
;; ;;   :ensure t
;; ;;   :config
;; ;;   (load-theme 'doom-gruvbox t)
;; ;;   (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160))
;;
;; ;; (use-package catppuccin-theme
;; ;;   :ensure t
;; ;;   :config
;; ;;   (setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
;; ;;   (catppuccin-reload)
;; ;;   (set-face-attribute 'default nil :family "JetBrainsMonoNL Nerd Font Mono" :height 160))


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
  (evil-set-leader nil (kbd "SPC")))

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
  :init
  (setq vertico-cycle t
        vertico-resize nil)
  :config
  (vertico-mode 1))

;; Настройка orderless
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
;; Настройка marginalia
(use-package marginalia
  :config
  (marginalia-mode))

;; Настройка consult
(use-package consult
  :ensure t
  :after recentf
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("C-c f" . consult-find)
         ("C-c g" . consult-grep)
         ("M-y" . consult-yank-pop))
  :config
  (setq consult-project-root-function #'projectile-project-root)
  (evil-define-key 'normal 'global (kbd "<leader>,") 'consult-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>fg") 'consult-grep)
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'consult-recent-file)
  (evil-define-key 'normal 'global (kbd "<leader>oa") 'org-agenda))

;; Настройка embark и embark-consult
(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim))
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

;; Настройка projectile
(use-package projectile
  :config
  (projectile-mode 1)
  (setq projectile-project-search-path '("~/projects/")))

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

;; Загрузка внешнего файла конфигурации (если требуется)
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :init
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PATH"))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((python-mode . lsp-deferred)) ; запуск lsp при открытии python-файлов
  :init
  ;; Настройки, опционально
  (setq lsp-keymap-prefix "C-c l") ; быстрый доступ к командам lsp
  :config
  ;; Для небольших проектов можно отключить персистентный серверный кэш
  (setq lsp-enable-file-watchers nil)
  ;; Можно настроить логирование или другие параметры через
  ;; (setq lsp-log-io t) для отладки
  )
(use-package elpy
  :ensure t
  :defer t
  :init
  (elpy-enable)
  :bind
  (:map elpy-mode-map
	("C-c C-c" . elpy-shell-send-region-or-buffer)   ; запуск региона или всего буфера
	("C-c C-r" . elpy-shell-send-region)             ; запуск только выделенного региона
	("C-c C-z" . elpy-shell-switch-to-shell))        ; переключение в Python shell
  :config
  (setq python-shell-interpreter "python3"
	python-shell-interpreter-args "-i"
	python-shell-completion-native-enable nil  ; отключаем native completion
	python-shell-completion-native-disabled-interpreters '("python3"))
  ;; Используйте следующую строку, если предпочитаете IPython
  ;; (setq python-shell-interpreter "ipython"
  ;;       python-shell-interpreter-args "-i --simple-prompt")
  
  ;; Опционально: настройка форматирования с помощью black
  (add-hook 'elpy-mode-hook
	    (lambda ()
	      (add-hook 'before-save-hook
			'elpy-black-fix-code nil t)))
  
  ;; Опционально: использование flycheck вместо flymake
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))



;; ;; Вариант 2: Corfu вместо Company (более современный подход)
;; ;; Для corfu потребуется Emacs 28+ или установка corfu из ELPA/MELPA
;; (use-package corfu
;;   :init
;;   (global-corfu-mode)
;;   :config
;;   (setq corfu-auto t
;; 	corfu-auto-delay 0
;; 	corfu-auto-prefix 1
;; 	corfu-quit-no-match 'separator))


;; Дополнительно: lsp-ui для красивых всплывающих подсказок и отображения информации
(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :hook ((lsp-mode . lsp-ui-mode))
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-sideline-enable t
        lsp-ui-peek-enable t)
  )

;; Company - глобальный режим автодополнения
(use-package company
  :init
  (global-company-mode)
  :config
  ;; Настройки удобства: например, таймауты, минимальная длина префикса
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1))

;; (use-package slime
;;   :config
;;   (setq inferior-lisp-program "sbcl") ; Укажите ваш Lisp (sbcl, ccl и т.д.)
;;   (slime-setup '(slime-fancy))
;;   ;; Подключаем slime-company для автодополнения
;;   (use-package slime-company
;;     :after (slime company)
;;     :config
;;     ;; Опциональные настройки
;;     (setq slime-company-completion 'fuzzy
;;           slime-company-after-completion 'slime-company-just-one-space)
;;     (add-hook 'slime-mode-hook #'company-mode)
;;     (add-hook 'slime-repl-mode-hook #'company-mode)))

(use-package sly
  :ensure t
  :config
  ;; По умолчанию использовать SBCL
  (setq inferior-lisp-program "sbcl")
  ;; Включаем fancy режим для документации
  (setq sly-complete-symbol-function 'sly-flex-completions)
  ;; Добавляем хуки для включения документации
  (add-hook 'sly-mode-hook 'company-mode)
  (add-hook 'sly-mrepl-mode-hook 'company-mode)
  ;; Настраиваем отображение документации
  ;; (setq sly-autodoc-use-multiline t)
  ;; (setq sly-description-autofocus t)
  )

;; ;; Добавляем company-quickhelp для отображения документации во всплывающих окнах
;; (use-package company-quickhelp
;;   :ensure t
;;   :after company
;;   :config
;;   (company-quickhelp-mode 1)
;;   (setq company-quickhelp-delay 0.5))

;; Удобное редактирование Lisp-кода (структурное редактирование)
(use-package paredit
  :hook ((lisp-mode . paredit-mode)
	 (slime-repl-mode . paredit-mode)
	 (emacs-lisp-mode . paredit-mode)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("99d1e29934b9e712651d29735dd8dcd431a651dfbe039df158aa973461af003e" "0517759e6b71f4ad76d8d38b69c51a5c2f7196675d202e3c2507124980c3c2a3" "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2" "e410458d3e769c33e0865971deb6e8422457fad02bf51f7862fa180ccc42c032" "48042425e84cd92184837e01d0b4fe9f912d875c43021c3bcb7eeb51f1be5710" "3f1dcd824a683e0ab194b3a1daac18a923eed4dba5269eecb050c718ab4d5a26" "8ccbbbf5c197f80c9dce116408a248fde1ac4fedd9b5b7883e729eba83c9c64e" default))
 '(evil-emacs-state-modes
   '(5x5-mode bbdb-mode biblio-selection-mode blackbox-mode bookmark-edit-annotation-mode browse-kill-ring-mode bs-mode bubbles-mode bzr-annotate-mode calc-mode cfw:calendar-mode completion-list-mode custom-theme-choose-mode delicious-search-mode desktop-menu-blist-mode desktop-menu-mode dun-mode dvc-bookmarks-mode dvc-diff-mode dvc-info-buffer-mode dvc-log-buffer-mode dvc-revlist-mode dvc-revlog-mode dvc-status-mode dvc-tips-mode ediff-mode ediff-meta-mode efs-mode Electric-buffer-menu-mode emms-browser-mode emms-mark-mode emms-metaplaylist-mode emms-playlist-mode ess-help-mode etags-select-mode fj-mode gc-issues-mode gdb-breakpoints-mode gdb-disassembly-mode gdb-frames-mode gdb-locals-mode gdb-memory-mode gdb-registers-mode gdb-threads-mode gist-list-mode git-rebase-mode gomoku-mode google-maps-static-mode jde-javadoc-checker-report-mode magit-cherry-mode magit-diff-mode magit-log-mode magit-log-select-mode magit-popup-mode magit-popup-sequence-mode magit-process-mode magit-reflog-mode magit-refs-mode magit-revision-mode magit-stash-mode magit-stashes-mode magit-status-mode mh-folder-mode monky-mode mpuz-mode mu4e-main-mode mu4e-headers-mode mu4e-view-mode notmuch-hello-mode notmuch-search-mode notmuch-show-mode notmuch-tree-mode org-agenda-mode pdf-outline-buffer-mode pdf-view-mode proced-mode rcirc-mode rebase-mode recentf-dialog-mode sldb-mode slime-inspector-mode slime-thread-control-mode slime-xref-mode snake-mode solitaire-mode sr-buttons-mode sr-mode sr-tree-mode sr-virtual-mode tetris-mode tla-annotate-mode tla-archive-list-mode tla-bconfig-mode tla-bookmarks-mode tla-branch-list-mode tla-browse-mode tla-category-list-mode tla-changelog-mode tla-follow-symlinks-mode tla-inventory-file-mode tla-inventory-mode tla-lint-mode tla-logs-mode tla-revision-list-mode tla-revlog-mode tla-tree-lint-mode tla-version-list-mode twittering-mode urlview-mode vc-annotate-mode vc-dir-mode vc-hg-log-view-mode vc-svn-log-view-mode vm-mode vm-summary-mode w3m-mode wab-compilation-mode xgit-annotate-mode xgit-changelog-mode xgit-diff-mode xgit-revlog-mode xhg-annotate-mode xhg-log-mode xhg-mode xhg-mq-mode xhg-mq-sub-mode xhg-status-extra-mode))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(which-key dap-mode gruvbox gruvbox-theme true vterm zenburn-theme wfnames vimish-fold vertico undo-tree undo-fu tree-sitter-langs quelpa projectile pdf-tools page-break-lines org-super-agenda org-roam org-modern org-bullets orderless nerd-icons multiple-cursors modus-themes minimap math-preview marginalia lorem-ipsum latex-preview-pane key-chord jetbrains-darcula-theme flycheck expand-region evil-collection epc embark-consult elpy doom-themes doom dashboard darcula-theme cdlatex catppuccin-theme blacken avy auto-complete auctex async all-the-icons ace-jump-mode aas)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
