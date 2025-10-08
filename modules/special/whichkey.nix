{ config, unstablePkgs, ... }:

{
  environment.systemPackages = [ unstablePkgs.wlr-which-key ];
}
