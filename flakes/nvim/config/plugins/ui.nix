{ ... }:

{
  globals.mapleader = " "; # <space> is leader
  # Example starter config
  opts = {
    number = true;
    relativenumber = false;
    tabstop = 4;
    shiftwidth = 4;
  };
  colorscheme = "catppuccin";

  colorschemes.catppuccin.enable = true;

  colorschemes.catppuccin.settings = {
    flavour =
      "mocha"; # one of "latte", "frappe", "macchiato", "mocha", or "auto"
    integrations = {
      cmp = true;
      gitsigns = true;
      nvimtree = true;
      treesitter = true;
      notify = true;
      fidget = true;
    };
  };
  plugins = {
    web-devicons.enable = true;
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

    neo-tree = {
      enable = true;

      settings.window = {
        width = 30;
        popup_border_style = "rounded";
        enable_git_status = true;
        enable_diagnostics = true;
        close_if_last_window = true;
        mappings = {
          "<cr>" = "open";
          "o" = "open";
          "s" = "open_split";
          "v" = "open_vsplit";
          "t" = "open_tabnew";
          "q" = "close_window";
        };
      };

      # filesystem = {
      #   # filtered_items = {
      #   #   visible = false;
      #   #   hide_dotfiles = true;
      #   #   hide_gitignored = true;
      #   # };
      #   follow_current_file.enabled = true;
      # };
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
}
