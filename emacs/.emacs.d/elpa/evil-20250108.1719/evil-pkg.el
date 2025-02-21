;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "evil" "20250108.1719"
  "Extensible vi layer."
  '((emacs    "24.1")
    (cl-lib   "0.5")
    (goto-chg "1.6")
    (nadvice  "0.3"))
  :url "https://github.com/emacs-evil/evil"
  :commit "6bed0e58dbafd75755c223a5c07aacd479386568"
  :revdesc "6bed0e58dbaf"
  :keywords '("emulations")
  :maintainers '(("Tom Dalziel" . "tom.dalziel@gmail.com")))
