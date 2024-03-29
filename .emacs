(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(package-selected-packages
   '(yaml-mode rust-mode ron-mode marginalia magit json-reformat json-mode gitignore-mode gitconfig-mode eglot dockerfile-mode))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)

(setq-default tab-width 2)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq ring-bell-function 'ignore)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq package-list
      '(markdown-mode
	      gitconfig-mode
	      gitignore-mode
	      json-mode
        json-reformat
        rust-mode
        dockerfile-mode
        eglot
        yaml-mode))

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

;; VC

; may be very slow inside git repos
(remove-hook 'find-file-hooks 'vc-find-file-hook)

;; Prolog

(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
                                ("\\.dl$" . prolog-mode))
                                auto-mode-alist))

;; Don't kill buffers opened with client:
(setq server-kill-new-buffers nil)

;; eglot

; disable annoying parts:
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider))
(setq eldoc-echo-area-use-multiline-p nil) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
