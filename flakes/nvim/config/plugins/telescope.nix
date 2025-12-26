{ ... }: {
  plugins = {
    telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
        media-files.enable = true;
        undo.enable = true;
      };

      settings = {
        defaults = {
          layout_strategy = "flex";
          sorting_strategy = "ascending";
          layout_config = {
            prompt_position = "top";
            height = 0.94;
            width = 0.90;
          };

          borderchars = [ "─" "│" "─" "│" "╭" "╮" "╯" "╰" ];

          file_ignore_patterns = [
            "node_modules"
            ".git/"
            "dist"
            "build"
          ];
        };

        pickers = {
          find_files = { hidden = true; };
          live_grep = { }; # set later
          buffers = { show_all_buffers = true; sort_lastused = true; };
        };

      };
    };
  };
}
