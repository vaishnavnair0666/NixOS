{ pkgs, ... }: {
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
      export EDITOR="nvim"
      export VISUAL="nvim"

      eval "$(direnv hook bash)"
      eval "$(atuin init bash)"
      # Remove up-arrow keybinding
      bind '"\e[A": history-search-backward' # Restores default up-arrow behavior
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
  home.file.".config/wofi".source = ./config/wofi;
  #hello
  home.stateVersion = "25.05";
}

