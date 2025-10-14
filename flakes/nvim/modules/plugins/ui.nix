{ ... }: {
  programs.nixvim.colorscheme = "miniwinter";
  programs.nixvim.extraConfigLua =
    "	require(\"neo-tree\").setup({\n			close_if_last_window = true,\n			popup_border_style = \"rounded\",\n			enable_git_status = true,\n			enable_diagnostics = true,\n			window = {\n			width = 30,\n			mappings = {\n			[\"<cr>\"] = \"open\",\n			[\"o\"] = \"open\",\n			[\"s\"] = \"open_split\",\n			[\"v\"] = \"open_vsplit\",\n			[\"t\"] = \"open_tabnew\",\n			[\"q\"] = \"close_window\",\n			},\n			},\n			filesystem = {\n			filtered_items = {\n			visible = false,\n			hide_dotfiles = true,\n			hide_gitignored = true,\n			},\n			follow_current_file = {\n				enabled = true,\n			},\n			},\n	})\n";
  programs.nixvim.plugins = {
    lualine.enable = true;
    bufferline = {
      enable = true;
      settings = {
        options = {
          mode = "buffers"; # or "tabs"
          diagnostics = "nvim_lsp"; # show LSP errors/warnings in bufferline
          separator_style = "slant"; # "slant", "thick", "thin"
          show_buffer_close_icons = true;
          show_close_icon = false;
          always_show_bufferline = true;
        };
      };
    };
    neo-tree.enable = true;
    comment.enable = true;
    treesitter = {
      enable = true;
      settings.ensureInstalled =
        [ "nix" "lua" "javascript" "typescript" "svelte" "json" "markdown" ];
    };
    # UI niceties
    indent-blankline.enable = true;
    todo-comments.enable = true;
    fidget.enable = true;
  };
}
