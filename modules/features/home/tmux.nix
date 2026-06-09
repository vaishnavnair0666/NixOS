{...}: {
  flake.nixosModules.hm-tmux = {
    pkgs,
    user,
    ...
  }: {
    home-manager.users.${user}.programs.tmux = {
      enable = true;

      mouse = true;
      keyMode = "vi";
      escapeTime = 100;
      historyLimit = 50000;
      terminal = "screen-256color";
      clock24 = true;
      customPaneNavigationAndResize = true;
      shortcut = "a";
      baseIndex = 1;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        vim-tmux-navigator
        catppuccin
        resurrect
        continuum
      ];
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };
}
