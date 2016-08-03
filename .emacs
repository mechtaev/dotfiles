(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(mail-host-address "comp.nus.edu.sg")
 '(package-archives
   (quote
    (("melpa" . "http://melpa.milkbox.net/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(python-shell-interpreter "python3")
 '(show-paren-mode t)
 '(tab-width 2)
 '(user-full-name "Sergey Mechtaev")
 '(user-mail-address "mechtaev@comp.nus.edu.sg"))

(require 'cl)
(require 'package)

(package-initialize)

(defvar seryozha-packages
  '(
;    jedi
;    jedi-direx
;    direx
;    paredit
;    ess
;    geiser
    haskell-mode
    markdown-mode
    tuareg
    gitconfig-mode
    gitignore-mode
    expand-region
    smex
    json-mode
    flycheck
    )
  "A list of packages to ensure are installed at launch.")

(defun seryozha-packages-installed-p ()
  "Check if all packages in `seryozha-packages' are installed."
  (every #'package-installed-p seryozha-packages))

(defun seryozha-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (package-installed-p package)
    (package-install package)))

(defun seryozha-require-packages (packages)
  "Ensure PACKAGES are installed. Missing packages are installed automatically."
  (mapc #'seryozha-require-package packages))

(defun seryozha-install-packages ()
  "Install all packages listed in `seryozha-packages'."
  (unless (seryozha-packages-installed-p)
    ;; check for new packages (package versions)
    (package-refresh-contents)
    ;; install the missing packages
    (seryozha-require-packages seryozha-packages)))

(seryozha-install-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(menu-bar-mode -1)
;(scroll-bar-mode -1)

(setq initial-scratch-message "")
(setq inhibit-startup-screen t)

(column-number-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" mode-name ":  "(:eval (if (buffer-file-name)
                                     (abbreviate-file-name (buffer-file-name))
                                   "%b"))))

(setq linum-format " %5i ")

(setq uniquify-buffer-name-style 'post-forward)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Smex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; This is your old M-x.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Expand-region
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Flycheck
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; flycheck on demand
(global-set-key (kbd "<f10>") 
                (lambda ()
                  (interactive) 
                  (flycheck-mode (if (and (boundp 'flycheck-mode) flycheck-mode) -1 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'org-mode-hook
         (lambda ()
           (org-indent-mode t)
           (visual-line-mode t))
         t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Perl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; this I needed for SemFix:
;; (add-hook 'perl-mode-hook
;;          (lambda ()
;;            (setq indent-tabs-mode t))
;;          t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'latex-mode-hook 'flyspell-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key [(control h)] 'delete-backward-char)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; VC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(remove-hook 'find-file-hooks 'vc-find-file-hook) ; otherwise very slow inside git repos



(server-mode 1)
