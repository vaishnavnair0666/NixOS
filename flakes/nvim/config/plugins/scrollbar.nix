{ ... }: {
  plugins.neoscroll = {
    enable = true;
    settings = {
      mappings = [ "<C-u>" "<C-d>" "<C-b>" "<C-f>" "<C-y>" "<C-e>" ];
      hide_cursor = false;
      stop_eof = true;
      use_local_scrolloff = true;
    };
  };

  plugins.mini = {
    enable = true;
    modules.animate = {
      cursor = { enable = true; };
      scroll = { enable = true; };
    };
  };

  plugins.scrollview.enable = true;
}

