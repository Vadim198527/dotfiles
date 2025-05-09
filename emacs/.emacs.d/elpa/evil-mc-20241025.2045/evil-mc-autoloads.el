;;; evil-mc-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from evil-mc.el

(autoload 'evil-mc-mode "evil-mc" "\
Toggle evil multiple cursors in a single buffer.

This is a minor mode.  If called interactively, toggle the
`Evil-Mc mode' mode.  If the prefix argument is positive, enable
the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `evil-mc-mode'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(put 'global-evil-mc-mode 'globalized-minor-mode t)
(defvar global-evil-mc-mode nil "\
Non-nil if Global Evil-Mc mode is enabled.
See the `global-evil-mc-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-evil-mc-mode'.")
(custom-autoload 'global-evil-mc-mode "evil-mc" nil)
(autoload 'global-evil-mc-mode "evil-mc" "\
Toggle Evil-Mc mode in all buffers.
With prefix ARG, enable Global Evil-Mc mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Evil-Mc mode is enabled in all buffers where `evil-mc-initialize'
would do it.

See `evil-mc-mode' for more information on Evil-Mc mode.

(fn &optional ARG)" t)
(autoload 'evil-mc-initialize "evil-mc" "\
Enable `evil-mc-mode' in the current buffer.")
(autoload 'turn-on-evil-mc-mode "evil-mc" "\
Turn on evil-mc mode in the current buffer." t)
(autoload 'turn-off-evil-mc-mode "evil-mc" "\
Turn off evil-mc mode in the current buffer." t)
(register-definition-prefixes "evil-mc" '("evil-mc-"))


;;; Generated autoloads from evil-mc-command-execute.el

(register-definition-prefixes "evil-mc-command-execute" '("evil-mc-"))


;;; Generated autoloads from evil-mc-command-record.el

(register-definition-prefixes "evil-mc-command-record" '("evil-mc-"))


;;; Generated autoloads from evil-mc-common.el

(register-definition-prefixes "evil-mc-common" '("evil-mc-"))


;;; Generated autoloads from evil-mc-cursor-make.el

(register-definition-prefixes "evil-mc-cursor-make" '("evil-mc-"))


;;; Generated autoloads from evil-mc-cursor-state.el

(register-definition-prefixes "evil-mc-cursor-state" '("evil-mc-"))


;;; Generated autoloads from evil-mc-known-commands.el

(register-definition-prefixes "evil-mc-known-commands" '("evil-mc-known-commands"))


;;; Generated autoloads from evil-mc-region.el

(register-definition-prefixes "evil-mc-region" '("evil-mc-"))


;;; Generated autoloads from evil-mc-scratch.el

(register-definition-prefixes "evil-mc-scratch" '("evil-mc-"))


;;; Generated autoloads from evil-mc-setup.el

(register-definition-prefixes "evil-mc-setup" '("evil-mc-"))


;;; Generated autoloads from evil-mc-undo.el

(register-definition-prefixes "evil-mc-undo" '("evil-mc-"))


;;; Generated autoloads from evil-mc-vars.el

(register-definition-prefixes "evil-mc-vars" '("evil-mc-"))

;;; End of scraped data

(provide 'evil-mc-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; evil-mc-autoloads.el ends here
