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
        let
          nixvimLib = nixvim.lib.${system};
          nixvimPkgs = nixvim.legacyPackages.${system};

          nixvimModule = {
            inherit system;
            module = import ./config;
            extraSpecialArgs = { };
          };

          nvim = nixvimPkgs.makeNixvimWithModule nixvimModule;

        in {
          checks.default =
            nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;

          packages.default = nvim;

          devShells.default = pkgs.mkShell {
            buildInputs =
              [ nvim pkgs.stylua pkgs.lua-language-server pkgs.git ];

            shellHook = ''
              echo "DevShell: run 'nvim' to test your config."
            '';
          };
        };
      flake = { data = { nvimConfig = ./config; }; };
    };
}
