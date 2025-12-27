{ lib, pkgs, ... }:

{
  plugins.cmp = {
    enable = true;
    autoLoad = true;
    settings = {
      snippet.expand = "luasnip";
      sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "luasnip"; }
        { name = "buffer"; }
        { name = "path"; }
        { name = "nvim_lua"; }
        { name = "treesitter"; }
        { name = "emoji"; }
        { name = "calc"; }
        { name = "git"; }
        { name = "npm"; }
        { name = "dap"; }
      ];

      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";

        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";

        "<Tab>" = ''
          function(fallback)
            local cmp = require("cmp")
            local luasnip = require("luasnip")
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
            local cmp = require("cmp")
            local luasnip = require("luasnip")
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

      formatting = {
        fields = [ "kind" "abbr" "menu" ];
      };

      window = {
        completion.border = "rounded";
        documentation.border = "rounded";
      };

      experimental = {
        ghost_text = true;
      };

      cmdline = {
        "/" = {
          mapping = "cmp.mapping.preset.cmdline()";
          sources = [{ name = "buffer"; }];
        };

        ":" = {
          mapping = "cmp.mapping.preset.cmdline()";
          sources = [
            { name = "path"; }
            { name = "cmdline"; }
          ];
        };
      };
    };

    luaConfig.post = ''
      local cmp = require("cmp")
      local autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", autopairs.on_confirm_done())
    '';
  };


  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-nvim-lsp-signature-help.enable = true;
  plugins.cmp-nvim-lua.enable = true;
  plugins.cmp-buffer.enable = true;
  plugins.cmp-path.enable = true;
  plugins.cmp-cmdline.enable = true;
  plugins.cmp-treesitter.enable = true;
  plugins.cmp-emoji.enable = true;
  plugins.cmp-calc.enable = true;
  plugins.cmp-git.enable = true;
  plugins.cmp-npm.enable = true;
  plugins.cmp-dap.enable = true;

  plugins.nvim-autopairs.enable = true;

}
