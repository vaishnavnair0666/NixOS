{ pkgs, ... }: {
  programs.nixvim.plugins.toggleterm = {
    enable = true;

    settings = {
      direction = "float"; # other options: "horizontal", "vertical", "tab"
      shade_terminals = false;
      start_in_insert = true;
      close_on_exit = false;
      persist_mode = true;
      float_opts = {
        border = "curved";
        winblend = 0;
      };

    };
  };
  programs.nixvim.extraConfigLua = ''
    -- Basic ToggleTerm keybinding
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    vim.keymap.set("t", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal from Terminal Mode" })
  '';

}

