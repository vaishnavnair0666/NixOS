{ pkgs, ... }:

{
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  programs.xwayland-satellite.enable = true;

  environment.systemPackages = with pkgs; [ xorg.xwayland ];
}
