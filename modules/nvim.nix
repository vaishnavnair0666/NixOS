{ nvim, pkgs, ... }:

{
  environment.systemPackages = [
    nvim.packages.${pkgs.stdenv.system}.neovim
  ];
}
