{
  description = "My NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # stable
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "unstable";
    dwlFlake.url = "path:./flakes/dwl-base";

    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    nvim.url = "path:./flakes/nvim";
    nvim.inputs.nixpkgs.follows = "unstable";
  };

  outputs = { nixpkgs, unstable, home-manager, sops-nix, dwlFlake, ... }@inputs:
    let

      myOverlays = [
        (final: prev: {
          #   # Override elephant-providers fetcher to fix hash mismatch
          #   elephant-providers = prev.elephant-providers.overrideAttrs (old: {
          #     src = prev.fetchFromGitHub {
          #       owner = "abenz1267";
          #       repo = "elephant-providers";
          #       rev = "master"; # Match the version you are using
          #       sha256 = "uwcGPmie44rfq9qCOXO3WjJXiLxQxNPmKQYbG9a22/c=";
          #     };
          #   });
          # })
          elephant-providers = prev.elephant-providers.overrideAttrs (old: {
            outputHash = "sha256-uwcGPmie44rfq9qCOXO3WjJXiLxQxNPmKQYbG9a22/c=";
          });
        })
      ];
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = myOverlays;
      };
      unstablePkgs = import unstable {
        inherit system;
        overlays = myOverlays;
      };
      # config.allowUnfree = true; # global system pkgs
    in {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs unstablePkgs; };
        modules = [
          {
            _module.args = { inherit inputs; };
          } # Expose flake inputs to modules
          ./configuration.nix
          sops-nix.nixosModules.sops
          {
            # environment.systemPackages =
            # [ dwlFlake.packages.${system}.default ];

            services.greetd = {
              enable = true;
              settings = {
                default_session = {
                  # command = "${pkgs.dwl}/bin/dwl";
                  command = "${dwlFlake.defaultPackage}/bin/dwl";
                  user = "vaish"; # autologin user
                };
              };
            };

            # optional greeter frontend (nice TUI)
            # programs.greetd.tuigreet.enable = true;
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
        # Make your dwl package available in system packages
        # configuration = {
        #   environment.systemPackages =
        #     [ inputs.dwlFlake.packages.${system}.default ];
        # };
      };

    };
}

