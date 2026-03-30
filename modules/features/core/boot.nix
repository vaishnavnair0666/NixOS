{inputs, ...}: {
  flake.nixosModules.boot = {pkgs, ...}: {
    boot.loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        theme = inputs.nixos-grub-themes.packages.${pkgs.stdenv.hostPlatform.system}.nixos;
        efiSupport = true;
        device = "nodev";

        useOSProber = true;
        configurationLimit = 15;

        gfxmodeEfi = "1920x1080";
        gfxpayloadEfi = "keep";

        timeoutStyle = "menu";
      };
    };
  };
}
