(require 'package) ;; Enable packages
(add-to-list 'package-archives ;; Add the melpa repositories
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


(defun ensure-package-installed (&rest packages)
;;  "Assure every package is installed, ask for installation if it’s not.
;;
;;Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'auto-complete 'auto-complete-c-headers 'flymake-cursor 'flymake-google-cpplint 'flymake-easy 'google-c-style 'iedit 'popup 'yasnippet) ;  --> (nil nil) if iedit and magit are already installed

;; activate installed packages
(package-initialize)



;; Autocompletion
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

;; Autocomplete C headers
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/home/martin/Developer/OpenSceneGraph/headers"))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


;; Multi-line editing support (default key "C-;" does not work)
(define-key global-map (kbd "C-c ;") 'iedit-mode)


;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)


;; Flymake configuration
;; Start flymake-google-cpplint-load when c++ starts
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load))
(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)


;; Google-c-style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)



;; ;; Turn on semantic
;; (semantic-mode 1)
;; ;; ;; Add semantic as backend to auto complete
;; (defun my:add-semantic-to-autocomplete()
;;   (add-to-list 'ac-sources 'ac-source-semantic))
;; (add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)


;; EDE projects
;; (global-ede-mode 1)
;; System header files
;; (ede-cpp-root-project "visual interactive simulation" :file "~/Developer/57302VT16-Visuell-Interaktiv-Simulering/main.cpp"
;; 		      :include-path '("/../include"))

;; (global-ede-mode 1)
;; (require 'semantic/sb)
;; (semantic-mode 1)


;; Enable lua mode (must install lua-mode first)
;; This line is not necessary, if lua-mode.el is already on your load-path
;; (add-to-list 'load-path "/path/to/directory/where/lua-mode-el/resides")

;; (autoload 'lua-mode "lua-mode" "Lua editing mode." t)
;; (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
;; (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; ;; setup files ending in “.agxLua” to open in lua-mode
;; (add-to-list 'auto-mode-alist '("\\.agxLua\\'" . lua-mode))


;; (add-to-list 'exec-path "/usr/local/bin")

;; Show line numbers
(global-linum-mode t)
;; (setq linum-format "%2d\u2502 ")
(setq linum-format "%d ")


;; Give FMU main file buffers their folder names instead of "main.agxLua"
(defun testfun ()
  (if (and (stringp buffer-file-name) (string-match ".*main.agxLua" buffer-file-name))
      (file-name-nondirectory (directory-file-name default-directory))
    (file-name-nondirectory buffer-file-name)))
(setq-default mode-line-buffer-identification
	      '(:eval (testfun)))


;; (require 'eassist)

;; (eval-after-load "eassist"
;;  '(progn
;;    (setq eassist-header-switches '(("h" . ("cpp" "cc" "c" "m"))
;;                 ("hpp" . ("cpp" "cc"))
;;                 ("cpp" . ("h" "hpp"))
;;                 ("c" . ("h"))
;;                 ("m" . ("h"))
;;                 ("C" . ("H"))
;;                 ("H" . ("C" "CPP" "CC"))
;;                 ("cc" . ("h" "hpp"))))))

;; (defun my/c-mode-cedet-hook ()
;;   (local-set-key "\C-ct" 'eassist-switch-h-cpp))
;; (add-hook 'c-mode-common-hook 'my/c-mode-cedet-hook)
