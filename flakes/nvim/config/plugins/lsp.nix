{ ... }:

{
  plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps = {
      lspBuf = {
        K = "hover";
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
          key = "gd";
          mode = [ "n" ];
          action.__raw = "require('telescope.builtin').lsp_definitions";
        }
        {
          key = "gr";
          mode = [ "n" ];
          action.__raw = "require('telescope.builtin').lsp_references";
        }
        {
          key = "gi";
          mode = [ "n" ];
          action.__raw = "require('telescope.builtin').lsp_implementations";
        }
        {
          key = "gt";
          mode = [ "n" ];
          action.__raw = "require('telescope.builtin').lsp_type_definitions";
        }
        {
          key = "<leader>ds";
          mode = [ "n" ];
          action.__raw = "require('telescope.builtin').lsp_document_symbols";
        }
        {
          key = "<leader>ws";
          mode = [ "n" ];
          action.__raw =
            "require('telescope.builtin').lsp_dynamic_workspace_symbols";
        }
        {
          key = "gh";
          mode = [ "n" ];
          action = "<cmd>Lspsaga hover_doc<CR>";
        }
        {
          key = "<leader>ca";
          mode = [ "n" ];
          action = "<cmd>Lspsaga code_action<CR>";
        }
        {
          key = "<leader>rn";
          mode = [ "n" ];
          action = "<cmd>Lspsaga rename<CR>";
        }
        {
          key = "<leader>gg";
          mode = [ "n" ];
          action = "<cmd>Lspsaga finder<CR>";
        }
        {
          key = "<leader>xx";
          mode = [ "n" ];
          action = "<cmd>Trouble diagnostics toggle<CR>";
        }
        {
          key = "<leader>xo";
          mode = [ "n" ];
          action = "<cmd>Trouble quickfix toggle<CR>";
        }
        {
          key = "<leader>o";
          mode = [ "n" ];
          action = "<cmd>AerialToggle!<CR>";
        }
      ];
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
      yamlls.enable = true;
      qmlls.enable = true;
      html.enable = true;
      cssls.enable = true;
      tailwindcss.enable = true;
      emmet_ls.enable = true;
      ts_ls.enable = true;
      eslint.enable = true;
      jsonls.enable = true;
      bashls.enable = true;
      # rust_analyzer = {
      #   enable = true;
      #   settings = {
      #     checkOnSave.command = "clippy";
      #   };
      # };
      jdtls.enable = true;
      clangd.enable = true;

      nixd.enable = true;
      nixd.settings = {
        nixd = {
          formatting.command = [ "nixfmt" ];

          options = {
            nixos = {
              expr =
                "(import <nixpkgs/nixos> { configuration = /etc/nixos/configuration.nix; })";
            };

            home_manager = {
              expr =
                "(import <home-manager/modules> { config = {}; pkgs = import <nixpkgs> {}; })";
            };

            nixpkgs = { expr = "(import <nixpkgs> {})"; };
          };
        };
      };
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
}
