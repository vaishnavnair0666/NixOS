{ ... }:

{
  # programs.lazygit.enable = true;

  plugins = {
    gitsigns = {
      enable = true;

      settings = {
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
        currentLineBlame = false;
      };
    };

    diffview.enable = true;

    # git-worktree.enable = true;
  };

  keymaps = [
    # Gitsigns
    {
      mode = "n";
      key = "<leader>gh";
      action = "require('gitsigns').preview_hunk";
      options.desc = "Preview git hunk";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "require('gitsigns').blame_line";
      options.desc = "Blame line";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "require('gitsigns').diffthis";
      options.desc = "Diff this file";
    }

    # Diffview
    {
      mode = "n";
      key = "<leader>gD";
      action = "<cmd>DiffviewOpen<cr>";
      options.desc = "Open diffview";
    }
    {
      mode = "n";
      key = "<leader>gq";
      action = "<cmd>DiffviewClose<cr>";
      options.desc = "Close diffview";
    }
  ];
}
