{ ... }:

{
  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;

        settings = {
          formattersByFt = {
            lua = [ "stylua" ];
            nix = [ "nixpkgs-fmt" ];
            javascript = [ "prettier" ];
            typescript = [ "prettier" ];
            svelte = [ "prettier" ];
            json = [ "prettier" ];
            markdown = [ "prettier" ];
            toml = [ "taplo" ];
            bash = [ "shfmt" ];
          };

          formatOnSave = {
            enabled = false;
            lspFallback = true;
            timeoutMs = 500;
          };
        };
      };

      # Symbols outline 
      aerial = {
        enable = true;
        settings = {
          layout = {
            defaultDirection = "right";
            minWidth = 30;
          };
          backends = [ "lsp" "treesitter" ];
          showGuides = true;
        };
      };
    };

    # Formatting keymaps 
    keymaps = [{
      mode = [ "n" "v" ];
      key = "<leader>w";
      action = "require('conform').format";
      options = { desc = "Format file or selection"; };
    }];
  };
}
