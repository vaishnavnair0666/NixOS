{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosConfigurations.asuslaptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {inherit inputs;};

      modules = [self.nixosModules.asuslaptopConfiguration];
    };
    asuslaptop = self.nixosConfigurations.asuslaptop;
  };
}
