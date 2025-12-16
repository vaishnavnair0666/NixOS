{ ... }:

{
  programs.nixvim.globals.mapleader = " "; # <space> is leader
  # Example starter config
  programs.nixvim.opts = {
    number = true;
    relativenumber = false;
    tabstop = 4;
    shiftwidth = 4;
  };

  programs.nixvim = {
    colorscheme = "miniwinter";

    plugins = {
      # Statusline
      lualine.enable = true;

      # Buffer/tab UI
      bufferline = {
        enable = true;
        settings.options = {
          mode = "buffers";
          diagnostics = "nvim_lsp";
          separator_style = "slant";
          show_buffer_close_icons = true;
          show_close_icon = false;
          always_show_bufferline = true;
        };
      };

      # File explorer (correct way)
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        popupBorderStyle = "rounded";
        enableGitStatus = true;
        enableDiagnostics = true;

        window = {
          width = 30;
          mappings = {
            "<cr>" = "open";
            "o" = "open";
            "s" = "open_split";
            "v" = "open_vsplit";
            "t" = "open_tabnew";
            "q" = "close_window";
          };
        };

        filesystem = {
          filteredItems = {
            visible = false;
            hideDotfiles = true;
            hideGitignored = true;
          };
          followCurrentFile.enabled = true;
        };
      };

      # Editing helpers
      comment.enable = true;

      treesitter = {
        enable = true;
        settings.ensureInstalled =
          [ "nix" "lua" "javascript" "typescript" "svelte" "json" "markdown" ];
      };

      # UI niceties
      indent-blankline.enable = true;
      todo-comments.enable = true;
      fidget.enable = true;
    };
  };
}
