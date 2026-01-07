{ pkgs, ... }:
{
  home.packages = with pkgs; [
    inotify-tools
    jq
    libdrm
    mesa
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtimageformats
    qt6.qtshadertools
    qt6.qtwayland
    quickshell
    ripgrep
    vulkan-loader
    wallust
  ];
  home.file.".config/quickshell".source = ../config/quickshell;
  home.file.".config/wallust".source = ../config/wallust;
}
