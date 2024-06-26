(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t (:background "cornsilk")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(package-selected-packages
   '(xclip gptel markdown-mode json-mode json-reformat rust-mode yaml-mode dockerfile-mode))
 '(tool-bar-mode nil))


(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(menu-bar-mode -1)
;; (scroll-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq ring-bell-function 'ignore)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package dockerfile-mode :ensure t)
(use-package yaml-mode :ensure t)
(use-package rust-mode :ensure t)
(use-package json-reformat :ensure t)
(use-package json-mode :ensure t)
(use-package markdown-mode :ensure t)
(use-package gptel :ensure t)
(use-package xclip :ensure t)

; Latex
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'flyspell-buffer)
(setq tex-fontify-script nil)

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

(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

(xclip-mode 1)

;; ChatGPT

(setq gptel-api-key (getenv "OPENAI_API_KEY"))
(global-set-key (kbd "C-c C-g") 'gptel-send)
