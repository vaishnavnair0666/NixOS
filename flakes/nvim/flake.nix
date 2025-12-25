{
  description = "Standalone Nixvim configuration with devShell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim"; # your version
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ nixpkgs, nixvim, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem = { system, pkgs, ... }:
        let
          pureModule = (import ./config)._module.args.nixvimModule;
          nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit system;
            module = pureModule;
          };
        in {
          packages.default = nvim;
          devShells.default = pkgs.mkShell {
            buildInputs =
              [ nvim pkgs.stylua pkgs.lua-language-server pkgs.nixd ];
            shellHook = ''
              echo "DevShell: run 'nvim' to test your config."
            '';
          };
        };
      flake.data.nvimModule = ./config;
    };
}
