{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.atuin ];

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      # Disable up-arrow keybinding
      keymap_mode = "vim-insert"; # optional, just keeps normal behavior
      search_mode = "ctrl-r"; # set Atuin to only trigger with Ctrl+R
      keymap_cursor = "none"; # disables up-arrow search
    };
  };
}
