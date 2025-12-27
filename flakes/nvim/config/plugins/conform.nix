{ pkgs, ... }:

{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        javascript = [ "biome" ];
        typescript = [ "biome" ];
        javascriptreact = [ "biome" ];
        typescriptreact = [ "biome" ];
        json = [ "biome" ];
        jsonc = [ "biome" ];

        rust = [ "rustfmt" ];
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];

        lua = [ "stylua" ];
        nix = [ "nixpkgs_fmt" ];
        svelte = [ "prettier" ];
        vue = [ "prettier" ];
        html = [ "prettier" ];
        css = [ "prettier" ];
        markdown = [ "prettier" ];
        toml = [ "taplo" ];
        bash = [ "shfmt" ];

        # OPTIONAL: DPRINT (multi-lang super fast)
        # If you want, uncomment:
        # javascript = [ "dprint" "biome" ];
        # typescript = [ "dprint" "biome" ];
      };

      format_on_save = {
        timeout_ms = 3000;
        lsp_fallback = false;
      };

      formatters = {
        prettier = {
          condition = ''
            function(ctx)
              return vim.uv.fs_stat(ctx.dirname .. "/.prettierrc")
                or vim.uv.fs_stat(ctx.dirname .. "/.prettierrc.json")
                or vim.uv.fs_stat(ctx.dirname .. "/.prettierrc.js")
                or vim.uv.fs_stat(ctx.dirname .. "/prettier.config.js")
                or vim.uv.fs_stat(ctx.dirname .. "/.prettierrc.yaml")
            end
          '';
        };

        biome = {
          command = "${pkgs.biome}/bin/biome";
          condition = ''
            function(ctx)
              return vim.uv.fs_stat(ctx.dirname .. "/biome.json")
                or vim.uv.fs_stat(ctx.dirname .. "/biome.jsonc")
                or vim.uv.fs_stat(ctx.dirname .. "/biome.config.js")
            end
          '';
        };
      };
    };
  };

  plugins.lsp.luaConfig.post = ''
      local conform = require("conform")
      local format_on = true

      vim.keymap.set("n", "<leader>uf", function()
    		  format_on = not format_on
    		  vim.g.conform_format_on_save = format_on
    		  print("Format-on-save: " .. tostring(format_on))
    		  end, { desc = "Toggle format-on-save" })
      vim.keymap.set({ "v" }, "<leader>fs", function()
    		  require("conform").format({ range = true, async = true })
    		  end, { desc = "Format selection" })
      vim.api.nvim_create_autocmd("BufWritePre", {
    		  callback = function(args)
    		  if vim.g.conform_format_on_save == false then return end
    		  conform.format({ bufnr = args.buf })
    		  end,
    		  })
  '';
}
