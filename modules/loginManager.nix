{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  environment.systemPackages = with pkgs; [ niri ];

  services.displayManager.sessionPackages = [ pkgs.niri ];
}
