{ ... }:

{
  plugins.neo-tree = {
    enable = true;

    settings = {
      close_if_last_window = true;

      filesystem = {
        bind_to_cwd = false;
        follow_current_file.enabled = true;
        use_libuv_file_watcher = true;
      };

      default_component_configs = {
        git_status = {
          symbols = {
            added = "+";
            modified = "~";
            deleted = "x";
            renamed = ">";
            untracked = "?";
            ignored = "i";
            unstaged = "u";
            staged = "s";
            conflict = "c";
          };
        };
      };
    };
  };

}

