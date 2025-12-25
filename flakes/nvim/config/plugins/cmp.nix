{ ... }:

{
  plugins.cmp = {
    enable = true;

    autoLoad = true;

    settings = {
      snippet.expand = "luasnip";

      cmdline = {
        "/" = {
          mapping = "cmp.mapping.preset.cmdline()";
          sources = [{ name = "buffer"; }];
        };

        ":" = {
          mapping = "cmp.mapping.preset.cmdline()";
          sources = [ { name = "path"; } { name = "cmdline"; } ];
        };
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
        { name = "nvim_lsp_signature_help"; }
      ];

      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";

        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";

        # scroll docs
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";

        # Supertab-style snippet / completion jumping
        "<Tab>" = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end
        '';

        "<S-Tab>" = ''
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end
        '';
      };
    };
  };
  plugins.nvim-autopairs = { enable = true; };

  plugins.cmp.settings.luaConfig.post = ''
    local cmp = require("cmp")
    local autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", autopairs.on_confirm_done())
  '';
  # Source plugins
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-nvim-lsp-signature-help.enable = true;
  plugins.cmp-cmdline.enable = true;
  plugins.luasnip = {
    enable = true;

    # fromVscode = [{
    #   path =
    #     "${pkgs.vimPlugins.friendly-snippets}/share/vim-plugins/friendly-snippets/snippets";
    # }];
  };
}
