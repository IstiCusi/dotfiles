;; --------------------------------------------------------------------------
;; Done by Stephan Strauss 2022 ; the first time running, that will give some
;; warning and error messages ... they are gone after the installation
;; of some packages.
;; --------------------------------------------------------------------------

;; ==========================================================================
;; ======================= Fix for ubuntu 14.04  ============================
;; ==========================================================================

;;(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.0")

;; ==========================================================================
;; ======================= Changed key bindings  ============================
;; ==========================================================================

;; Esc quit prompts (as ctrl-g did)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; ==========================================================================
;; ====================== Standard emacs settings ===========================
;; ==========================================================================

(setq backup-directory-alist '(("." . "~/.emacs_saves")))

(setq x-select-enable-clipboard t)    ; Copy from linux buffer

(setq c-default-style "linux"
      c-basic-offset 4)

(setq visible-bell t)                 ; visible bell
(column-number-mode)
(global-display-line-numbers-mode t)  ; line numbering
(show-paren-mode)

(ido-mode 1)

;; Core simplifications

(setq inhibit-startup-message t)

(scroll-bar-mode -1)                  ; Disable visible scrollbar
(tool-bar-mode -1)                    ; Disable the toolbar
(tooltip-mode -1)                     ; Disable tooltips
(set-fringe-mode 10)                  ; Give some breathing room
(menu-bar-mode -1)                    ; Disable the menu bar

;; Font settings

(defvar efs/default-font-size 180)
(defvar efs/default-variable-font-size 180)
(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height efs/default-font-size)
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font" :height efs/default-font-size)

;; Transparent window

(defvar efs/frame-transparency '(97 . 97))
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Styling ;-)

(set-background-color "#FFF6FD")                       ;; Bground color
(set-cursor-color "#ff0000")                           ;; Cursor color
(set-face-attribute 'region nil :background "#D2FFC7") ;; Selection color

;; ==========================================================================
;; ======================== emacs Package install ===========================
;; ==========================================================================

(require 'package)

(add-to-list 'package-archives
            '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq package-list
      '(
	use-package

	helm-smex

	company
	company-ctags
	company-irony
	company-irony-c-headers
	company-anaconda recentf evil

	key-chord

	evil-leader
	evil-nerd-commenter
	evil-multiedit

	rust-mode

	))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; ==========================================================================
;; ======================== emacs package configurations ====================
;; ==========================================================================

;; ----------  Smex configuration for M-x autocompletion --------------------

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; -------------  Company mode for syntax completion ------------------------ 

;; Tab for possible choice ; select in list and press F1 for documentation

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(use-package anaconda-mode
  :ensure t
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  ;;(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  )

(use-package company-anaconda
  :ensure t
  :init (require 'rx)
  :after (company)
  :config
  (add-to-list 'company-backends 'company-anaconda)
  )

(use-package company-quickhelp
  ;; Quickhelp may incorrectly place tooltip towards end of buffer
  ;; See: https://github.com/expez/company-quickhelp/issues/72
  :ensure t
  :config
  (company-quickhelp-mode)
  )



(add-hook 'after-init-hook 'global-company-mode)

;; ----------------- evil mode ---------------------------------------------

(use-package evil
 :ensure t
 :config
 (evil-mode 1)
 ;; (define-key evil-insert-state-map "jj" 'evil-normal-state)
 (global-evil-leader-mode)
 (evil-leader/set-leader ",")
 (evilnc-default-hotkeys nil t)
 (evil-leader/set-key
   "e" 'find-file
   "b" 'switch-to-buffer
   "m" 'manual-entry
   "k" 'kill-buffer
    ;; "cs" 'evilnc-comment-or-uncomment-lines0
   )
 )

(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)


;; ------------ recent files loaded -----------------------------------------

;;(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-mode evil-nerd-commenter company-quickhelp company-c-headers use-package ivy-rich ivy-prescient helm-smex counsel company-irony-c-headers company-irony company-ctags company-anaconda auto-package-update)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; --------------------------Multiedit---------------------------------------

;; TODO 

(use-package evil-multiedit
  :ensure t
  :config
  (evil-multiedit-default-keybinds)
)



;; ---------------------------- Man pages -----------------------------------

(setq Man-notify-method 'newframe)

;; ------------------------ Commenting as in vim ----------------------------

(evilnc-default-hotkeys nil t)


;; ---------------------- ctags for finding definitions ---------------------

(setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here
  (defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

;; ---------------------- External terminal open up -------------------------

(defun run-gnome-terminal-here ()
  (interactive "@")
  (shell-command (concat "konsole --workdir"
            (file-name-directory (or load-file-name buffer-file-name)) 
              " > /dev/null 2>&1 & disown") nil nil))


;; --------------------- My user functions defined --------------------------

(defun line ()
  (insert "//------------------------------------"
	  "--------------------------------------")
  )

;; **** This for some reason does not work  --- why ? ****

;; (add-hook 'c-mode-hook
;; 	  (lambda()
;; 	    (local-set-key (kbd "<C-tab>") 'line))
;; 	  )

(add-hook 'server-switch-hook #'raise-frame)
