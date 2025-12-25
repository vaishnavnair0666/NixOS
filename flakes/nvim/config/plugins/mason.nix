{ ... }:

{
  plugins = {
    mason.enable = true;

    mason-lspconfig = {
      enable = true;
      ensureInstalled = [
        "lua_ls"
        "ts_ls"
        "html"
        "cssls"
        "jsonls"
        "bashls"
        "nil_ls"
        "pyright"
        # "ruff_lsp"
        "rust_analyzer"
      ];
    };

    mason-tool-installer = {
      enable = true;
      ensureInstalled = [
        "stylua"
        "prettier"
        "shfmt"
        "ruff"
        "jq"
      ];
    };
  };
}
