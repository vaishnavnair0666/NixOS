{
  description = "Neovim config using nixvim";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixvim, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      # Home-Manager module exposing Neovim
      homeManagerModules.default = {
        imports = [
          nixvim.homeModules.nixvim
          ./modules/keymaps.nix
          ./modules/plugins/cmp.nix
          ./modules/plugins/lsp.nix
          ./modules/plugins/dashboard.nix
          ./modules/plugins/testers.nix
          ./modules/plugins/formatters.nix
          ./modules/plugins/notify.nix
          ./modules/plugins/ui.nix
          ./modules/plugins/which-key.nix

        ];

        programs.nixvim.enable = true;
        #			programs.nixvim.nixpkgs.useGlobalPackages = true;

        programs.nixvim.globals.mapleader = " "; # <space> is leader
        # Example starter config
        programs.nixvim.opts = {
          number = true;
          relativenumber = false;
          tabstop = 4;
          shiftwidth = 4;
        };
        programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
          vim-dadbod
          vim-dadbod-ui
          vim-dadbod-completion
          vim-pandoc
          vim-pandoc-syntax
        ];
      };
    };
}

