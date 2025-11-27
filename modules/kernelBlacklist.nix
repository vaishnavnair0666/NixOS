{ lib, specialArgs ? { }, ... }:

let
  # hostOverride passed from the flake; default to empty attrset if missing
  hostOverride = lib.optionalAttrs (lib.hasAttr "hostOverride" specialArgs)
    (specialArgs.hostOverride) // { };
in {
  boot.blacklistedKernelModules =
    if (hostOverride.disableAtkbd or false) then [ "atkbd" ] else [ ];
}

