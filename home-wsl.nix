{ pkgs, ...}:
{
  	imports = [
#			./nvim
			./emacs
			./git.nix
			./eza.nix
			./zsh
			./zsh/for_wsl.nix
			./direnv.nix
			./starship.nix
			./sway
#			./pantalaimon.nix
		];
		home.stateVersion = "23.11";
		home.packages = with pkgs; [
			github-cli
#      pantalaimon
      nixd
      tinymist
#			gnome-keyring
#			firefox
		];
}
