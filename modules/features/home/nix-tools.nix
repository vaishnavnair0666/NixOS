{...}: {
  flake.nixosModules.nix-tools = {
    pkgs,
    user,
    ...
  }: {
    home-manager.users.${user} = {
      home.packages = with pkgs; [
        nh
        nix-output-monitor
        nvd
        nix-tree
        nix-index

        alejandra
        statix
        deadnix

        comma
      ];
      programs = {
        nix-index = {
          enable = true;
          enableBashIntegration = true;
        };
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        nh = {
          enable = true;

          clean = {
            enable = true;
            dates = "weekly";
          };

          flake = "/home/vaish/Flakes/nixos"; # adjust path
        };
      };
    };
  };
}
