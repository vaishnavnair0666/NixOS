{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    stylua
    shfmt
    taplo
    nixpkgs-fmt

    nixd
    nodePackages.prettier

    nodePackages.typescript
    nodePackages.typescript-language-server

    nodePackages.svelte-language-server

    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    nodePackages.bash-language-server

    lua-language-server
  ];
}

