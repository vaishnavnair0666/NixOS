{...}: {
  flake.nixosModules.power = {pkgs, ...}: {
    services.upower.enable = true;
    environment.systemPackages = with pkgs; [acpi];
  };
}
