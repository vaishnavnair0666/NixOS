{ config, pkgs, lib, unstablePkgs, ... }:
let
  decryptedKey =
    builtins.readFile (builtins.toPath ./modules/secrets/github.ssh.enc);
in {
  home.username = "vaish";
  home.homeDirectory = "/home/vaish";

  home.packages = with pkgs; [
    alacritty
    btop
    fastfetch
    firefox
    wl-clipboard
    atuin
  ];
  programs.bash.enable = true;
  programs.bash = {
    bashrcExtra = ''
      eval "$(direnv hook bash)"
      eval "$(atuin init bash)"
    '';
  };
  # Example: enable zsh
  programs.zsh = {
    enable = true;
    initContent = ''
          eval "$(atuin init zsh)"
      	  eval "$(direnv hook zsh)" 	    
    '';
  };

  # home.file.".config/hypr".source = ./config/hypr;

  #hello
  home.stateVersion = "25.05";
}

