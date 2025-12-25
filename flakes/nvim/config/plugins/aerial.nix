{ ... }:

{
  plugins.aerial = {
    enable = true;

    settings = {
      backends = [ "lsp" "treesitter" ];
      layout = {
        defaultDirection = "right";
        minWidth = 32;
      };
      show_guides = true;
    };
  };
}

