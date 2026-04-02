{inputs, ...}: {
  flake.nixosModules.hm-packages = {
    pkgs,
    user,
    ...
  }: {
    home-manager.users.${user}.home.packages =
      (with pkgs; [
        discord
        spotify
        zoom-us
        oklch-color-picker
        fzf
        lazysql
        localsend
        imv
        mpv
        mpv
        inkscape
        gimp
        ffmpeg
        mediainfo
        mediainfo-gui
        audacity

        zathura
        vlc
        obs-studio
        wf-recorder
        kdePackages.kdenlive

        vscode
        obsidian
        ripgrep
        fd
        btop
        fastfetchMinimal
        firefox
        pavucontrol
        nemo
        cliphist
        mako

        libreoffice

        npins
        yazi
        lazygit

        bat
        bluetuith
        broot

        zoom-us
        signal-desktop
      ])
      ++ [inputs.nvim.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}
