{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.my-nvim.packages.${pkgs.stdenv.system}.neovim
  ];
}
