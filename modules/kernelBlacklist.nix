{ config, lib, ... }:

{
  boot.blacklistedKernelModules = lib.mkIf config.host.disableAtkbd [ "atkbd" ];
}
