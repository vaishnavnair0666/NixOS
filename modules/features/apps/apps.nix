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
      libinput
      libinput-gestures
      strace
      strace-analyzer
      lsof

      thunderbird
    ];
    services.gvfs.enable = true;
  };
}
