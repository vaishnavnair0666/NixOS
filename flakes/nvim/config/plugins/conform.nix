{ ... }:

{
  plugins.conform-nvim = {
    enable = true;

    settings = {

      format_on_save = {
        lspFallback = true;
        timeoutMs = 2000;
      };
      formatters_by_ft = {
        lua = [ "stylua" ];
        javascript = [ "prettier" ];
        typescript = [ "prettier" ];
        json = [ "prettier" ];
        markdown = [ "prettier" ];
        svelte = [ "prettier" ];
        bash = [ "shfmt" ];
        nix = [ "nixfmt" ];
      };
    };
  };
}
