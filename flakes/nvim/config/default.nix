{
  _module.args.nixvimModule = {
    imports = [
      ./keymaps.nix
      ./plugins/ui.nix
      ./plugins/cmp.nix
      ./plugins/git.nix
      ./plugins/toggleterm.nix
      ./plugins/lsp.nix
      ./plugins/tools.nix
      ./plugins/notify.nix
      ./plugins/harpoon.nix
      ./plugins/testers.nix
      ./plugins/dashboard.nix
      ./plugins/telescope.nix
      ./plugins/which-key.nix
      ./plugins/formatters.nix
    ];
  };
}
