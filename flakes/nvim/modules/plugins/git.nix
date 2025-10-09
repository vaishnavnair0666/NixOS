{ pkgs, ... }: {
  programs.lazygit.enable = true;

  extraPlugins = with pkgs.vimPlugins; [ git-worktree-nvim ];
  programs.nixvim = {
    plugins = {

      gitsigns.enable = true;
      # web-devicons.enable = true;
    };

    extraConfigLua = ''
         local gw_ok, gw = pcall(require, "git-worktree")
         if gw_ok then gw.setup() end
         	local telescope_ok, telescope = pcall(require, "telescope")
         		if telescope_ok then
         			telescope.load_extension("git_worktree")
         				end

      local ext = telescope.extensions.git_worktree
      vim.keymap.set("n", "<leader>wl", ext.git_worktrees, { desc = "List Git Worktrees" })
      vim.keymap.set("n", "<leader>wc", ext.create_git_worktree, { desc = "Create Git Worktree" })
    '';
  };
}
