{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.disableAtkbd = {
    config,
    lib,
    ...
  }: {
    options.host = {
      disableAtkbd = lib.mkEnableOption "Disable atkbd";

      profile = lib.mkOption {
        type = lib.types.enum ["laptop" "desktop" "server"];
        default = "desktop";
      };
    };

    config = {
      boot.blacklistedKernelModules =
        lib.mkIf config.host.disableAtkbd ["atkbd"];
    };
  };
}
