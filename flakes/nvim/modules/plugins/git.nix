{ pkgs, ... }: {
  programs.lazygit.enable = true;

  programs.nixvim = {
    # Explicitly add ThePrimeagen's plugin
    # extraPlugins = with pkgs.vimPlugins; [ git-worktree-nvim ];

    plugins = { gitsigns.enable = true; };
  };
}
