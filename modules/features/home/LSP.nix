{...}: {
  flake.nixosModules.hm-lsp = {
    user,
    pkgs,
    ...
  }: {
    home-manager.users.${user} = {
      home.packages = with pkgs; [
        lua-language-server
        nil
        nixd
        nixfmt
        nix-direnv
        nixpkgs-fmt
        shfmt
        rust-analyzer
        clang-tools
        pyright
        typescript-language-server

        stylua
        alejandra
        black
        prettierd

        nodejs
        eslint
      ];
    };
  };
}
