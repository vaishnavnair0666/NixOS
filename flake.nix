{
  description = "My NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # stable
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "unstable";

    dwlFlake.url = "path:./flakes/dwl-base";

    nvim.url = "path:./nvim";
    nvim.inputs.nixpkgs.follows = "unstable";
  };

  outputs = { self, nixpkgs, unstable, home-manager, sops-nix, nvim, dwlFlake
    , ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      unstablePkgs = import unstable { inherit system; };
      # config.allowUnfree = true; # global system pkgs
    in {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          sops-nix.nixosModules.sops
          {
            environment.systemPackages =
              [ dwlFlake.packages.${system}.default ];

            services.xserver.enable = true; # for greeter only
            services.xserver.displayManager.gdm.enable = true;

            services.xserver.displayManager.sessionPackages = [
              (pkgs.writeTextDir "share/wayland-sessions/dwl.desktop" ''
                [Desktop Entry]
                Name=dwl
                Exec=${dwlFlake.packages.${system}.default}/bin/dwl
                Type=Application
              '')
            ];
          }
          ./modules/secrets.nix
          # Integrate home-manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            #home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;

            home-manager.backupFileExtension = "backup";
            # configure your user here
            home-manager.users.vaish = {
              imports = [ ./home.nix inputs.nvim.homeManagerModules.default ];
            };

            home-manager.extraSpecialArgs = { inherit unstablePkgs; };
          }
        ];
      };

    };
}

