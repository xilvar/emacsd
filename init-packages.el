;;; package --- Summary
;;; Commentary:
;;; Code:

(require 'package)

(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

; (add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")


; list the packages you want
(setq package-list
    '(use-package flycheck company web-mode-edit-element elpy yaml-mode web-mode tide scss-mode js2-mode go-mode flycheck-gometalinter diminish
        ))


; activate all the packages
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;; footer
(provide 'init-packages)
;;; init-packages.el ends here