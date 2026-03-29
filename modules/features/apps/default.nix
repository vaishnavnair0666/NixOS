{self, ...}: {
  flake.nixosModules.apps = {...}: {
    imports = [self.nixosModules.system-apps];
  };
}
