{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    stylua
    shfmt
    taplo
    nixpkgs-fmt
    prettier
    nixd

    nodePackages.typescript
    nodePackages.typescript-language-server

    nodePackages.svelte-language-server

    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    nodePackages.bash-language-server

    nodePackages.dockerfile-language-server-nodejs

    lua-language-server
  ];
}

