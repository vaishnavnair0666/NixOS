{
  description = "Standalone Nixvim configuration with devShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixvim, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { system, pkgs, ... }:
        let
          # Shortcuts
          nixvimLib = nixvim.lib.${system};
          nixvimPkgs = nixvim.legacyPackages.${system};

          # Your Nixvim module
          nixvimModule = {
            inherit system;
            module = import ./config; # config/default.nix
            extraSpecialArgs = { };
          };

          nvim = nixvimPkgs.makeNixvimWithModule nixvimModule;

        in {

          # For `nix flake check`
          checks.default =
            nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;

          # For `nix run .`
          packages.default = nvim;

          # For development: `nix develop`
          devShells.default = pkgs.mkShell {
            buildInputs =
              [ nvim pkgs.stylua pkgs.lua-language-server pkgs.git ];

            shellHook = ''
              echo "DevShell: run 'nvim' to load your nixvim config."
            '';
          };
        };
    };
}
