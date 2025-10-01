{ ... }: {
  programs.nixvim.plugins = {

    mini = {
      enable = true;
      modules.icons = { mockDevIcons = true; };
      modules.starter = { };
      modules.surround = {
        mappings = {
          add = "<leader>sa";
          delete = "<leader>sd";
          find = "<leader>sf";
          replace = "<leader>sr";
        };
      }; # editing quotes, tags, etc.
    };
  };
}
