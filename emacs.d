(require 'package)

;;---------------------------------------------------------------------------------------------
;; PACKAGE CONFIGURATION
;;

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" .  "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Reload packages if needed
(when (not package-archive-contents) (package-refresh-contents))

;;---------------------------------------------------------------------------------------------
;; PATHS
;;
(setq load-path (cons "~/Library/Emacs" load-path))
(setq load-path  (append (list "~/.emacs.d" "~/Library/elisp")  load-path))
;;---------------------------------------------------------------------------------------------
;; DISPLAY CONFIGURATION.
;;

(setq-default indent-tabs-mode nil)
(set-background-color "LightGoldenrodYellow")
(set-background-color "LightYellow")
(set-foreground-color "black")


;; Good font options:
;; "-sony-*-*-*-*-*-*-150-75-75-*-*-*-*"
;; "-b&h-lucidatypewriter-medium-r-*-*-12-*-*-*-*-*-*-*"
;; "-*-Inconsolata-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1"
;; "-apple-Droid_Sans_Mono-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1"

(set-default-font "-*-Inconsolata-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(set-face-attribute 'default nil :height 180)

;; Turn off annoying gui things.
(tool-bar-mode -1)
(menu-bar-mode -1)



;;---------------------------------------------------------------------------------------------
;; Packages to install
;;

(unless (package-installed-p 'coffee-mode) (package-install 'coffee-mode))
(unless (package-installed-p 'cider) (package-install 'cider))
(unless (package-installed-p 'swift-mode) (package-install 'swift-mode))
(unless (package-installed-p 'csv-nav) (package-install 'csv-nav))
(unless (package-installed-p 'ensime) (package-install 'ensime))
(unless (package-installed-p 'jdee) (package-install 'jdee))
(unless (package-installed-p 'exec-path-from-shell) (package-install 'exec-path-from-shell))
(unless (package-installed-p 'scala-mode2) (package-install 'scala-mode2))
(unless (package-installed-p 'auto-complete) (package-install 'auto-complete))

;;---------------------------------------------------------------------------------------------
;; Autoloading packages depending upon file mode
;;

(autoload 'javascript-mode "javascript" nil t)
(autoload 'coffee-mode "coffee-mode" nil t)
(autoload 'clojure-mode "clojure-mode" nil t)
(autoload 'jade-mode "jade-mode" nil t)
(autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
(autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
(autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
(autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)
(autoload 'cflow-mode "clfow")
(autoload 'jde-mode "jde" "JDE mode" t)
(autoload 'csv-nav-mode "csv-nav" "CSV mode" t)



;;---------------------------------------------------------------------------------------------
;; Simple mode hooks.
;;

(add-hook 'c-mode-hook '(lambda () (font-lock-mode)))
(add-hook 'js-mode-hook 'my-javascript-mode-hook)
(add-hook 'css-mode-hook 'my-css-mode-hook)
(add-hook 'lisp-mode-hook '(lambda () (require 'ilisp)))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (set-language-environment "utf-8")
             (local-set-key "\M-\C-x" 'scheme-send-definition)
             (font-lock-mode)))
(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)
(add-hook 'html-mode-hook 'my-html-mode-hook)
(add-hook 'scala-mode-hook '(lambda ()
                              (require 'whitespace)

                              ;; clean-up whitespace at save
                              (make-local-variable 'before-save-hook)
                              (add-hook 'before-save-hook 'whitespace-cleanup)

                              ;; turn on highlight. To configure what is highlighted, customize
                              ;; the *whitespace-style* variable. A sane set of things to
                              ;; highlight is: face, tabs, trailing
                              (whitespace-mode)
                              ))


;;---------------------------------------------------------------------------------------------
;; Auto Mode a-list (links filename extensions to editor modes)
;;


(set-default 'auto-mode-alist
	     (append '(("\\.ss$" . scheme-mode)
		       ("\\.scm$" . scheme-mode)
		       ("\\.lisp$" . lisp-mode)
		       ("\\.lsp$" . lisp-mode)
		       ("\\.cl$" . lisp-mode)
		       ("\\.as$" . java-mode)
		       ("\\.js$" . javascript-mode)
		       ("\\.jsx$" . javascript-mode)
		       ("\\.java\\'" . jde-mode)
		       ("\\.(lit)?coffee$" . coffee-mode)
		       ("\\.clj$" . clojure-mode)
		       ("\\.less$" . css-mode)
		       ("\\.jade$" . jade-mode)
		       ("\\.cflow$" . cflow-mode)
		       ("\\.csv$" . csv-nav-mode)
		       ("\\.swift$" . javascript-mode))                     
	auto-mode-alist))

;;---------------------------------------------------------------------------------------------
;; Scheme mode configuration.
;;

(defun my-scheme-mode-hook ()
  "Custom Scheme mode hook."
  (interactive)
  (make-local-variable 'scheme-indent-function))

(setq racket-program "/Applications/Racket-v6.1.1/bin/racket")
(setq cmulisp-program "/usr/bin/lisp")
(setq chez-program "/usr/bin/scheme")
(setq scheme-program-name "/usr/bin/scheme")

;; Indentation.
(defvar my-scheme-indents
  '((for . 1)
    (for/list . 1)
    (for/fold . 2)
    (revise . 3)
    (for/vector . 1)
    (for* . 1)
    (for*/list . 1)
    (for*/fold . 2)
    (while/fold . 2)
    (until/fold . 2)
    (for*/vector . 1)
    (with-syntax . 1)
    (for/arg-min . 1)
    (for*/arg-min . 1)
    (for/arg-max . 1)
    (for*/arg-max . 1)
    (for/sum . 1)
    (for*/sum . 1)
    (for/average . 1)
    (for*/average . 1)
    (for/append . 1)
    (for*/append . 1)
    (for/list/filter . 1)
    (for*/list/filter . 3)
    (match . 1)
    (with-open-db . 1)
    (with-input-file . 2)
    (with-output-file . 2)
    (with-open-db-queued . 1)))

(defun set-scheme-indentation (p)
  (put (car p) 'scheme-indent-function (cdr p)))

(mapc (lambda (p) (set-scheme-indentation p)) my-scheme-indents)

(setq *current-project-defsys* "~/projects/SAN/defsys.ss")
(setq *current-project-schemerc* "/Library/Scheme/schemerc")


;; Scheme v. racket

(defun scheme ()
  (interactive)
  (find-file *current-project-defsys*)
  (setq scheme-program-name (format "/usr/bin/scheme %s" *current-project-schemerc*))
  (call-interactively 'run-scheme)
  (let ((process (get-buffer-process (get-buffer "*scheme*"))))
    (process-send-string process (format "(load \"defsys.ss\")\n" *current-project-defsys*))))

(defun racket ()
  (interactive)
  (run-scheme racket-program))



;;---------------------------------------------------------------------------------------------
;; KEYBOARD SETUP
;; Insert special characters.

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'alt)

(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

(defun insert-lambda ()
  (interactive)
  (ucs-insert #x03BB))

(defun insert-eta ()
  (interactive)
  (ucs-insert #x03B7))

(defun insert-square-plus ()
  (interactive)
  (ucs-insert #x229E))

(defun insert-left-arrow ()
  (interactive)
  (insert "⇐"))

(defun insert-right-arrow ()
  (interactive)
  (insert "⇒"))

(defun insert-equivalent ()
  (interactive)
  (insert "≡"))

(defun insert-derives ()
  (interactive)
  (insert "▶"))

(defun insert-derived-from ()
  (interactive)
  (insert "◀"))

(defun insert-square-box ()
  (interactive)
  (insert "◩"))

(global-set-key (kbd "A-C-l") 'insert-lambda)
(global-set-key (kbd "A-h") 'insert-eta)
(global-set-key (kbd "A-+") 'insert-square-plus)
(global-set-key (kbd "A-C-,") 'insert-left-arrow)
(global-set-key (kbd "A-C-.") 'insert-right-arrow)
(global-set-key (kbd "A-C-=") 'insert-equivalent)
(global-set-key (kbd "A->") 'insert-derives)
(global-set-key (kbd "A-<") 'insert-derived-from)
(global-set-key (kbd "A-[") 'insert-square-box)


;;---------------------------------------------------------------------------------------------
;; SMTP/RMAIL setup.
;;


(setq user-full-name "Anurag Mendhekar")
(setq user-mail-address "anurag@mendhekar.com")
(setq smtpmail-default-smtp-server "smtp.mendhekar.com")
(setq smtpmail-local-domain "mendhekar.com")
(setq send-mail-function 'smtpmail-send-it)


;;---------------------------------------------------------------------------------------------
;; HTML mode
;;

(defun my-html-mode-hook () "Customize my html-mode."
  (tidy-build-menu html-mode-map)
  (local-set-key [(control c) (control c)] 'tidy-buffer)
  (setq sgml-validate-command "tidy"))

 


;;---------------------------------------------------------------------------------------------
;; Javascript mode extensions
;;

(defun my-javascript-mode-hook () (local-set-key (kbd "C-M-q") 'js-indent-exp))
(defun my-css-mode-hook () (local-set-key (kbd "C-M-q") 'js-indent-exp))
(defun js-indent-exp ()
  (interactive)
  (save-excursion
    (let ((start (point)))
      (forward-sexp 1)
      (let ((end (point)))
	(indent-region start end)
	(goto-char start)))))

;;---------------------------------------------------------------------------------------------
;; Weird things
;;

(custom-set-variables '(initial-frame-alist (quote ((fullscreen . maximized)))))		
(setq ring-bell-function 'ignore)


;;---------------------------------------------------------------------------------------------
;; DIRED mode customization
;;

(defun dired-open-file ()
  (interactive)
  (shell-command (concat "open '" (dired-file-name-at-point) "'")))

(add-hook 'dired-mode-hook  (lambda () (local-set-key (kbd "C-c C-o") #'dired-open-file)))

;;---------------------------------------------------------------------------------------------
;; Auto complete mode. 

(require 'auto-complete-config)

(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'css-mode-hook 'ac-css-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'javascript-mode)

(setq css-indent-offset 2)
(setq-default indent-tabs-mode nil)


;;---------------------------------------------------------------------------------------------
;; Scala mode configuration
;;

(setenv "PATH" (concat "/usr/local/bin:"  (getenv "PATH")))
(when (memq window-system '(mac ns)) (exec-path-from-shell-initialize))

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;;--------------------------------------------------------------------------------------------
;; Shell configuration
(setenv "PATH" (concat "/usr/local/bin:"  (getenv "PATH")))
(when (memq window-system '(mac ns)) (exec-path-from-shell-initialize))
;;---------------------------------------------------------------------------------------------
;; AUTO INSERTED STUFF BY EMACS. All edits above this section
;; NO EDITS BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING

(setq split-width-threshold 1000)
(put 'narrow-to-region 'disabled nil)
(setq c-basic-indent 2)
(setq c-basic-offset 2)
(put 'narrow-to-region 'disabled nil)
