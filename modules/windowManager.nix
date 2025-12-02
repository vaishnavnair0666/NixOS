{ pkgs, ... }:

{
  programs.niri.enable = true;
  services.xwayland.enable = true;
  programs.niri.package = pkgs.niri;
}
