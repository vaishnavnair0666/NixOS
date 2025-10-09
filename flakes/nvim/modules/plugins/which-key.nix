{ ... }: {
  programs.nixvim.plugins.which-key = {
    enable = true;

    settings = {
      # Which-key popup window
      win = {
        border = "rounded";
        padding = [ 1 2 ];
        no_overlap = true;
        title = true;
        title_pos = "center";
        zindex = 1000;
      };
      layout = {
        align = "right";
        spacing = 3;
        height = {
          min = 4;
          max = 15;
        };
        width = {
          min = 20;
          max = 50;
        };
      };
      plugins = { spelling.enabled = true; };

      # Keymaps organized by groups
      spec = [
        # FIND group
        {
          __unkeyed-1 = "<leader>f";
          group = "Find";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Search";
        }

        # GIT
        {
          __unkeyed-1 = "<leader>g";
          group = "GIT";
        }

        {
          __unkeyed-1 = "<leader>t";
          group = "Terminal";
        }

        {
          __unkeyed-1 = "<leader>h";
          group = "Harpoon";
        }

        {
          __unkeyed-1 = "<leadr>x";
          group = "Diagnostics";
        }

        {
          __unkeyed-1 = "<leader>k";
          group = "Keymaps";
        }

        {
          __unkeyed-1 = "<leader>m";
          group = "MAN";
        }

        {
          __unkeyed-1 = "<leader>n";
          group = "Noice";
        }

        # UI TOGGLES group
        {
          __unkeyed-1 = "<leader>u";
          group = "UI toggles";
        }
        {
          __unkeyed-1 = "<leader>un";
          __unkeyed-2 = ":set number!<CR>";
          desc = "Toggle line numbers";
        }
        {
          __unkeyed-1 = "<leader>ur";
          __unkeyed-2 = ":set relativenumber!<CR>";
          desc = "Toggle relative numbers";
        }
        {
          __unkeyed-1 = "<leader>uw";
          __unkeyed-2 = ":set wrap!<CR>";
          desc = "Toggle word wrap";
        }
        {
          __unkeyed-1 = "<leader>us";
          __unkeyed-2 = ":set spell!<CR>";
          desc = "Toggle spell check";
        }

        # FORMAT group
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
        }

        # Move between splits
        {
          __unkeyed-1 = "<C-h>";
          __unkeyed-2 = "<C-w>h";
          desc = "Move to left split";
        }
        {
          __unkeyed-1 = "<C-j>";
          __unkeyed-2 = "<C-w>j";
          desc = "Move to bottom split";
        }
        {
          __unkeyed-1 = "<C-k>";
          __unkeyed-2 = "<C-w>k";
          desc = "Move to top split";
        }
        {
          __unkeyed-1 = "<C-l>";
          __unkeyed-2 = "<C-w>l";
          desc = "Move to right split";
        }

        # Resize splits
        {
          __unkeyed-1 = "<leader><up>";
          __unkeyed-2 = ":resize +2<CR>";
          desc = "Increase split height";
        }
        {
          __unkeyed-1 = "<leader><down>";
          __unkeyed-2 = ":resize -2<CR>";
          desc = "Decrease split height";
        }
        {
          __unkeyed-1 = "<leader><left>";
          __unkeyed-2 = ":vertical resize -2<CR>";
          desc = "Decrease split width";
        }
        {
          __unkeyed-1 = "<leader><right>";
          __unkeyed-2 = ":vertical resize +2<CR>";
          desc = "Increase split width";
        }
        # Buffer navigation group
        {
          __unkeyed-1 = "<leader>b";
          group = "buffers";
        }

        # Switch between buffers
        {
          __unkeyed-1 = "<leader>bn";
          __unkeyed-2 = "<cmd>BufferLineCycleNext<CR>";
          desc = "Next buffer";
        }
        {
          __unkeyed-1 = "<leader>bp";
          __unkeyed-2 = "<cmd>BufferLineCyclePrev<CR>";
          desc = "Previous buffer";
        }

        # Reordering
        {
          __unkeyed-1 = "<leader>bm";
          __unkeyed-2 = "<cmd>BufferLineMoveNext<CR>";
          desc = "Move buffer right";
        }
        {
          __unkeyed-1 = "<leader>bh";
          __unkeyed-2 = "<cmd>BufferLineMovePrev<CR>";
          desc = "Move buffer left";
        }

        # Direct access (buffers 1-6)
        {
          __unkeyed-1 = "<leader>1";
          __unkeyed-2 = "<cmd>BufferLineGoToBuffer 1<CR>";
          desc = "Go to buffer 1";
        }
        {
          __unkeyed-1 = "<leader>2";
          __unkeyed-2 = "<cmd>BufferLineGoToBuffer 2<CR>";
          desc = "Go to buffer 2";
        }

        {
          __unkeyed-1 = "<leader>3";
          __unkeyed-2 = "<cmd>BufferLineGoToBuffer 3<CR>";
          desc = "Go to buffer 3";
        }
        {
          __unkeyed-1 = "<leader>4";
          __unkeyed-2 = "<cmd>BufferLineGoToBuffer 4<CR>";
          desc = "Go to buffer 4";
        }

        {
          __unkeyed-1 = "<leader>5";
          __unkeyed-2 = "<cmd>BufferLineGoToBuffer 5<CR>";
          desc = "Go to buffer 5";
        }

        {
          __unkeyed-1 = "<leader>6";
          __unkeyed-2 = "<cmd>BufferLineGoToBuffer 6<CR>";
          desc = "Go to buffer 6";
        }

        # Close
        {
          __unkeyed-1 = "<leader>bd";
          __unkeyed-2 = "<cmd>bdelete<CR>";
          desc = "Close buffer";
        }
        {
          __unkeyed-1 = "<leader>bo";
          __unkeyed-2 = "<cmd>BufferLineCloseOthers<CR>";
          desc = "Close other buffers";
        }
        #Explorer
        {
          __unkeyed-1 = "<leader>e";
          group = "explorer";
        }

        {
          __unkeyed-1 = "<leader>ee";
          __unkeyed-2 = "<cmd>Neotree toggle<CR>";
          desc = "Toggle Neo-tree";
        }
        {
          __unkeyed-1 = "<leader>ef";
          __unkeyed-2 = "<cmd>Neotree focus<CR>";
          desc = "Focus Neo-tree";
        }
        {
          __unkeyed-1 = "<leader>er";
          __unkeyed-2 = "<cmd>Neotree reveal<CR>";
          desc = "Reveal current file";
        }
      ];
    };
  };
}
