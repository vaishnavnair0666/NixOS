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
          toml = [ "taplo" ];
          bash = [ "shfmt" ];
          markdown = [ "prettier" ];
        };

        format_on_save = {
          lsp_fallback = true; # use LSP if formatter not found
          timeout_ms = 500; # avoid hangs
          enabled = false;
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
  programs.nixvim.extraConfigLua = ''
    vim.keymap.set("n", "<leader>w", function()
    	require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format file" })

    vim.keymap.set("v", "<leader>wl", ":'<,'>!stylua -<CR>", { desc = "Format Lua" })
    vim.keymap.set("v", "<leader>wt", ":'<,'>!taplo fmt -<CR>", { desc = "Format TOML" })
    vim.keymap.set("v", "<leader>wj", ":'<,'>!prettier --parser json<CR>", { desc = "Format JSON" })
    vim.keymap.set("v", "<leader>wb", ":'<,'>!shfmt -i 2 -ci<CR>", { desc = "Format Bash" })
  '';
}
