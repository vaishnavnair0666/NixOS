{
  description = "Standalone Nixvim configuration with devShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, nixvim, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { system, pkgs, ... }:
        let pure = (import ./config)._module.args.nixvimModule;
        in {
          packages.default =
            nixvim.legacyPackages.${system}.makeNixvimWithModule {
              inherit system;
              module = pure;
            };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              (nixvim.legacyPackages.${system}.makeNixvimWithModule {
                inherit system;
                module = pure;
              })
              pkgs.stylua
              pkgs.nixd
              pkgs.lua-language-server
            ];
          };
        };

      flake.data.nvimModule = ./config;
    };
}
