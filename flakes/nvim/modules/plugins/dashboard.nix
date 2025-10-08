{ ... }: {
  programs.nixvim.plugins = {
    mini = {
      enable = true;

      # modules is an attrset (key-value set)
      modules = {
        icons = { }; # enable icons module
        starter = { }; # simple start screen
        surround = {
          mappings = {
            add = "<leader>sa";
            delete = "<leader>sd";
            find = "<leader>sf";
            replace = "<leader>sr";
          };
        };
      };

      # mockDevIcons is a top-level option
      mockDevIcons = true;
    };
  };
}
