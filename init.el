;;; package --- Summary
;;; Commentary:
;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/.emacs.d/init-packages")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; fix auto-save/backup files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; disable auto-save/backup
(setq auto-save-default nil)
(setq make-backup-files nil)

;; remove whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  (setq-default flycheck-flake8-maximum-line-length 79)
  )

; (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

;; disable tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Text-mode
(add-hook 'text-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 4)

             ))
;; (setq indent-line-function (quote insert-tab))
;; (electric-indent-mode -1)

;; Tide-mode setup
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; Configure web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js.?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts.?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.s?css\\'" . web-mode))
(defun my-web-mode-hooks ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq-default indent-tabs-mode nil)
  (setq web-mode-enable-auto-quoting nil)
  (when (string-equal "tsx" (file-name-extension buffer-file-name))
    (setup-tide-mode))
  (when (string-equal "ts" (file-name-extension buffer-file-name))
    (setup-tide-mode)))
(add-hook 'web-mode-hook 'my-web-mode-hooks)

;; Configure flycheck
(require 'flycheck)
(flycheck-add-mode 'typescript-tslint 'web-mode)

;;; footer
(provide 'init)
;;; init.el ends here
