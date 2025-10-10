{ pkgs, ... }:

{
  programs.nixvim = {
    plugins = {
      # --- Completion Engine ---
      cmp = {
        enable = true;
        settings = {
          snippet = {
            # Use LuaSnip for snippet expansion
            expand =
              "function(args) require('luasnip').lsp_expand(args.body) end";
          };

          # Keymaps for completion & snippets
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";

            "<Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require("luasnip")
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          };

          # Sources for completion
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "nvim_lua"; }
          ];

          # Add pretty icons
          formatting = {
            format =
              "function(entry, vim_item) return require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item) end";
          };
        };
      };

      # --- Snippet Engine ---
      luasnip.enable = true;

      # --- Icons ---
      lspkind.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [ friendly-snippets ];

    extraConfigLua = ''
      -- Load VSCode-style snippets (LuaSnip)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Optional: load your own custom snippets
      -- require("luasnip.loaders.from_vscode").lazy_load({
      --   paths = { vim.fn.stdpath("config") .. "/LuaSnip/" }
      -- })
    '';
  };
}
