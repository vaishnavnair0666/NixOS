{ pkgs, ... }:

{
  boot.loader = {
    timeout = 5;

    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      useOSProber = true;
      configurationLimit = 15;

      gfxmodeEfi = "1920x1080";
      gfxpayloadEfi = "keep";

      terminalOutput = [ "gfxterm" ];
    };
  };
}
