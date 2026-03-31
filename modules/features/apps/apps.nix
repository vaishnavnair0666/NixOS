{...}: {
  flake.nixosModules.system-apps = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      alacritty
      grim
      slurp
      udiskie
      wl-clipboard
      brightnessctl
      unzip
      git
      vim
      tmux
      wget
      curl
      tldr
      fd

      usbutils
      pciutils
      strace
      strace-analyzer
      lsof
    ];
    services.gvfs.enable = true;
  };
}
