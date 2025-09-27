{ config, pkgs, lib, unstablePkgs, ... }:
let
decryptedKey = builtins.readFile (builtins.toPath ./modules/secrets/github.ssh.enc);
in
{
	home.username = "vaish";
	home.homeDirectory = "/home/vaish";

	home.packages =[
		pkgs.alacritty
			pkgs.btop
			pkgs.fastfetch
			pkgs.firefox
			pkgs.wl-clipboard
			];
	programs.bash.enable = true;
	programs.bash= {
		bashrcExtra = ''
			eval "$(direnv hook bash)"
			'';
	};
# Example: enable zsh
	programs.zsh = {
		enable = true;
		initContent = ''
			eval "$(direnv hook zsh)"
			'';
	};

	home.file.".config/hypr".source = ./config/hypr;

#hello
	home.stateVersion = "25.05";
}

