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
      zoxide
      fd

      usbutils
      pciutils
      libinput
      libinput-gestures
      libxkbcommon

      SDL2
      SDL2_ttf

      strace
      strace-analyzer
      lsof

      thunderbird
      drawio
    ];
    services.gvfs.enable = true;
  };
}
