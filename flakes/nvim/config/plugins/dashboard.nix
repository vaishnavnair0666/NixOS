{ ... }:

{
  plugins.alpha = {
    enable = true;

    settings = {
      layout = [
        {
          type = "padding";
          val = 2;
        }

        {
          type = "text";
          val = [
            "░▒▓███████▓▒░  ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓███████▓▒░  ░▒▓████████▓▒░ "
            "░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒░        "
            "░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒░        "
            "░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓██████▓▒░   "
            "░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒░        "
            "░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒  ▒▓█▓▒░ ░▒▓█▓▒░        "
            "░▒▓███████▓▒░   ░▒▓██████▓▒░  ░▒▓███████▓▒░  ░▒▓████████▓▒░ "
          ];
          opts = {
            position = "center";
            hl = "AlphaHeader";
          };
        }

        {
          type = "padding";
          val = 2;
        }

        {
          type = "group";
          opts = { spacing = 1; };
          val = [
            {
              type = "button";
              val = "  New file        ";
              on_press = { __raw = "function() vim.cmd('enew') end"; };
              opts = {
                position = "center";
                width = 40;
                shortcut = "n";
                align_shortcut = "right";
                hl = "AlphaButtons";
              };
            }
            {
              type = "button";
              val = "󰈞  Find file      ";
              on_press = {
                __raw = "function() vim.cmd('Telescope find_files') end";
              };
              opts = {
                position = "center";
                width = 40;
                shortcut = "f";
                align_shortcut = "right";
              };
            }
            {
              type = "button";
              val = "󰊄  Recent files   ";
              on_press = {
                __raw = "function() vim.cmd('Telescope oldfiles') end";
              };
              opts = {
                position = "center";
                width = 40;
                shortcut = "r";
                align_shortcut = "right";
              };
            }
            {
              type = "button";
              val = "󰗼  Quit           ";
              on_press = { __raw = "function() vim.cmd('qa') end"; };
              opts = {
                position = "center";
                width = 40;
                shortcut = "q";
                align_shortcut = "right";
              };
            }
          ];
        }

        {
          type = "padding";
          val = 2;
        }

        {
          type = "text";
          val = "Built with Nix • Neovim ready";
          opts = {
            position = "center";
            hl = "AlphaFooter";
          };
        }
      ];
    };
  };
}
