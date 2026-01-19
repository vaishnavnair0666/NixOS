{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    cargo
    ccls
    chafa
    clang
    clang-tools
    cmake
    cppcheck
    deadnix
    direnv
    fzf
    gcc
    gnumake
    httpie # nice curl alternative
    jq
    lldb
    lldb
    llvmPackages.clang
    llvmPackages.libcxx
    llvmPackages.lldb
    lua-language-server
    marksman
    ngrok # expose localhost services
    nil
    nix-direnv
    nixfmt-classic
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # html/css/json eslint
    nodejs_22
    openssl # certs/dev crypto
    pciutils
    pnpm
    pyright
    pyright
    qt6.qtdeclarative
    rtkit
    rust-analyzer
    rustfmt
    statix
    stylua
    svelte-language-server
    valgrind
    vscode-extensions.vadimcn.vscode-lldb
  ];
}
