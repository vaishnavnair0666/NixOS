{ ... }:

{
  globals.mapleader = " "; # <space> is leader
  opts = {
    number = true;
    relativenumber = false;
    tabstop = 4;
    shiftwidth = 4;
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

    # Editing helpers
    comment.enable = true;

    # UI niceties
    indent-blankline.enable = true;
    todo-comments.enable = true;
    fidget.enable = true;
  };
}
