{ pkgs, ...}:
{
	programs.zsh = {
		enable = true;
		shellAliases = {
			ls = "eza --git --icons=auto";
			ll = "eza -l --git --icons=auto";
			la = "eza -a --git --icons=auto";
			lla = "eza -la --git --icons=auto";
			lt = "eza --tree --git --icons=auto";
			e = "emacsclient -c -a ''";
		};
	};
}
