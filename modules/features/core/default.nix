{self, ...}: {
  flake.nixosModules.core = {
    imports = [
      self.nixosModules.audio
      self.nixosModules.bluetooth
      self.nixosModules.boot
      self.nixosModules.graphics
      self.nixosModules.network
      self.nixosModules.users
      self.nixosModules.laptopHardware

      self.nixosModules.disableAtkbd
    ];
  };
}
