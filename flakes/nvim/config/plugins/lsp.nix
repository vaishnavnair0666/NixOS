{ ... }:

{
  plugins = {
    schemastore.enable = true;

    lsp = {
      enable = true;

      # Global diagnostics configuration
      diagnostics = {
        virtualText = true;
        updateInInsert = false;
        underline = true;
        severitySort = true;
      };

      servers = {
        ts_ls.enable = true;
        svelte.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
        bashls.enable = true;
        html.enable = true;
        cssls.enable = true;

        lua_ls.enable = true;

        nixd = {
          enable = true;
          settings = { nixd.nix.exprSymbols = true; };
        };
      };
    };
  };

  # LSP keymaps (correct layer)
  keymaps = [
    {
      mode = "n";
      key = "gd";
      action = "vim.lsp.buf.definition";
      options.desc = "Go to definition";
    }
    {
      mode = "n";
      key = "gr";
      action = "vim.lsp.buf.references";
      options.desc = "Find references";
    }
    {
      mode = "n";
      key = "K";
      action = "vim.lsp.buf.hover";
      options.desc = "Hover documentation";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "vim.lsp.buf.code_action";
      options.desc = "Code actions";
    }
    {
      mode = "n";
      key = "[d";
      action = "vim.diagnostic.goto_prev";
      options.desc = "Previous diagnostic";
    }
    {
      mode = "n";
      key = "]d";
      action = "vim.diagnostic.goto_next";
      options.desc = "Next diagnostic";
    }
  ];
}
