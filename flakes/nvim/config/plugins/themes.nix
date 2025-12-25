{ lib, ... }:

{
  colorschemes = {
    catppuccin.enable = true;
    tokyonight.enable = true;
    gruvbox.enable = true;
    nord.enable = true;
    onedark.enable = true;
  };
  colorscheme = lib.mkForce "catppuccin";
  extraConfigLuaPost = ''
    local themes = { "nord","onedark", "catppuccin", "tokyonight", "gruvbox" }
    local index = 1

    vim.keymap.set("n", "<leader>ut", function()
      index = index % #themes + 1
      vim.cmd.colorscheme(themes[index])
      print("Theme: " .. themes[index])
    end, { desc = "Switch Theme" })
  '';
}

