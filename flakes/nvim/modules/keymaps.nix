{ ... }: {
  programs.nixvim.keymaps =

    [
      #Telescope Find 
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep (search in files)";
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Open buffers";
      }
      {
        key = "<leader>fo";
        action = "<cmd>Telescope oldfiles<cr>";
        options.desc = "Recent files";
      }
      {
        key = "<leader>fc";
        action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        options.desc = "Search in current buffer";
      }

      # Flash
      {
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash jump";
      }

      # Aerial toggle
      {
        key = "<leader>a";
        action = "<cmd>AerialToggle!<cr>";
        options.desc = "Toggle symbols outline";
      }
      # Trouble diagnostics
      {
        key = "<leader>xx";
        action = "<cmd>TroubleToggle document_diagnostics<cr>";
        options.desc = "Document diagnostics";
      }
      {
        key = "<leader>xf";
        action = "<cmd>Telescope diagnostics<cr>";
        options.desc = "Telescope diagnostics";
      }

      {
        key = "<leader>xX";
        action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
        options.desc = "Workspace diagnostics";
      }

      {
        key = "<leader>nn";
        action = "<cmd>Noice<cr>";
        options.desc = "Noice messages";
      }
      {
        key = "<leader>nh";
        action = "<cmd>NoiceHistory<cr>";
        options.desc = "Noice history";
      }
      {
        key = "<leader>nd";
        action = "<cmd>NoiceDismiss<cr>";
        options.desc = "Dismiss all notifications";
      }
      #GIT search
      {
        key = "<leader>gc";
        action = "<cmd>Telescope git_commits<cr>";
        options.desc = "Git commits";
      }
      {
        key = "<leader>gb";
        action = "<cmd>Telescope git_branches<cr>";
        options.desc = "Git branches";
      }
      {
        key = "<leader>gs";
        action = "<cmd>Telescope git_status<cr>";
        options.desc = "Git status";
      }
      {
        key = "<leader>gS";
        action = "<cmd>Telescope git_stash<cr>";
        options.desc = "Git stash";
      }
      {
        key = "<leader>gB";
        action = "<cmd>Telescope git_bcommits<cr>";
        options.desc = "Git buffer commits";
      }

      # nvim tools

      {
        key = "<leader>km";
        action = "<cmd>Telescope keymaps<cr>";
        options.desc = "Keymaps";
      }
      {
        key = "<leader>ch";
        action = "<cmd>Telescope command_history<cr>";
        options.desc = "Command history";
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options.desc = "Help tags";
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope registers<cr>";
        options.desc = "Registers";
      }
      {
        key = "<leader>fm";
        action = "<cmd>Telescope marks<cr>";
        options.desc = "Marks";
      }
      {
        key = "<leader>fqq";
        action = "<cmd>Telescope quickfix<cr>";
        options.desc = "Quickfix list";
      }
      {
        key = "<leader>fqh";
        action = "<cmd>Telescope quickfixhistory<cr>";
        options.desc = "Quickfix history";
      }
      {
        key = "<leader>fj";
        action = "<cmd>Telescope jumplist<cr>";
        options.desc = "Jumplist";
      }
      {
        key = "<leader>sp";
        action = "<cmd>Telescope spell_suggest<cr>";
        options.desc = "Spell suggestions";
      }
      {
        key = "<leader>se";
        action = "<cmd>Telescope search_history<cr>";
        options.desc = "Search history";
      }
      {
        key = "<leader>;";
        action = "<cmd>Telescope resume<cr>";
        options.desc = "Resume last Telescope picker";
      }

      # Misc

      {
        key = "<leader>pt";
        action = "<cmd>Telescope planets<cr>";
        options.desc = "Planets (fun)";
      }
      {
        key = "<leader>ma";
        action = "<cmd>Telescope man_pages<cr>";
        options.desc = "Man pages";
      }
      {
        key = "<leader>hl";
        action = "<cmd>Telescope highlights<cr>";
        options.desc = "Search highlights";
      }
    ];
}
