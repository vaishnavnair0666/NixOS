{ pkgs, ... }: {
  home.username = "vaish";
  home.homeDirectory = "/home/vaish";

  home.packages = with pkgs; [
    alacritty
    swaybg
    swaylock
    waybar
    mako
    wofi
    btop
    fastfetch
    firefox
    wl-clipboard
    cliphist
    grim
    slurp
    swappy
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
  home.file.".config/niri".source = ./config/niri;
  #hello
  home.stateVersion = "25.11";
}

