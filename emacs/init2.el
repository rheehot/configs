;; -*- mode: emacs-lisp; coding: utf-8; -*-

(setq inhibit-startup-screen t)

;;; load-path
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))


;;; l10n, i18n...
;;(set-language-environment 'Korean)
;;(set-language-environment "UTF-8")
(setq default-input-method "korean-hangul")
;;(set-input-method "korean-hangul")
(prefer-coding-system 'utf-8-unix)
;;(utf-translate-cjk-load-tables)
;; (global-set-key [?\S- ] 'toggle-input-method)


;;; tabs & indents
;;(setq tab-width 4 indent-tabs-mode nil)


;;; global-font-lock-mode
;;(global-font-lock-mode 1)


;;; ding-dang!
(setq visible-bell t)

;;; show column-no on modeline
(column-number-mode t)

;;; time/load
(display-time-mode -1)

;;; show matching parent?
(show-paren-mode t)


;;; visible mark region
(transient-mark-mode t)

;;; interactive-search
;;(isearch-mode 1)

;;; interactive-completion
;;(icomplete-mode t)

;;; interactive-switch-buffer
;;(iswitchb-mode t)

;;; ido-mode
;;(require 'ido)
;;(ido-mode t)

;;; no backup files
(setq-default make-backup-files nil)
(setq-default version-control nil) ; backup uses version numbers?


;;; auto-revert
;; STOP: (global-auto-revert-mode t)
;;  -- Symbol's value as variable is void: \300



;;; 
(setq-default dired-dwim-target t)


;;; menu-bar -- turn-off when '-nw'
(if window-system
    (progn
      ;;(tabbar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1))
  (progn
    (menu-bar-mode -1)))


;;; indents, spaces, tabs...
(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 4)

;;; fill, wrap, truncates
;;(setq-default fill-column 72)
(setq truncate-lines nil)
;;(setq truncate-partial-width-windows nil)



;;; user?
(setq-default user-full-name "Jong-Hyouk Yun")
(setq-default user-mail-address "ageldama@gmail.com")


;;; grep-find, rgrep, find-grep-dired
;;(setq find-program "c:/cygwin/bin/find.exe")






;; cc-mode
;; (setq c-default-style "java")
;; (setq c-basic-offset 4)


;;; emacs-lisp-mode
;;(setq lisp-indent-offset 2)


;;; org-mode
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(add-hook 'org-mode-hook
          (lambda ()
            (set-face-attribute 'italic nil
                                :inherit 'underline)))





;;; lusty-explorer
(when nil
  (when (require 'lusty-explorer nil 'noerror)
    ;; overrride the normal file-opening, buffer switching
    (global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
    (global-set-key (kbd "C-x b")   'lusty-buffer-explorer)))


;;; for Netbooks
(unless (string-equal system-type "darwin")
  (display-battery-mode))




;;; gui-fonts
(when (and t window-system)
  (cond ((or (string-equal system-type "gnu/linux")
             (string-equal system-type "darwin"))
         (progn
           (set-face-attribute 'default nil
                               :font "Noto Sans Mono CJK KR" 
                               ;; :font "Inconsolata"
                               ;; :font "MMCedar"
                               ;; :font "Fantasque Sans Mono"
                               ;; :font "Hack"
                               ;; :font "Fira Code Light"                               
                               )
           ;; Inconsolata, EnvyCodeR, Consolas, Inconsolatazi4
           (let (
                 ;;(font-name "LexiSaebomR")
                 ;; (font-name "NanumBarunGothic")
                 ;;(font-name "Noto Sans Mono CJK KR")
                 ;;(font-name "JejuMyeongjo")
                 ;;(font-name "D2Coding")
                 ;;(font-name "나눔명조")
                 (font-name "Noto Sans Mono CJK KR")
                 ;;(font-name "본고딕 Normal")
                 (font-name "아리따L")
                 )
             (set-fontset-font "fontset-default" '(#x1100 . #xffdc) (cons font-name "unicode-bmp"))
             (set-fontset-font "fontset-default" '(#xe0bc . #xf66e) (cons font-name "unicode-bmp")))))
        ((string-equal system-type "darwin")
         (set-face-attribute 'default nil :family "Andale Mono" :height 135 :weight 'normal))
        ((string-equal system-type "windows-nt")
         (set-face-attribute 'default nil :font "Consolas-11"))
        (t :unknown)))

;;; 한글 예시. Ll1| 0Oo@ [] {} 아침 일찍 구름 낀 백제성을 떠나.
;;; NOTE: 화면이 C-p, C-n 등이 느리면 /D2Coding/, 괜찮으면 /Noto Sans Mono CJK/


(menu-bar-mode -1)
(display-time-mode -1)




(require 'package)
(dolist (i '(("elpa" . "http://elpa.gnu.org/packages/")
             ("melpa" . "http://melpa.milkbox.net/packages/")
             ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives i))
(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))



;; (when (and window-system
;;            (string-equal system-type "gnu/linux"))
;;   ;;(load-theme 'alect-light)
;;   ;;(load-theme 'solarized 1)
;;   ;;(load-theme 'leuven)
;;   )


(unless window-system
  (progn
    (require 'w3m-load nil t)
    (when (fboundp 'w3m-browse-url)
      (setq browse-url-browser-function #'w3m-browse-url))))




;;(load "~/local/io-mode/io-mode.el")



(require 'cl)

(defun en-date-time ()
  (cl-flet ((en-week-day-name (n)
                              (let* ((a '((0 . "Sun") (1 . "Mon") 
                                          (2 . "Tue") (3 . "Wed")
                                          (4 . "Thu") (5 . "Fri") 
                                          (6 . "Sat")))
                                     (i (assoc n a)))
                                (cdr i)))
            (en-month-name (n)
                           (let* ((a '((1 . "Jan") (2 . "Feb") 
                                       (3 . "Mar") (4 . "Apr")
                                       (5 . "May") (6 . "Jun") 
                                       (7 . "Jul") (8 . "Aug")
                                       (9 . "Sep") (10 . "Oct") 
                                       (11 . "Nov") (12 . "Dec")))
                                  (i (assoc n a)))
                             (cdr i))))
    (let* ((year (format-time-string "%Y"))
           (month-num (string-to-number (format-time-string "%m")))
           (month-name (en-month-name month-num))
           (day (format-time-string "%d"))
           (day-of-week-num (string-to-number (format-time-string "%w")))
           (day-of-week-name (en-week-day-name day-of-week-num))
           (date-str (format "%s/%s/%s/%s" year month-name day day-of-week-name)))
      date-str)))


(defun insert-markdown-journal-header ()
  (interactive)
  (progn
    (markdown-mode)
    (insert (format "-*- mode: markdown; coding: utf-8; -*-\n\n# %s" (en-date-time)))))

(defun insert-org-journal-header ()
  (interactive)
  (progn
    (org-mode)
    (insert (format "# -*- mode: org; coding: utf-8; -*-\n\n#+TITLE: %s" (en-date-time)))))










;;; https://github.com/jwiegley/use-package
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/use-package"))
;;(load-library "use-package")


(use-package neotree :ensure t :pin melpa)
(use-package magit :ensure t)
(use-package markdown-mode :ensure t :pin melpa)
(use-package helm :ensure t :pin melpa)
(use-package unfill :ensure t :pin melpa)
;; (use-package centered-window-mode :ensure t :pin melpa)
(use-package projectile :pin melpa)
(use-package helm-projectile :ensure t :pin melpa)
(use-package helm-ag :ensure t :pin melpa)

(use-package ace-window :ensure t :pin melpa)
(global-set-key (kbd "M-p") 'ace-window)
(add-hook 'markdown-mode-hook
          (lambda ()
            (local-set-key (kbd "C-x o") 'ace-window)))


(when t
  (use-package elpy :ensure t :pin melpa)  
  (use-package jedi :ensure t :pin melpa)
  (use-package pylint :ensure t :pin melpa)
  ;; (when (= 0 (shell-command "/usr/local/bin/python3 -m jedi"))
  ;;   (jedi:install-server))
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)                 ; optional
  (if (string-equal system-type "darwin")
      (progn
        ;;(setq elpy-rpc-backend "jedi")
        ;;(setq elpy-rpc-python-command "/usr/local/bin/python3")
        ;;(setq python-check-command "/usr/local/bin/flake8")
        ;;(elpy-use-ipython "/usr/local/bin/ipython3")
        ;(elpy-use-ipython)
        )
    (progn
      ;(elpy-use-ipython)
      ))
  ;;(setq python-shell-interpreter "ipython"
  ;;      python-shell-interpreter-args "--simple-prompt --pprint")  
  (elpy-enable)
  (add-hook 'python-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq tab-width 4)
              (setq python-indent 4)))
  (require 'ob-python))




(when nil
  (use-package cmake-mode :ensure t :pin melpa)  
  (use-package rtags :ensure t :pin melpa)
  (use-package cmake-ide :ensure t :pin melpa)
  (when (string-equal system-type "darwin")
    (setq rtags-path "/usr/local/bin/"))
  (require 'rtags) ;; optional, must have rtags installed
  ;;(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
  ;;(add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running)
  (when (string-equal system-type "darwin")
    (progn
      (setq cmake-ide-rdm-executable "/usr/local/bin/rdm")
      (setq cmake-ide-rc-executable "/usr/local/bin/rc")
      (setq cmake-ide-cmake-command "/usr/local/bin/cmake")))
  (cmake-ide-setup)
)

(use-package flycheck :ensure t :pin melpa)
(global-flycheck-mode)

(use-package company :ensure t :pin melpa)
(when (string-equal system-type "darwin")
  (setq company-clang-executable "/usr/bin/clang"))
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(setq company-backends (delete 'company-semantic company-backends))

(when (boundp 'c-mode-map)
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))





(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell :ensure t :pin melpa)
  (exec-path-from-shell-initialize))



(require 'helm-config)
(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)





;;; helm-projectile.
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)



;;; powerline.
(when t
  (use-package powerline :ensure t :pin melpa)
  (use-package airline-themes :ensure t :pin melpa)
  ;;(require 'powerline)
  ;;(require 'airline-themes)
  ;;(airline-themes-solarized-gui)
  ;;(load-theme 'airline-light t)
  ;;(load-theme 'airline-distinguished t)
  )



(when (and t window-system)
  ;;(use-package rebecca-theme :ensure t :pin melpa)
  ;;(load-theme #'rebecca t)
  ;;(load-theme 'deeper-blue)
  (use-package leuven-theme :ensure t :pin melpa)
  (load-theme #'leuven t)
  )

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)





;;; go-lang.
(when nil
  (use-package go-mode :ensure t :pin melpa)
  (when (and (fboundp 'go-mode) (memq window-system '(mac ns)))
    (use-package exec-path-from-shell :ensure t :pin melpa)
    (exec-path-from-shell-copy-env "GOROOT")
    (exec-path-from-shell-copy-env "GOPATH"))
  (use-package go-eldoc :ensure t :pin melpa)
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  (use-package go-autocomplete :ensure t :pin melpa)
  (require 'go-autocomplete)
  (require 'auto-complete-config)
  (ac-config-default)
  (use-package golint :ensure t :pin melpa)
  (use-package go-projectile :ensure t :pin melpa)
  )



;;; Clojure.
(when nil
  (use-package cider :ensure t :pin melpa)
  (use-package helm-cider :ensure t :pin melpa)
  (helm-cider-mode 1)
  (use-package yaml-mode  :ensure t :pin melpa)
  )


(use-package rainbow-delimiters  :ensure t :pin melpa)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)



;;;
(use-package which-key
	:ensure t 
	:config
	(which-key-mode))


;;;
(use-package evil :ensure t :pin melpa)
(use-package evil-vimish-fold :ensure t :pin melpa)

(evil-mode -1)
(global-set-key (kbd "C-<f12>") 'evil-local-mode)
(add-to-list 'evil-emacs-state-modes 'neotree-mode)
(evil-vimish-fold-mode 1)

(global-linum-mode -1)

;;; for magit, ...
(setenv "EDITOR" "emacsclient")



(defun open-my-scratch-org-file ()
  (interactive)
  (find-file (expand-file-name "~/Dropbox/w/Scratch.txt")))






;;;EOF.
