{ pkgs, ... }:

{
  programs.nixvim.plugins = {
    # --- LSP Core ---
    lsp = {
      enable = true;

      # Optional global settings
      settings = {
        # Show inlay hints if supported by the language server
        inlayHints = true;
        # Configure diagnostic display
        diagnostics = {
          virtual_text = true;
          update_in_insert = false;
          underline = true;
          severity_sort = true;
        };
      };

      # --- Language Servers ---
      servers = {
        # TypeScript / JavaScript
        ts_ls = {
          enable = true;
          # Optional extra settings
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all";
                includeInlayFunctionParameterTypeHints = true;
                includeInlayVariableTypeHints = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayEnumMemberValueHints = true;
              };
            };
          };
        };

        # Svelte
        svelte = { enable = true; };

        # JSON
        jsonls = {
          enable = true;
          settings = {
            json = {
              schemas = "require('schemastore').json.schemas()";
              validate = { enable = true; };
            };
          };
        };

        # Nix
        nixd = {
          enable = true;
          settings = {
            nixd = {
              nix = {
                exprSymbols = true; # better symbol names in outline
              };
              # formatting = { command = null; }; # don't autoformat
            };
          };
        };

        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = { globals = [ "vim" ]; };
              workspace = {
                library =
                  [ "${"$"}VIMRUNTIME/lua" "${"$"}VIMRUNTIME/lua/vim/lsp" ];
                checkThirdParty = false;
              };
              telemetry = { enable = false; };
            };
          };
        };

        yamlls.enable = true;

        bashls.enable = true;

        html.enable = true;
        cssls.enable = true;
      };
    };
  };

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    schemastore-nvim
  ];

  programs.nixvim.extraConfigLua = ''
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  '';
}
