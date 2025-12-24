{ ... }:

{
  plugins = {
    conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
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

        format_on_save = {
          enabled = true;
          lsp_fallback = true;
          timeout_ms = 500;
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
}
