{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    schemastore.enable = true;
    lsp = {
      enable = true;

      servers = {
        ts_ls = { enable = true; };
        svelte.enable = true;
        jsonls = { enable = true; };
        nixd = {
          enable = true;
          settings = { nixd = { nix = { exprSymbols = true; }; }; };
        };
        lua_ls = { enable = true; };
        yamlls.enable = true;
        bashls.enable = true;
        html.enable = true;
        cssls.enable = true;
      };
    };
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [ nvim-lspconfig ];

  programs.nixvim.extraConfigLua = ''
        -- Configure diagnostics globally
        vim.diagnostic.config({
          virtual_text = true,
          update_in_insert = false,
          underline = true,
          severity_sort = true,
        })

        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    	 local lspconfig = require('lspconfig')

        lspconfig.jsonls.setup{
          cmd = { "vscode-json-language-server", "--stdio" }
        }

        lspconfig.html.setup{
          cmd = { "vscode-html-language-server", "--stdio" }
        }

        lspconfig.cssls.setup{
          cmd = { "vscode-css-language-server", "--stdio" }
        }
  '';
}
