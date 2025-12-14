{
  description = "My NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    dwlFlake.url = "path:./flakes/dwl-base";

    nvim.url = "path:./flakes/nvim";
    nvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

      # find host files in ./hosts 
      hostFiles = if lib.pathExists ./hosts then
        builtins.attrNames (builtins.readDir ./hosts)
      else
        [ ];
      hostNames = lib.map
        (name: builtins.substring 0 (builtins.stringLength name - 4) name)
        hostFiles;

      # build a nixosSystem for a host
      makeNixosSystem = host:
        let
          hostFilePath = ./hosts/${host}.nix;
          hostOverrideAttr = import hostFilePath;
        in nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs;
            hostOverride = hostOverrideAttr;
          };
          modules = [
            ./configuration.nix
            sops-nix.nixosModules.sops
            ./modules/secrets.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useUserPackages = false;
              home-manager.backupFileExtension = "backup";
              home-manager.users.vaish = {
                imports = [ ./home.nix inputs.nvim.homeManagerModules.default ];
              };
              home-manager.extraSpecialArgs = { inherit pkgs; };
            }
          ];
        };

      # default system entry
      defaultNixosSystem = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit inputs pkgs;
          hostOverride = { };
        };
        modules = [
          ./configuration.nix
          sops-nix.nixosModules.sops
          ./modules/secrets.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = false;
            home-manager.backupFileExtension = "backup";
            home-manager.users.vaish = {
              imports = [ ./home.nix inputs.nvim.homeManagerModules.default ];
            };
            home-manager.extraSpecialArgs = { inherit pkgs; };
          }
        ];
      };

      # nixosConfigurations: default + per-host
      nixosEntries = lib.listToAttrs ([{
        name = "nixos";
        value = defaultNixosSystem;
      }] ++ (lib.map (h: {
        name = h;
        value = makeNixosSystem h;
      }) hostNames));

      # packages.x86_64-linux must expose the full nixosSystem object for nh to find .config.system.build.toplevel
      packagesEntries = lib.listToAttrs ([{
        name = "nixos";
        value = defaultNixosSystem;
      }] ++ (lib.map (h:
        let ns = makeNixosSystem h;
        in {
          name = h;
          value = ns;
        }) hostNames));

    in {
      nixosConfigurations = lib.recursiveUpdate nixosEntries { };

      packages = { x86_64-linux = packagesEntries; };
    };

}
