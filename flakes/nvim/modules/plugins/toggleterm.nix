{ pkgs, ... }: {
  programs.nixvim.plugins.toggleterm = {
    enable = true;

    settings = {
      direction = "float"; # other options: "horizontal", "vertical", "tab"
      shade_terminals = true;
      start_in_insert = true;
      close_on_exit = true;
      persist_mode = false;
      float_opts = {
        border = "curved";
        winblend = 5;
      };

    };
  };
  programs.nixvim.extraConfigLua = ''
    -- Basic ToggleTerm keybinding
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

    -- LazyGit keybinding in floating terminal
    vim.keymap.set("n", "<leader>gg", "<cmd>ToggleTerm direction=float cmd='lazygit'<CR>", {
      desc = "Open LazyGit (floating terminal)"
    })
  '';

}

