{ ... }:

{
  programs.nixvim.plugins.dashboard = {
    enable = true;

    settings = {
      theme = "doom";

      config = {
        header = [
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██║██║ ██╔╝██║   ██║██║████╗ ████║"
          "██╔██╗ ██║██║█████╔╝ ██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██║██╔═██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║██║██║  ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ];

        center = [
          {
            icon = " ";
            desc = "Find File";
            key = "f";
            action = "Telescope find_files";
          }
          {
            icon = " ";
            desc = "Recent Files";
            key = "r";
            action = "Telescope oldfiles";
          }
          {
            icon = " ";
            desc = "File Browser";
            key = "e";
            action = "Neotree toggle";
          }
          {
            icon = " ";
            desc = "Quit";
            key = "q";
            action = "qa";
          }
        ];

        footer = [ "NixOS • Neovim • Declarative" ];
      };
    };
  };
}
