{...}: {
  flake.nixosModules.system-apps = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      alacritty
      grim
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
    ];
  };
}
