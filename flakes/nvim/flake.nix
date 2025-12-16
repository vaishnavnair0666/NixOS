{
  description = "Neovim config using nixvim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixvim, ... }: {
    homeManagerModules.default = {
      imports = [
        nixvim.homeModules.nixvim

        ./modules/keymaps.nix
        ./modules/plugins/cmp.nix
        ./modules/plugins/dashboard.nix
        ./modules/plugins/formatters.nix
        ./modules/plugins/git.nix
        ./modules/plugins/harpoon.nix
        ./modules/plugins/lsp.nix
        ./modules/plugins/notify.nix
        ./modules/plugins/telescope.nix
        ./modules/plugins/testers.nix
        ./modules/plugins/toggleterm.nix
        ./modules/plugins/tools.nix
        ./modules/plugins/ui.nix
        ./modules/plugins/which-key.nix
      ];
    };
  };
}
