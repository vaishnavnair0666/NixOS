{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.atuin ];
}
