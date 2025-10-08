{ pkgs, ... }:

{
  programs.lazygit.enable = true;
  programs.nixvim.plugins = {

    # Git Worktrees Plugin by ThePrimeagen
    git-worktree = { enable = true; };
    programs.nixvim.extraConfigLua = ''
      local telescope = require('telescope')
      telescope.load_extension('git_worktree')

      vim.keymap.set('n', '<leader>wl', function()
        telescope.extensions.git_worktree.git_worktrees()
      end, { desc = "List Git Worktrees" })

      vim.keymap.set('n', '<leader>wc', function()
        telescope.extensions.git_worktree.create_git_worktree()
      end, { desc = "Create Git Worktree" })
    '';

    # Optional: gitsigns for inline git info
    gitsigns.enable = true;
  };
}
