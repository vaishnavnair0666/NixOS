{self, ...}: {
  flake.nixosModules.asuslaptopConfiguration = {...}: {
    nixpkgs.config.allowUnfree = true;
    imports = [
      self.nixosModules.asuslaptopHardware
      self.nixosModules.core

      self.nixosModules.desktop
      self.nixosModules.dev
      self.nixosModules.system
      self.nixosModules.home

      self.nixosModules.apps
    ];
    time.timeZone = "Asia/Kolkata";

    nix.settings.experimental-features = ["nix-command" "flakes"];

    system.stateVersion = "25.11";
  };
}
