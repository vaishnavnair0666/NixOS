{
  pkgs,
  lib,
  self',
  ...
}: let
  layout = import ./layout.nix {inherit pkgs lib self';};
  input = import ./input.nix {inherit pkgs lib self';};
  binds = import ./binds.nix {inherit pkgs lib self';};
  startup = import ./startup.nix {inherit pkgs lib self';};
  windowRules = import ./windowRules.nix {inherit pkgs lib self';};
  misc = import ./misc.nix {inherit pkgs lib self';};
in
  layout // input // binds // startup // windowRules // misc
