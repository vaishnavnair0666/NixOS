{ pkgs, ... }:

{
  # programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    discord
    spotify
    zoom-us
    oklch-color-picker
    ollama
    obsidian
    vscode
    lazysql

    localsend

    imv
    inkscape
    gimp
  ];
}
