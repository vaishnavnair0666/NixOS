{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    cargo
    gnumake
    direnv
    nix-direnv
    nodejs_22
    pnpm
    jq
    # 🛠️ Language Servers (for IDEs / Neovim / VSCode)
    nixfmt-classic
    svelte-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # html/css/json eslint
    nodePackages.eslint
    nodePackages.prettier
    # ⚡ Extra Dev Stuff
    httpie # nice curl alternative
    ngrok # expose localhost services
    openssl # certs/dev crypto
  ];
}

