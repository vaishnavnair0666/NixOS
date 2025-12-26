{ ... }:

{
  keymaps = [

    #######################
    # UI TOGGLES
    #######################
    {
      mode = "n";
      key = "<leader>un";
      action = ":set number!<CR>";
      options.desc = "Toggle line numbers";
    }
    {
      mode = "n";
      key = "<leader>ur";
      action = ":set relativenumber!<CR>";
      options.desc = "Toggle relative numbers";
    }
    {
      mode = "n";
      key = "<leader>uw";
      action = ":set wrap!<CR>";
      options.desc = "Toggle word wrap";
    }
    {
      mode = "n";
      key = "<leader>us";
      action = ":set spell!<CR>";
      options.desc = "Toggle spell check";
    }

    #######################
    # SPLIT NAVIGATION
    #######################
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Move left";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Move down";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Move up";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Move right";
    }

    #######################
    # SPLIT RESIZE
    #######################
    {
      mode = "n";
      key = "<leader><up>";
      action = ":resize +2<CR>";
      options.desc = "Increase height";
    }
    {
      mode = "n";
      key = "<leader><down>";
      action = ":resize -2<CR>";
      options.desc = "Decrease height";
    }
    {
      mode = "n";
      key = "<leader><left>";
      action = ":vertical resize -2<CR>";
      options.desc = "Decrease width";
    }
    {
      mode = "n";
      key = "<leader><right>";
      action = ":vertical resize +2<CR>";
      options.desc = "Increase width";
    }

    #######################
    # BUFFERS
    #######################
    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer";
    }

    {
      mode = "n";
      key = "<leader>bm";
      action = "<cmd>BufferLineMoveNext<CR>";
      options.desc = "Move buffer right";
    }
    {
      mode = "n";
      key = "<leader>bh";
      action = "<cmd>BufferLineMovePrev<CR>";
      options.desc = "Move buffer left";
    }

    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<CR>";
      options.desc = "Close buffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action = "<cmd>BufferLineCloseOthers<CR>";
      options.desc = "Close other buffers";
    }

    #######################
    # DIRECT BUFFER ACCESS
    #######################
    {
      mode = "n";
      key = "<leader>1";
      action = "<cmd>BufferLineGoToBuffer 1<CR>";
      options.desc = "Buffer 1";
    }
    {
      mode = "n";
      key = "<leader>2";
      action = "<cmd>BufferLineGoToBuffer 2<CR>";
      options.desc = "Buffer 2";
    }
    {
      mode = "n";
      key = "<leader>3";
      action = "<cmd>BufferLineGoToBuffer 3<CR>";
      options.desc = "Buffer 3";
    }
    {
      mode = "n";
      key = "<leader>4";
      action = "<cmd>BufferLineGoToBuffer 4<CR>";
      options.desc = "Buffer 4";
    }
    {
      mode = "n";
      key = "<leader>5";
      action = "<cmd>BufferLineGoToBuffer 5<CR>";
      options.desc = "Buffer 5";
    }
    {
      mode = "n";
      key = "<leader>6";
      action = "<cmd>BufferLineGoToBuffer 6<CR>";
      options.desc = "Buffer 6";
    }

    #######################
    # FIND / TELESCOPE
    #######################
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>fo";
      action = "<cmd>Telescope oldfiles<cr>";
      options.desc = "Recent files";
    }
    {
      mode = "n";
      key = "<leader>fc";
      action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
      options.desc = "Search buffer";
    }
    {
      mode = "n";
      key = "<leader>fe";
      action = "<cmd>Telescope file_browser<cr>";
      options = { desc = "Telescope file_browser"; silent = true; };
    }
    #######################
    # OIL 
    #######################
    {
      mode = "n";
      key = "-";
      action = {
        __raw = "function() require('oil').open() end";
      };
      options = {
        desc = "Open Oil parent directory";
        silent = true;
      };
    }

    {
      mode = "n";
      key = "<leader>e";
      action = {
        __raw = "function() require('oil').open_float() end";
      };
      options = {
        desc = "Oil floating window";
        silent = true;
      };
    }
    #######################
    # FLASH
    #######################
    {
      mode = "n";
      key = "s";
      action = {
        __raw = "function() require('flash').jump() end";
      };
      options = {
        desc = "Flash jump";
        silent = true;
      };
    }

    #######################
    # CODE / SYMBOLS
    #######################
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>AerialToggle!<cr>";
      options.desc = "Symbols outline";
    }

    #######################
    # DIAGNOSTICS
    #######################
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>TroubleToggle document_diagnostics<cr>";
      options.desc = "Document diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
      options.desc = "Workspace diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xf";
      action = "<cmd>Telescope diagnostics<cr>";
      options.desc = "Search diagnostics";
    }

    #######################
    # NOTIFICATIONS
    #######################
    {
      mode = "n";
      key = "<leader>nn";
      action = "<cmd>Noice<cr>";
      options.desc = "Noice messages";
    }
    {
      mode = "n";
      key = "<leader>nh";
      action = "<cmd>NoiceHistory<cr>";
      options.desc = "Noice history";
    }
    {
      mode = "n";
      key = "<leader>nd";
      action = "<cmd>NoiceDismiss<cr>";
      options.desc = "Dismiss notifications";
    }

    #######################
    # GIT
    #######################
    {
      mode = "n";
      key = "<leader>gc";
      action = "<cmd>Telescope git_commits<cr>";
      options.desc = "Git commits";
    }
    {
      mode = "n";
      key = "<leader>gB";
      action = "<cmd>Telescope git_bcommits<cr>";
      options.desc = "Buffer commits";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Telescope git_branches<cr>";
      options.desc = "Git branches";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Telescope git_status<cr>";
      options.desc = "Git status";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action = "<cmd>Telescope git_stash<cr>";
      options.desc = "Git stash";
    }
    #######################
    # TOGGLE TERMINAL
    #######################
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Floating terminal";
    }
    {
      mode = "n";
      key = "<leader>th";
      action = "<cmd>ToggleTerm direction=horizontal<CR>";
      options.desc = "Horizontal terminal";
    }
    {
      mode = "t";
      key = "<C-t>";
      action = "<cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    #######################
    # HELP / HISTORY
    #######################
    {
      mode = "n";
      key = "<leader>hk";
      action = "<cmd>Telescope keymaps<cr>";
      options.desc = "Keymaps";
    }
    {
      mode = "n";
      key = "<leader>hh";
      action = "<cmd>Telescope help_tags<cr>";
      options.desc = "Help tags";
    }
    {
      mode = "n";
      key = "<leader>hC";
      action = "<cmd>Telescope command_history<cr>";
      options.desc = "Command history";
    }
    {
      mode = "n";
      key = "<leader>hs";
      action = "<cmd>Telescope search_history<cr>";
      options.desc = "Search history";
    }
    {
      mode = "n";
      key = "<leader>hr";
      action = "<cmd>Telescope registers<cr>";
      options.desc = "Registers";
    }
    {
      mode = "n";
      key = "<leader>hm";
      action = "<cmd>Telescope marks<cr>";
      options.desc = "Marks";
    }
    {
      mode = "n";
      key = "<leader>hj";
      action = "<cmd>Telescope jumplist<cr>";
      options.desc = "Jumplist";
    }
    {
      mode = "n";
      key = "<leader>hq";
      action = "<cmd>Telescope quickfix<cr>";
      options.desc = "Quickfix";
    }
    {
      mode = "n";
      key = "<leader>hQ";
      action = "<cmd>Telescope quickfixhistory<cr>";
      options.desc = "Quickfix history";
    }

    #######################
    # COLOR TOOLS
    #######################
    {
      mode = "n";
      key = "<leader>cp";
      action = "<cmd>CccPick<CR>";
      options.desc = "Pick color";
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>CccConvert<CR>";
      options.desc = "Convert color";
    }
    {
      mode = "n";
      key = "<leader>ct";
      action = "<cmd>CccHighlighterToggle<CR>";
      options.desc = "Toggle color preview";
    }

    #######################
    # MISC
    #######################
    {
      mode = "n";
      key = "<leader>pt";
      action = "<cmd>Telescope planets<cr>";
      options.desc = "Planets";
    }
    {
      mode = "n";
      key = "<leader>hm";
      action = "<cmd>Telescope man_pages<cr>";
      options.desc = "Man pages";
    }
    {
      mode = "n";
      key = "<leader>hl";
      action = "<cmd>Telescope highlights<cr>";
      options.desc = "Highlights";
    }
    {
      mode = "n";
      key = "<leader>;";
      action = "<cmd>Telescope resume<cr>";
      options.desc = "Resume Telescope";
    }
  ];
}
