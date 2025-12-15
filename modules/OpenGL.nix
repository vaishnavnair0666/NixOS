{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [ mesa mesa-demos wayland-utils ];

  services.xserver.videoDrivers = [ "amdgpu" ];
}
