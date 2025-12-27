{ pkgs, ... }:

{
  plugins.luasnip = {
    enable = true;

    fromVscode = [
      {
        paths = [
          "${pkgs.vimPlugins.friendly-snippets}/share/vim-plugins/friendly-snippets/snippets"
        ];
      }
    ];

    fromLua = [ ];

    settings = {
      enable_autosnippets = true;

      extOpts = {
        typescript = {
          active = {
            virt_text = [
              {
                hl_group = "DiagnosticHint";
                text = "<-";
              }
            ];
          };
        };
      };
    };

    luaConfig.post = ''
      local ls = require("luasnip")

      -- Jump forward / expand
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
            "n",
            false
          )
        end
      end, { desc = "LuaSnip: expand or jump" })

      -- Jump backward
      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { desc = "LuaSnip: jump backward" })

      -- ChoiceNode cycling
      vim.keymap.set("i", "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { desc = "LuaSnip: next choice" })

      vim.keymap.set("i", "<C-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { desc = "LuaSnip: previous choice" })

      -- Reload snippets without restart
      vim.api.nvim_create_user_command("LuaSnipReload", function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load()
        print("LuaSnip reloaded")
      end, {})

      -- Visual mode snippet expansion
      vim.keymap.set("v", "<leader>s", function()
        ls.snip_expand(ls.get_visual())
      end, { desc = "LuaSnip: expand selection" })
    '';
  };
}
