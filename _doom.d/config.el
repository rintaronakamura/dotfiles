;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "residenti"
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
(setq doom-font (font-spec :family "Hack Nerd Font" :size 14 :weight 'semi-light))

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
(setq org-directory "~/org/")
;; org-download
(add-hook 'dired-mode-hook 'org-download-enable)
;; org-agenda
(setq org-agenda-files '( "~/Google Drive/My Drive/org-files"))
;; org-journal
(setq org-journal-carryover-items "")
(setq org-journal-dir "~/Google Drive/My Drive/org-files")
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-date-format "%Y-%m-%d, %A")
;; org-roam
(setq org-roam-directory "~/Google Drive/My Drive/org-files")
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
;;   (message "%s" (my-test-get-url "hello https://residenti.github.io world!")))
;;
;; (defun my-open-url-test ()
;;   (interactive)
;;   (shell-command "open https://residenti.github.io/"))
;;
;; ref: https://osima.jp/posts/elisp-open-url-function/
;;
(defun my/get-current-line ()
  (buffer-substring-no-properties (point-at-bol) (point-at-eol)))

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
  (interactive)
  (browse-url (s-join "/"
                `(,(my/github-url)
                  ,(my/current-file-path-from-repository-root)))))
