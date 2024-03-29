;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; fix "ls does not support --dired; see ‘dired-use-ls-dired’ for more details."
(setq dired-use-ls-dired t)

;; 指定したmodeでevil-modeを無効化する
;; https://github.com/noctuid/evil-guide#evils-tools
(evil-set-initial-state 'flycheck-error-list-mode 'emacs)

;; JavaScriptのデフォルトインデントをスペース2に設定する
(add-hook 'js-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "rintaronakamura"
      user-mail-address "n.queue.r@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 16 :weight 'semi-light))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq confirm-kill-emacs nil)

;; global
(define-key global-map [?¥] [?\\])

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/software/programs/github.com/rintaronakamura/org-files")
;; org-download
(add-hook 'dired-mode-hook 'org-download-enable)
;; org-agenda
;; TODO: ここも org-directory の値を使って重複を無くす
(setq org-agenda-files '( "~/Documents/software/programs/github.com/rintaronakamura/org-files"))
;; org-journal
(setq org-journal-carryover-items "")
(setq org-journal-dir org-directory)
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-date-format "%Y-%m-%d, %A")
;; org-roam
(setq org-roam-directory org-directory)
;; org-roam-ui
(use-package! websocket
    :after org-roam)
(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t
          ;; NOTE: これ設定しないと、なぜかタブが2つ開かれちゃう
          org-roam-ui-open-on-start nil))

(defun web-mode-hook ()
  (setq web-mode-markup-indent-offset 2))
(add-hook 'web-mode-hook 'web-mode-hook)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;   ex. (map! :mode "key" #'function-name)
;;   <Mode List>
;;   - normal: n
;;   - visual: v
;;   - insert: i
;;   - emacs: e
;;   - operator: o
;;   - motion: m
;;   - replace: r
;;   - global: g
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; カレントポイントの行にあるURLをブラウザで開く
;; (defun my-buffer-substring-current-line ()
;;   "show current line."
;;   (interactive) ;; NOTE: M-x で呼び出せるようにするための決まり文句
;;   (message "%s"
;;       (buffer-substring-no-properties (point-at-bol) (point-at-eol)))) ;; NOTE: C-x C-e で関数を評価
;;
;; (defun my-test-get-url (s)
;;   (if (string-match ".*\\(https:\\/\\/.*\\(\\/\\| \\)\\).*" s)
;;       (match-string 1 s)
;;     s))
;;
;; (defun my-test ()
;;   "test my-test-get-url function"
;;   (interactive)
;;   (message "%s" (my-test-get-url "hello https://rintaronakamura.github.io world!")))
;;
;; (defun my-open-url-test ()
;;   (interactive)
;;   (shell-command "open https://rintaronakamura.github.io/"))
;;
;; ref: https://osima.jp/posts/elisp-open-url-function/
;;
(defun my/get-current-line ()
  (buffer-substring-no-properties (point-at-bol) (point-at-eol)))

;; FIXME: 正規表現を間違っていて、行末まで拾ってしまう。
(defun my/get-url (s)
  (if (string-match ".*\\(https:\\/\\/.*\\(\\/\\| \\|$\\)\\).*" s)
      (match-string 1 s)
    s))

(defun my/browse-url-at-point ()
  (interactive)
  (browse-url (my/get-url (my/get-current-line))))

(defun my/github-url ()
  (s-join "/"
    `("https://github.com"
      ,(s-chomp
        (replace-regexp-in-string
         "^.*github\.com[\:|\/]\\(.*\\)\.git.*" "\\1" (shell-command-to-string "git remote -v | head -1")))
      ,"blob"
      ,(s-chomp (shell-command-to-string "git branch --show-current"))
      )))

(defun my/current-file-path-from-repository-root ()
  (s-replace (projectile-project-root) "" (buffer-file-name)))

(defun my/browse-current-file-on-github ()
  "Open the current file on GitHub in the default browser."
  (interactive)
  (browse-url (s-join "/"
                `(,(my/github-url) ;; TODO: ここなんで「,」がいるのか良く分からん
                  ,(my/current-file-path-from-repository-root)))))

(defun elisp-mode-hooks ()
  "カーソル位置にあるElisp関数や変数の情報をエコーエリアへ表示させる"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (turn-on-eldoc-mode)))
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

(require 'timetree)
(require 'deepl)
