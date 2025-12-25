{ ... }:

{
  plugins = {
    nui.enable = true;

    # Notification backend
    notify = {
      enable = true;
      settings = {
        stages = "fade_in_slide_out";
        timeout = 2000;
        render = "compact";
        top_down = false;
      };
    };

    # UI enhancements
    dressing = {
      enable = true;
      settings = {
        input = { border = "rounded"; };
        select = { backend = [ "telescope" "builtin" ]; };
      };
    };
    flash.enable = true;

    noice = {
      enable = true;
      settings = {
        lsp = {
          progress.enabled = true;
          hover.enabled = true;
          signature.enabled = true;
        };

        notify.enabled = true;
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };
        views = {
          cmdline_popup = { border = { style = "rounded"; }; };
          popupmenu = { border = { style = "rounded"; }; };
        };
      };
    };
  };

  # REQUIRED glue 
  extraConfigLuaPost = ''
    vim.notify = require("notify")
  '';
}
