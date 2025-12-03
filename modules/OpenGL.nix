{ pkgs, ... }: {
  hardware.opengl = { enable = true; };

  environment.systemPackages = with pkgs; [ mesa libglvnd ];
}

