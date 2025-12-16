{ lib, ... }:

{
  options.host = {
    disableAtkbd = lib.mkEnableOption "Disable atkbd kernel module";

    profile = lib.mkOption {
      type = lib.types.enum [ "laptop" "desktop" "server" ];
      default = "desktop";
      description = "High-level host profile";
    };
  };
}

