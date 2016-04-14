(require 'package) ;; Enable packages
(add-to-list 'package-archives ;; Add the melpa repositories
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


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
