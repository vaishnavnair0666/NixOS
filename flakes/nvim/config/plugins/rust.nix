{ ... }:

{
  plugins.rustaceanvim = {
    enable = true;

    settings.server = {
      on_attach.__raw = "function(_, _) end";
      default_settings.rust_analyzer.inlayHints.enable = true;
    };
  };
}

