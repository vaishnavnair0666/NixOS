{ lib, ... }:

{
  plugins = {
    #  Snippet engine 
    luasnip.enable = true;
    friendly-snippets.enable = true;

    #  Completion engine 
    cmp = {
      enable = true;

      settings = {
        snippet.expand = ''
          function(args)
            require("luasnip").lsp_expand(args.body)
          end
        '';

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";

          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
        };

        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];

        formatting = {
          format = lib.mkForce {
            __raw = "require('lspkind').cmp_format({ mode = 'symbol_text' })";
          };
        };
      };
    };

    #  Icons / completion kinds 
    lspkind.enable = true;
  };

  plugins.lsp.capabilities = "require('cmp_nvim_lsp').default_capabilities()";
}
