{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ mesa mesa-demos ];
    package = pkgs.mesa;
  };

  environment.systemPackages = with pkgs; [ mesa ];
}

