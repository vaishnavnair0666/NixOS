{ config, pkgs, lib, unstablePkgs, quickshell, ... }:
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
# If/when you need extra QML modules, use withModules with a LIST, e.g.:
# (quickshell.packages.${pkgs.system}.default.withModules [
#   pkgs.qt6.qtimageformats
# ])
			(quickshell.packages.${unstablePkgs.system}.default.withModules [
# Core Qt modules (needed for many components)
			 unstablePkgs.qt6.qtdeclarative
			 unstablePkgs.qt6.qtwayland
			 unstablePkgs.qt6.qtsvg
			 unstablePkgs.qt6.qttools
			 unstablePkgs.qt6.qt5compat
			 unstablePkgs.qt6.qtmultimedia
			 unstablePkgs.qt6.qtshadertools
			 unstablePkgs.qt6.qtimageformats

# # Quickshell extension modules
# 			 quickshell.packages.${unstablePkgs.system}.icccm
# 			 quickshell.packages.${unstablePkgs.system}.ewmh
# 			 quickshell.packages.${unstablePkgs.system}.wayland
# 			 quickshell.packages.${unstablePkgs.system}.gtk
# 			 quickshell.packages.${unstablePkgs.system}.systemstats
# 			 quickshell.packages.${unstablePkgs.system}.notifications
# 			 quickshell.packages.${unstablePkgs.system}.power       
# 			 quickshell.packages.${unstablePkgs.system}.network     
# 			 quickshell.packages.${unstablePkgs.system}.mpris       
# 			 quickshell.packages.${unstablePkgs.system}.pulseaudio  
# 			 quickshell.packages.${unstablePkgs.system}.bluetooth   
			])
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

	home.file.".config/quickshell/default".source = ./config/quickshell/default;
	home.file.".config/quickshell/default".recursive = true;

#hello
	home.stateVersion = "25.05";
}

