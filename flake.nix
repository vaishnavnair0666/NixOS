{
  description = "My NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvim.url = "path:./flakes/nvim";
    nvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, sops-nix, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      hosts = lib.mapAttrs' (name: _: {
        name = lib.removeSuffix ".nix" name;
        value = ./hosts/${name};
      }) (lib.filterAttrs (_: type: type == "regular")
        (builtins.readDir ./hosts));

      mkSystem = hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            hostModule
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.users.vaish = {
                imports = [
                  ./home.nix
                  inputs.nvim.inputs.nixvim.homeManagerModules.nixvim
                  (import inputs.nvim.config)
                ];
              };
            }
          ];
        };

      systems = lib.mapAttrs (_: host: mkSystem host) hosts;

    in {
      nixosConfigurations = systems;
      packages.x86_64-linux = systems;
    };
}
