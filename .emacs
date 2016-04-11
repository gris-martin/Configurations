(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(global-ede-mode 1)
(require 'semantic/sb)
(semantic-mode 1)

;;;; This snippet enables lua-mode
;; This line is not necessary, if lua-mode.el is already on your load-path
(add-to-list 'load-path "/path/to/directory/where/lua-mode-el/resides")

(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; setup files ending in “.agxLua” to open in lua-mode
(add-to-list 'auto-mode-alist '("\\.agxLua\\'" . lua-mode))

(add-to-list 'exec-path "/usr/local/bin")

;; Show line numbers
(global-linum-mode t)

;; Give FMU main file buffers their folder names instead of "main.agxLua"
(defun testfun ()
  (if (and (stringp buffer-file-name) (string-match ".*main.agxLua" buffer-file-name))
      (file-name-nondirectory (directory-file-name default-directory))
    (file-name-nondirectory buffer-file-name)))
(setq-default mode-line-buffer-identification
	      '(:eval (testfun)))
