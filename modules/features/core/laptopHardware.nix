{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.laptopHardware = {pkgs, ...}: {
    services.upower.enable = true;

    environment.systemPackages = with pkgs; [acpi upower bash];
  };
}
