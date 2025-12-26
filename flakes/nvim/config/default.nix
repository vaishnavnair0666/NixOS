{
  _module.args.nixvimModule = {
    imports = [
      ./keymaps.nix
      ./plugins/aerial.nix
      ./plugins/cmp.nix
      ./plugins/conform.nix
      ./plugins/dashboard.nix
      ./plugins/git.nix
      ./plugins/harpoon.nix
      ./plugins/lsp.nix
      ./plugins/lspsaga.nix
      ./plugins/notify.nix
      ./plugins/oil.nix
      # ./plugins/python.nix
      ./plugins/rust.nix
      ./plugins/scrollbar.nix
      ./plugins/telescope.nix
      ./plugins/testers.nix
      ./plugins/themes.nix
      ./plugins/toggleterm.nix
      ./plugins/tools.nix
      ./plugins/treesitter.nix
      ./plugins/trouble.nix
      ./plugins/typescript.nix
      ./plugins/ui.nix
      ./plugins/which-key.nix
      ./plugins/winbar.nix
    ];
  };
}
