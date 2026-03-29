{self, ...}: {
  flake.nixosModules.system = {...}: {
    imports = [
      self.nixosModules.fonts
      self.nixosModules.firewall
      self.nixosModules.steam
      self.nixosModules.power
    ];
  };
}
