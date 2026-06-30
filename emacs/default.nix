{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages =
      epkgs: with epkgs; [
        catppuccin-theme
        neotree
        ddskk
        init-loader
        ob-rust
        org-nix-shell
        magit
        company
        web-mode
        haskell-mode
        ivy
        swiper
        counsel
        rust-mode
        nix-mode
        python-mode
        typst-ts-mode
        elm-mode
        csv-mode
        direnv
        vue-mode
        yuck-mode
        copilot
        copilot-chat
        lsp-mode
        lsp-ui
        lsp-ivy
        flycheck
        yasnippet
        which-key
        powerline
        org-roam
        org-roam-ui
        org-download
        (treesit-grammars.with-grammars (
          p: with p; [
            tree-sitter-typst
            tree-sitter-html
          ]
        ))
        guix
        geiser
        geiser-guile
        macrostep-geiser
        pdf-tools
        gnuplot
      ];
    overrides = self: super: {
      direnv = self.melpaPackages.direnv;
    };
    extraConfig = builtins.readFile ./init.el;
  };
  home.file = {
    ".emacs.d/conf".source = ./conf;
    ".emacs.d/init.el".source = ./init.el;
  };
	home.packages = with pkgs; [
		wl-clipboard
		grim
		slurp
	];
  xdg.desktopEntries.org-protocol = {
    name = "Org-Protocol";
    exec = "emacsclient %u";  # EmacsクライアントにURLを投げる
    icon = "emacs";
    type = "Application";
    categories = [ "System" ];
    mimeType = [ "x-scheme-handler/org-protocol" ];
  };
  # 2. MIMEタイプの関連付けを明示
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
    };
  };
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
}
