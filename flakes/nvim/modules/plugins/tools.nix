{ ... }: {
  programs.nixvim.plugins.ccc = {
    enable = true;

    settings = {
      highlighter = { auto_enable = true; };

      picker = {
        default_color = "#FFFFFF";
        format = "hex";
      };

      highlight_mode = "background";

      alpha = 0.1;
    };
  };
}

