{ pkgs, ... }:

let
  harpoonV2 = pkgs.vimUtils.buildVimPlugin {
    pname = "harpoon";
    version = "2.x";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "harpoon2";
      sha256 = "1d6fbqs1813nyarw3a4lckw746szw9sbxn9kch6lnxk5qxa8y159";
    };
  };

  gitWorktree = pkgs.vimUtils.buildVimPlugin {
    pname = "git-worktree.nvim";
    version = "latest";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "git-worktree.nvim";
      rev = "master";
      sha256 = "0mspffvg2z5lx4ck96d2pnf1azy3s1zq720n6abnxzajadmnh47r";
    };
  };
in {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ plenary-nvim harpoonV2 gitWorktree ];

    extraConfigLua = ''
      -- Load telescope extensions ONLY (do not call telescope.setup)
      pcall(function()
        require("telescope").load_extension("harpoon")
        require("telescope").load_extension("git_worktree")
      end)

      -- Harpoon v2 setup
      local harpoon = require("harpoon")
      harpoon:setup()

      -- Harpoon keymaps
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      map("n", "<leader>ha", function()
        harpoon:list():add()
      end, vim.tbl_extend("force", opts, { desc = "Harpoon add file" }))

      map("n", "<leader>hh", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, vim.tbl_extend("force", opts, { desc = "Harpoon menu" }))

      map("n", "<leader>hr", function()
        harpoon:list():remove()
      end, vim.tbl_extend("force", opts, { desc = "Harpoon remove file" }))

      map("n", "<leader>hc", function()
        harpoon:list():clear()
      end, vim.tbl_extend("force", opts, { desc = "Harpoon clear list" }))

      -- Direct access
      for i = 1, 4 do
        map("n", "<leader>h" .. i, function()
          harpoon:list():select(i)
        end, vim.tbl_extend("force", opts, { desc = "Harpoon file " .. i }))
      end

      -- Git worktree integration
      map("n", "<leader>gw",
        require("telescope").extensions.git_worktree.git_worktrees,
        { desc = "Switch git worktree" })

      map("n", "<leader>gW",
        require("telescope").extensions.git_worktree.create_git_worktree,
        { desc = "Create git worktree" })
    '';
  };
}
