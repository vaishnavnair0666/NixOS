{ pkgs, nixos-grub-themes, ... }:

{
  boot.loader = {
    timeout = 5;

    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      theme = nixos-grub-themes.packages.${pkgs.system}.nixos;
      efiSupport = true;
      device = "nodev";

      useOSProber = true;
      configurationLimit = 15;

      gfxmodeEfi = "1920x1080";
      gfxpayloadEfi = "keep";

      timeoutStyle = "menu";
    };
  };
}
