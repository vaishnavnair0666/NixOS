{ pkgs, ... }:
let
  waybarWorkspace = builtins.readFile ../scripts/waybarWorkspace.sh;
  waybarWorkspaceAction = builtins.readFile ../scripts/waybarWorkspaceAction.sh;
  waybarNetwork = builtins.readFile ../scripts/waybarNetwork.sh;
in {
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "waybarWorkspace" "${waybarWorkspace}")
    (pkgs.writeShellScriptBin "waybarWorkspaceAction"
      "${waybarWorkspaceAction}")
    (pkgs.writeShellScriptBin "waybarNetwork" "${waybarNetwork}")
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
}
