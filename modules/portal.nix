{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = [ "gtk" ];
  };
  environment.systemPackages = with pkgs; [ xwayland-satellite ];
}

