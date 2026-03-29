{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.desktop = {...}: {
    imports = [
      self.nixosModules.greetd
      self.nixosModules.cursor
      self.nixosModules.portal
      self.nixosModules.niri
      # inputs.wrapper-modules.nixosModules.noctalia-shell
    ];
  };
}
