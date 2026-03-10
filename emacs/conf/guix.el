(use-package geiser
  :ensure nil
  :defer t
  :config
  ;; Guileだけを使うよう明示（起動高速化とノイズ除去）
  (setq geiser-active-implementations '(guile))
  (setq geiser-default-implementation 'guile))

(use-package geiser-guile
  :ensure nil
  :defer t
  ;; .scm ファイルを開いた時に、自動で geiser-mode をオンにするかはお好みで
  ;; :hook (scheme-mode . geiser-mode)
  )

(use-package macrostep-geiser
  :ensure nil
  :defer t
  :after (geiser-mode macrostep)
  :hook (geiser-mode-hook . macrostep-geiser-setup))
