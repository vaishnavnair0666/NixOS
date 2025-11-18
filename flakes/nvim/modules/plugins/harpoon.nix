{ pkgs, ... }:

let
  harpoonV2 = pkgs.vimUtils.buildVimPlugin {
    pname = "harpoon";
    version = "2.x";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "harpoon2"; # branch name for v2
      sha256 = "1d6fbqs1813nyarw3a4lckw746szw9sbxn9kch6lnxk5qxa8y159";
    };
    doCheck = false;
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
    doCheck = false;
  };
in {
  programs.nixvim = {
    enable = true;

    extraPlugins = with pkgs.vimPlugins; [ harpoonV2 plenary-nvim gitWorktree ];

    extraConfigLua = ''
      -- Telescope setup
      local telescope = require("telescope")
      telescope.setup()
      telescope.load_extension("git_worktree")
      telescope.load_extension("harpoon")

      -- Harpoon v2 setup
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon to File 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon to File 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon to File 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon to File 4" })


      -- Remove the current file from Harpoon
      vim.keymap.set("n", "<leader>hr", function()
      		harpoon:list():remove()
      		end, { desc = "Harpoon Remove File" })

      -- Clear the entire Harpoon list
      vim.keymap.set("n", "<leader>hc", function()
      		harpoon:list():clear()
      		end, { desc = "Harpoon Clear List" })

      -- Git Worktree keymaps (Primeagen-style)
      vim.keymap.set("n", "<leader>gw", telescope.extensions.git_worktree.git_worktrees, { desc = "Switch worktree" })
      vim.keymap.set("n", "<leader>gW", telescope.extensions.git_worktree.create_git_worktree, { desc = "Create worktree" })
    '';
  };
}
