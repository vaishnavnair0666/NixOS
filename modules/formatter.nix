{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Lua formatter
    stylua

    # Nix formatter
    nixpkgs-fmt

    nixd
    # JS/TS/Svelte/JSON/Markdown formatter
    nodePackages.prettier

    # JS/TS
    nodePackages.typescript
    nodePackages.typescript-language-server

    # Svelte
    nodePackages.svelte-language-server

    # JSON / YAML
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server

    # Bash
    nodePackages.bash-language-server

    # Lua
    lua-language-server
  ];
}

