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

      silent = true;
    };

    servers = {
      lua_ls = {
        enable = true;
        settings = {
          Lua = {
            diagnostics = { globals = [ "vim" ]; };
            workspace = { checkThirdParty = false; };
          };
        };
      };

      ts_ls.enable = true; # renamed from tsserver -> ts_ls
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

  # Completion source for LSP
  plugins.cmp-nvim-lsp.enable = true;
}
