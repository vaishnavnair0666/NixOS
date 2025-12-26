{ ... }: {
  plugins = {
    telescope = {
      enable = true;

      extensions = {
        file-browser = {
          enable = true;
          settings = {
            theme = "ivy";
            hijack_netrw = true;
            use_fd = true;
            git_status = true;
            hidden = true;
            depth = 2;
            mappings = {
              i = {
                "<A-c>" = "require('telescope._extensions.file_browser.actions').create";
                "<S-CR>" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
                "<A-r>" = "require('telescope._extensions.file_browser.actions').rename";
                "<A-m>" = "require('telescope._extensions.file_browser.actions').move";
                "<A-y>" = "require('telescope._extensions.file_browser.actions').copy";
                "<A-d>" = "require('telescope._extensions.file_browser.actions').remove";
                "<C-o>" = "require('telescope._extensions.file_browser.actions').open";
                "<C-g>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
                "<C-e>" = "require('telescope._extensions.file_browser.actions').goto_home_dir";
                "<C-w>" = "require('telescope._extensions.file_browser.actions').goto_cwd";
                "<C-t>" = "require('telescope._extensions.file_browser.actions').change_cwd";
                "<C-f>" = "require('telescope._extensions.file_browser.actions').toggle_browser";
                "<C-h>" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
                "<C-s>" = "require('telescope._extensions.file_browser.actions').toggle_all";
                "<bs>" = "require('telescope._extensions.file_browser.actions').backspace";
              };
              n = {
                "c" = "require('telescope._extensions.file_browser.actions').create";
                "r" = "require('telescope._extensions.file_browser.actions').rename";
                "m" = "require('telescope._extensions.file_browser.actions').move";
                "y" = "require('telescope._extensions.file_browser.actions').copy";
                "d" = "require('telescope._extensions.file_browser.actions').remove";
                "o" = "require('telescope._extensions.file_browser.actions').open";
                "g" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
                "e" = "require('telescope._extensions.file_browser.actions').goto_home_dir";
                "w" = "require('telescope._extensions.file_browser.actions').goto_cwd";
                "t" = "require('telescope._extensions.file_browser.actions').change_cwd";
                "f" = "require('telescope._extensions.file_browser.actions').toggle_browser";
                "h" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
                "s" = "require('telescope._extensions.file_browser.actions').toggle_all";
              };
            };
          };
        };
        fzf-native.enable = true;
        media-files.enable = true;
        undo.enable = true;
        frecency = {
          enable = true;
          settings = {
            db_root = "~/.cache/nvim/frecency";
            show_scores = true;
            auto_validate = false;
          };
        };
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
