;; -*- lexical-binding: t; -*-
(require 'org)
(define-key org-mode-map (kbd "C-c s") 'org-insert-structure-template)

(org-babel-do-load-languages
  'org-babel-load-languages
  '(
    (rust .t)
    (haskell . t)
    (gnuplot . t)
    ))

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))

(setq org-preview-latex-default-process 'dvipng)

(setq org-capture-templates
      '(;; [t] TODO: 一般的なタスク
        ("t" "Todo" entry (file+headline "~/knowledge/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        
        ;; [r] Report: レポート課題（締切付き）
        ("r" "Report/Assignment" entry (file+headline "~/knowledge/org/school.org" "Assignments")
         "* TODO %? (電気電子材料)\n  DEADLINE: %^t\n  %i")
        
        ;; [h] Hint: 試験に出そうなポイント（重要）
        ("h" "Exam Hint" entry (file+headline "~/knowledge/org/school.org" "Exam Hints")
         "* WAITING 試験対策: %?\n  Note: %a\n  Captured at: %U")
        ))

(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75))
;; 1. 基本的なファイル（直下にあるもの）
(setq org-agenda-files '("~/knowledge/org/inbox.org"
                           "~/knowledge/org/gtd.org"
                           "~/knowledge/org/school.org"))

;; 2. 【重要】大学の講義ノートフォルダを「再帰的」に追加する
;;    directory-files-recursively を使って、深い階層の .org も全部拾う
(setq org-agenda-files
        (append org-agenda-files
                (directory-files-recursively "~/knowledge/org/college" "\\.org$")))

(use-package org-roam
  :ensure t
  :custom
  ;; ノートの保存場所
  (org-roam-directory (file-truename "~/knowledge/org/roam"))
  ;; 完了時のタグ更新など
  (org-roam-complete-everywhere t)
  
  :bind (("C-c n l" . org-roam-buffer-toggle) ;; 関連ノードを表示するサイドバー
         ("C-c n f" . org-roam-node-find)     ;; ノードを検索して移動 / 新規作成
         ("C-c n g" . org-roam-graph)         ;; グラフ表示 (Graphviz版)
         ("C-c n i" . org-roam-node-insert)   ;; リンクを挿入 (授業中に一番使います！)
         ("C-c n c" . org-roam-capture)       ;; 思いついたことを即座にメモ
         ;; Dailies (日誌) も使うなら
         ("C-c n j" . org-roam-dailies-capture-today))
  
  :config
  ;; 起動時にDBを同期
  (org-roam-db-autosync-mode)
  
  ;; 補完UI (Verticoなどを推奨しますが、デフォルトでも動きます)
  ;; ノード検索時にタグも表示する設定
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  (setq org-roam-capture-templates
	'(
          ;; 1. 【概念 (Concept)】: 授業で出てきた用語の定義用
          ("c" "Concept (学術用語)" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+filetags: :study:concept:\n\n* 定義\n\n* 具体例\n\n* 関連講義\n")
           :unnarrowed t)
	  
          ;; 2. 【アイデア (Idea)】: 起業や社会課題の解決案
          ("i" "Idea (起業・社会)" plain
           "* 課題 (Pain)\n%?\n\n* 解決策 (Solution)\n\n* 使える技術 (Seeds)\n"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+filetags: :idea:project:\n#+date: %U\n")
           :unnarrowed t)
	  
	  ;; 3. 【ニュース(News]】 : 社会情勢の概要
	  ("n" "News (時事・社会課題)" plain
	   "* Source (出典)\n%^{URL}\n\n* Summary (要約)\n%?\n\n* Insight (なぜ気になった？)\n- 課題(Pain): \n- 機会(Gain): \n\n* Related (関連する技術・概念)\n"
	   :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+filetags: :news:input:society:\n#+date: %U\n")
	   :unnarrowed t)
	  
	  ;; 4. 【デフォルト】: とりあえずのメモ
          ("d" "Default" plain
           "%?"
           :if-new (file+head "${slug}.org"
                              "#+title: ${title}\n#+date: %U\n")
           :unnarrowed t)
	  )))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t       ;; Emacsのテーマに合わせる
        org-roam-ui-follow t           ;; Emacsで開いているノードを追従
        org-roam-ui-update-on-save t   ;; 保存したら即グラフ更新
        org-roam-ui-open-on-start nil))

(use-package org-protocol
  :ensure nil ;; org-modeに同梱されているため
  :config
  ;; サーバーが動いていなければ起動するおまじない
  (require 'server)
  (unless (server-running-p)
    (server-start)))

(setq org-preview-latex-default-process 'dvisvgm)

(use-package org-download
  :ensure nil
  :after org
  :config
  (setq org-download-method 'directory)
  (setq org-download-image-dir "./images")
  (setq org-download-heading-lvl nil)
  (setq org-download-subtree-owner nil)
  (setq org-download-timestamp-prefix-format "%Y-%m-%d--%H-%M-%S_")
  (when (string-equal (getenv "XDG_SESSION_TYPE") "wayland")
    (setq org-download-screenshot-method "grim -g \"$(slurp)\" %s")
    (setq org-download-backend "wl-clipboard")))
  
(use-package org-nix-shell
  :config
  (with-eval-after-load 'org
    (add-hook 'org-mode-hook #'org-nix-shell-mode)))
