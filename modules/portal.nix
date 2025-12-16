{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-wlr
    ];
    config.common.default = [ "wlr" ];
  };
  services.dbus.enable = true;
  security.rtkit.enable = true;
  environment.systemPackages = with pkgs; [ xwayland-satellite ];

}

