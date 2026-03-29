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
        inkscape
        gimp

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
      ])
      ++ [inputs.nvim.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}
