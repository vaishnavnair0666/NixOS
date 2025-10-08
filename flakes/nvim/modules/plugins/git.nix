{ pkgs, ... }:

{
  programs.lazygit.enable = true;
  programs.nixvim.plugins = {

    git-worktree = { enable = true; };
    # Optional: gitsigns for inline git info
    gitsigns.enable = true;
  };
  # Git Worktrees Plugin by ThePrimeagen
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
}
