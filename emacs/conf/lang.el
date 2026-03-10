(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
	 ("\\.jsp\\'" . web-mode)
	 ("\\.gsp\\'" . web-mode)
	 ("\\ts[x]?\\'" . web-mode)
	 ("\\js[x]?\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t))

(use-package rust-mode
:ensure t
  :mode (("\\.rs\\'" . rust-mode)))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package python-mode
  :ensure t
  :mode "\\.py\\'")

(use-package typst-ts-mode
  :ensure t
  :mode "\\.typ\\'")

(use-package elm-mode
  :ensure t
  :mode "\\.elm\\'")

(use-package vue-mode
  :ensure t
  :mode "\\.vue\\'")

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'")
