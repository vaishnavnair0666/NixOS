{ pkgs, ... }:
let
  waybarWorkspace = builtins.readFile ./scripts/waybarWorkspace.sh;
  waybarWorkspaceAction = builtins.readFile ./scripts/waybarWorkspaceAction.sh;
  waybarNetwork = builtins.readFile ./scripts/waybarNetwork.sh;
in {
  home.username = "vaish";
  home.homeDirectory = "/home/vaish";
  imports = [ ./modules/niri/niri.nix ];
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "waybarWorkspace" "${waybarWorkspace}")
    (pkgs.writeShellScriptBin "waybarWorkspaceAction"
      "${waybarWorkspaceAction}")
    (pkgs.writeShellScriptBin "waybarNetwork" "${waybarNetwork}")
    niri
    alacritty
    ripgrep
    fuzzel
    mako
    wofi
    btop
    fastfetch
    firefox
    pipewire
    wireplumber
    pavucontrol
    cliphist
    atuin
    nemo
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

  home.file.".local/bin/wait-for-wayland".text =
    builtins.readFile ./scripts/wait-for-wayland.sh;
  home.file.".local/bin/wait-for-wayland".executable = true;

  # home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/wofi".source = ./config/wofi;
  home.file.".config/waybar".source = ./config/waybar;

  programs.niri.enable = true;

  programs.niri.animationsFragment =
    builtins.readFile ./modules/niri/fragments/animations.kdl;
  programs.niri.inputFragment =
    builtins.readFile ./modules/niri/fragments/input.kdl;
  programs.niri.keybindsFragment =
    builtins.readFile ./modules/niri/fragments/keybinds.kdl;
  programs.niri.layoutFragment =
    builtins.readFile ./modules/niri/fragments/layout.kdl;
  programs.niri.startupFragment =
    builtins.readFile ./modules/niri/fragments/startup.kdl;
  programs.niri.windowrulesFragment =
    builtins.readFile ./modules/niri/fragments/windowrules.kdl;
  programs.niri.wallpaperPath =
    "~/.dotfiles.git/dwl/modules/niri/wallpaper/default.jpg";
  programs.niri.outputFragment =
    builtins.readFile ./modules/niri/fragments/output.kdl;
  # if you want the module to write WAYLAND_DISPLAY into the KDL env block:
  programs.niri.environment = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  #hello
  home.stateVersion = "25.11";
}

