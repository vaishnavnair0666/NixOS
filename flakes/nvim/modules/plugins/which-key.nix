{ ... }:

{
  programs.nixvim.plugins.which-key = {
    enable = true;

    settings = {
      win = {
        border = "rounded";
        padding = [ 1 2 ];
        no_overlap = true;
        title = true;
        title_pos = "center";
        zindex = 1000;
      };

      layout = {
        align = "right";
        spacing = 3;
        height = {
          min = 4;
          max = 15;
        };
        width = {
          min = 20;
          max = 50;
        };
      };

      plugins.spelling.enabled = true;

      spec = [
        {
          __unkeyed-1 = "<leader>f";
          group = "Find";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>n";
          group = "Noice";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
        }
        {
          __unkeyed-1 = "<leader>h";
          group = "Help / History";
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffers";
        }
        {
          __unkeyed-1 = "<leader>e";
          group = "Explorer";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Tools";
        }
      ];
    };
  };
}
