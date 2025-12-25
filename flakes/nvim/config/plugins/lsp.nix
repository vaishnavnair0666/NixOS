{ ... }:

{
  plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps = {
      lspBuf = {
        gd = "definition";
        K = "hover";
        gr = "references";
        rn = "rename";
        ca = "code_action";
        f = "format";
      };

      diagnostic = {
        "]d" = "goto_next";
        "[d" = "goto_prev";
      };
      extra = [
        {
          key = "Gd";
          action.__raw = "require('telescope.builtin').lsp_definitions";
          mode = [ "n" ];
        }
        {
          key = "Gr";
          action.__raw = "require('telescope.builtin').lsp_references";
          mode = [ "n" ];
        }
        {
          key = "Gi";
          action.__raw = "require('telescope.builtin').lsp_implementations";
          mode = [ "n" ];
        }
        {
          key = "Gt";
          action.__raw = "require('telescope.builtin').lsp_type_definitions";
          mode = [ "n" ];
        }
      ];
      silent = true;
    };

    servers = {
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            diagnostics = {
              globals = [ "vim" ];
            };
            workspace = {
              checkThirdParty = false;
            };
          };
        };
      };

      html.enable = true;
      cssls.enable = true;
      jsonls.enable = true;
      bashls.enable = true;
      nil_ls.enable = true;
    };

    luaConfig.post = ''
      -- Optional final tweaks
      vim.diagnostic.config({
        underline = true,
        virtual_text = { spacing = 2, prefix = "●" },
        signs = true,
        severity_sort = true,
      })
    '';
  };
  plugins.schemastore.enable = true;
  # Completion source for LSP
  plugins.cmp-nvim-lsp.enable = true;
}
