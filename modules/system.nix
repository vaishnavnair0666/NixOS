{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ acpi upower ];
  services.upower.enable = true;
}
