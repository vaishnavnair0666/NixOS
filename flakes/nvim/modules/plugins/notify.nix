{ ... }:

{
  programs.nixvim.plugins = {
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
    dressing.enable = true;
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
      };
    };
  };

  # REQUIRED glue 
  programs.nixvim.extraConfigLua = ''
    vim.notify = require("notify")
  '';
}
