;; -*- lexical-binding: t; -*-
;; ddskk
(use-package ddskk
  :ensure t
  :config
  (setq skk-large-jisyo "~/skk/SKK-JISYO.L")
  (defun my/enable-skk ()
    (skk-latin-mode 1))
  (add-hook 'find-file-hook 'my/enable-skk)
  (setq skk-rom-kana-rule-list
      (append '(("." nil ". ") ("," nil ", "))
              skk-rom-kana-rule-list)))


;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; neotree
(use-package neotree
  :ensure t
  :bind (([f8] . neotree-toggle)))

;; direnv
(use-package direnv
  :ensure t
  :config
  (direnv-mode))

;; copilot.el
(use-package copilot
  :ensure t
  :hook
  (prog-mode . copilot-mode)
  :init
  (setq copilot-indent-offset-warning-disable t)
  :config
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

;; copilot-chat
(use-package copilot-chat
:ensure t
:bind (:map global-map
          ("C-c C-y" . copilot-chat-yank) 
          ("C-c M-y" . copilot-chat-yank-pop)
          ("C-c C-M-y" . (lambda () (interactive) (copilot-chat-yank-pop -1)))))

;; which-key
(use-package which-key
  :ensure t
    :config
    (which-key-mode))

;; yasnippet
(use-package yasnippet
	:ensure t
	:config
	(yas-global-mode 1))

;; pdf-tools
(use-package pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
)
