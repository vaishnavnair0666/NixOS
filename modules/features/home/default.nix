{
  inputs,
  self,
  ...
}: let
  user = "vaish";
in {
  flake.nixosModules.home = {...}: {
    _module.args = {inherit user;};
    imports = [
      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.nix-tools
      self.nixosModules.hm-packages
      self.nixosModules.hm-lsp
      self.nixosModules.hm-git
      self.nixosModules.hm-shell
      self.nixosModules.hm-foot
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${user} = {
        home.username = user;
        home.homeDirectory = "/home/${user}";
        home.stateVersion = "25.11";
      };

      extraSpecialArgs = {inherit user;};
    };
  };
}
