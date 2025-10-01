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
        # FILE group
        {
          __unkeyed-1 = "<leader>f";
          group = "File";
        }
        {
          __unkeyed-1 = "<leader>ff";
          __unkeyed-2 = "<cmd>Telescope find_files<cr>";
          desc = "Find files";
        }
        {
          __unkeyed-1 = "<leader>fg";
          __unkeyed-2 = "<cmd>Telescope live_grep<cr>";
          desc = "Live grep";
        }
        {
          __unkeyed-1 = "<leader>fb";
          __unkeyed-2 = "<cmd>Telescope buffers<cr>";
          desc = "Buffers";
        }
        {
          __unkeyed-1 = "<leader>fh";
          __unkeyed-2 = "<cmd>Telescope help_tags<cr>";
          desc = "Help tags";
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
        {
          __unkeyed-1 = "<leader>cf";
          __unkeyed-2 =
            "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>";
          desc = "Format file";
        }
        {
          __unkeyed-1 = "<leader>ci";
          __unkeyed-2 = "gg=G``";
          desc = "Re-indent whole file";
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

        # Direct access (buffers 1-9)
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
