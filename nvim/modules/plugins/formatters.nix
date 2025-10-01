{ ... }: {
  programs.nixvim.plugins = {

    # Formatting
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
        };

        format_on_save = {
          lsp_fallback = true; # use LSP if formatter not found
          timeout_ms = 500; # avoid hangs
        };
      };
    };
    # Symbols outline
    aerial = {
      enable = true;
      settings = {
        layout = {
          default_direction = "right"; # or "left"
          min_width = 30;
        };
        backends = [ "lsp" "treesitter" ];
        show_guides = true;
      };
    };
  };
}
