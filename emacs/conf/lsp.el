;; -*- lexical-binding: t; -*-

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((nix-mode . lsp)
	 (rust-mode . lsp)
	 (web-mode . lsp)
	 (typst-ts-mode . lsp)
	 (python-mode . lsp)
	 (elm-mode . lsp)
	 (vue-mode . lsp)
	 (haskell-mode . lsp))
  :config
  (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))
  (lsp-register-client (make-lsp-client
			:new-connection (lsp-stdio-connection "tinymist")
			:activation-fn (lsp-activate-on "typst")
			:server-id 'tinymist))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)

(use-package company
  :ensure t
  :bind (("C-M-i" . 'company-complete)
	 :map company-active-map
	 ("M-n" . 'company-select-next)
	 ("M-p" . 'company-select-previous)
	 ("M-y" . 'company-complete-selection)
	 :map company-search-map
	 ("M-n" . 'company-select-next)
	 ("M-p" . 'company-select-previous)
	 ("M-y" . 'company-complete-selection))
  :config
  (global-company-mode)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (setq company-show-numbers t)
  (setq company-frontends
	'(company-preview-frontend
	  company-pseudo-tooltip-frontend))
  (setq company-format-margin-function 'company-vscode-dark-icons-margin))

(with-eval-after-load 'lsp-mode
  (setq lsp-modeline-diagbostics-scope :workspace))

