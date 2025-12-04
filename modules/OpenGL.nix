{ pkgs, ... }: {
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [ mesa libglvnd mesa_glu ];
}

