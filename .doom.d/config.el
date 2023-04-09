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
(setq org-directory "~/Documents/programing/src/github.com/rintaronakamura/org-files")
;; org-download
(add-hook 'dired-mode-hook 'org-download-enable)
;; org-agenda
(setq org-agenda-files '( "~/Documents/programing/src/github.com/rintaronakamura/org-files"))
;; org-journal
(setq org-journal-carryover-items "")
(setq org-journal-dir "~/Documents/programing/src/github.com/rintaronakamura/org-files")
(setq org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-date-format "%Y-%m-%d, %A")
;; org-roam
(setq org-roam-directory "~/Documents/programing/src/github.com/rintaronakamura/org-files")
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

;; TimeTree
;;
;; TODO
;; ・とりあえずで殴り書きしたのでリファクタリングする
;; ・不正値が入力されたときの処理もちゃんと書く
;; ・任意項目(説明、場所、URL、予定参加者のユーザー)を入力できるようにする
(defun my/timetree-new-event ()
  (interactive)

  (defvar access-token (getenv "TIMETREE_ACCESS_TOKEN"))

  (defun get-name-id-alist (item)
    (let ((attributes (assoc-default 'attributes item)))
      (cons (assoc-default 'name attributes) (assoc-default 'id item))))

  (defun process-data (alist)
    (mapcar 'get-name-id-alist alist))

  (setq calendar-list nil)

  (request "https://timetreeapis.com/calendars"
    :headers `(("Accept" . "application/vnd.timetree.v1+json")
               ("Authorization" . ,(concat "Bearer " access-token)))
    :parser 'json-read
    :sync t
    :success (cl-function
              (lambda (&key data &allow-other-keys)
                (setq calendar-list (process-data (assoc-default 'data data)))))
    :error (cl-function
            (lambda (&rest args &key error-thrown &allow-other-keys)
              (message "Got error: %S" error-thrown))))

  (setq calendar-name-list (mapcar #'car calendar-list))

  (setq selected-calendar-name nil)

  (let ((choices calendar-name-list))
    (setq selected-calendar-name (completing-read "カレンダーを選択して下さい: " choices)))

  (setq selected-calendar-id (cdr (assoc selected-calendar-name calendar-list)))

  (setq title (read-string "タイトルを入力してください: "))

  (setq start-date
        (read-string "開始日を入力してください (例 2023-04-05): "))

  (setq start-time
        (read-string "開始時間を入力してください (例 12:15:00)\n＊終日予定の場合は時刻を 00:00:00 にしてください: "))

  (setq start-at (concat start-date "T" start-time))

  ;; TODO 開始日と等しい場合は省略する
  (setq end-date (read-string "終了日を入力してください (例 2023-04-05): "))

  ;; TODO 開始時間が 00:00:00 なら省略する
  (setq end-time
        (read-string "終了時間を入力してください (例 12:15:00)\n＊終日予定の場合は時刻を 00:00:00 にしてください: "))

  (setq end-at (concat end-date "T" end-time))

  (setq all-day
    (if (and (string= start-time "00:00:00") (string= end-time "00:00:00"))
      "true"
      "false"))

  (setq label-list nil)

  (request (concat "https://timetreeapis.com/calendars/" selected-calendar-id "/labels")
    :headers `(("Accept" . "application/vnd.timetree.v1+json")
               ("Authorization" . ,(concat "Bearer " access-token)))
    :parser 'json-read
    :sync t
    :success (cl-function
              (lambda (&key data &allow-other-keys)
                (setq label-list (process-data (assoc-default 'data data)))))
    :error (cl-function
            (lambda (&rest args &key error-thrown &allow-other-keys)
              (message "Got error: %S" error-thrown))))

  (setq label-name-list (mapcar #'car label-list))

  (setq selected-label-name nil)

  ;; TODO 色の名前だけだと分かりづらいので、色のプレビューも表示する
  (let ((choices label-name-list))
    (setq selected-label-name (completing-read "ラベルを選択して下さい: " choices)))

  (setq selected-label-id (cdr (assoc selected-label-name label-list)))

  (setq my-data `(
    (data . (
      (attributes . (
        (category . "schedule")
        (title . ,title)
        (all_day . ,all-day)
        (start_at . ,start-at)
        (start_timezone . "Asia/Tokyo")
        (end_at . ,end-at)
        (end_timezone . "Asia/Tokyo")
      ))
      (relationships . (
        (label . (
          (data . (
            (id . ,selected-label-id)
            (type . "label")
          ))
        ))
      ))
    ))
  ))

  (request
    (concat "https://timetreeapis.com/calendars/" selected-calendar-id "/events")
    :type "POST"
    :headers `(("Content-Type" . "application/json")
               ("Accept" . "application/vnd.timetree.v1+json")
               ("Authorization" . ,(concat "Bearer " access-token)))
    :data (json-encode my-data)
    :parser 'json-read
    :success (cl-function
              (lambda (&key data &allow-other-keys)
                (message "予定を登録しました")))
    :error (cl-function
            (lambda (&rest args &key error-thrown &allow-other-keys)
              (message "Error: %S" error-thrown)))))
