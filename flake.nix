{
  description = "My NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # stable
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable"; # unstable
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "unstable";
    dwlFlake.url = "path:./flakes/dwl-base";

    nvim.url = "path:./flakes/nvim";
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
        specialArgs = { inherit inputs unstablePkgs; };
        modules = [
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

