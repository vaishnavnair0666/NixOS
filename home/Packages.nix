{ pkgs, ... }:
let
  waybarWorkspace = builtins.readFile ../scripts/waybarWorkspace.sh;
  waybarWorkspaceAction = builtins.readFile ../scripts/waybarWorkspaceAction.sh;
  waybarNetwork = builtins.readFile ../scripts/waybarNetwork.sh;
  waybarToggle = builtins.readFile ../scripts/waybarToggle.sh;
in {
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "waybarWorkspace" "${waybarWorkspace}")
    (pkgs.writeShellScriptBin "waybarWorkspaceAction"
      "${waybarWorkspaceAction}")
    (pkgs.writeShellScriptBin "waybarNetwork" "${waybarNetwork}")
    (pkgs.writeShellScriptBin "waybarToggle" "${waybarToggle}")
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
    nemo
  ];
}
