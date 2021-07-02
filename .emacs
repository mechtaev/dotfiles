;;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)

(setq-default tab-width 2)
(menu-bar-mode -1)
(show-paren-mode 1)
(column-number-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq package-list
      '(markdown-mode
	gitconfig-mode
	gitignore-mode
	json-mode
	eglot
	company
	))

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; Latex

(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'flyspell-buffer)

; VC

; may be very slow inside git repos
; (remove-hook 'find-file-hooks 'vc-find-file-hook)

; Ido

(require 'ido)
(ido-mode t)
(ido-everywhere t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rust-mode company eglot json-mode gitignore-mode gitconfig-mode markdown-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
