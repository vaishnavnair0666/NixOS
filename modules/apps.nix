{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    spotify
    zoom-us
  ];
}
