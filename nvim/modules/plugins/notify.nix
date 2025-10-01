{ ... }: {
  programs.nixvim.plugins = {

    # Noice + Notify integration
    noice = {
      enable = true;
      settings = {
        lsp = {
          progress = { enabled = true; };
          hover = { enabled = true; };
          signature = { enabled = true; };
        };
        presets = {
          bottom_search = true; # replaces `/` cmdline with bottom popup
          command_palette = true; # cmdline + popupmenu together
          long_message_to_split = true; # large msgs into split
          inc_rename = true;
          lsp_doc_border = true;
        };
      };
    };

    nui.enable = true;

    notify = {
      enable = true;
      settings = {
        stages = "fade_in_slide_out";
        timeout = 2000; # ms
        render = "compact";
        top_down = false;
      };
    };

    dressing.enable = true; # Motion/navigation
    flash = { enable = true; };
  };
}
