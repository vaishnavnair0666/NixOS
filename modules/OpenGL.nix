{ pkgs, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  environment.systemPackages = with pkgs; [ mesa libglvnd ];
}

