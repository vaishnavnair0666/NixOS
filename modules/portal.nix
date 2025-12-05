{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    xwayland
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xwayland-satellite
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "wlr" "gtk" ];
  };

  # environment.sessionVariables = {
  #   XDG_CURRENT_DESKTOP = "niri";
  #   XDG_SESSION_TYPE = "wayland";
  #   ELECTRON_OZONE_PLATFORM_HINT = "auto";
  #   MOZ_ENABLE_WAYLAND = "1";
  #   GDK_BACKEND = "wayland";
  #   QT_QPA_PLATFORM = "wayland";
  # };
}
