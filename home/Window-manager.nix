{ config, ... }: {
  programs.niri.enable = true;

  programs.niri.animationsFragment =
    builtins.readFile ../modules/niri/fragments/animations.kdl;
  programs.niri.inputFragment =
    builtins.readFile ../modules/niri/fragments/input.kdl;
  programs.niri.keybindsFragment =
    builtins.readFile ../modules/niri/fragments/keybinds.kdl;
  programs.niri.layoutFragment =
    builtins.readFile ../modules/niri/fragments/layout.kdl;
  programs.niri.startupFragment =
    builtins.readFile ../modules/niri/fragments/startup.kdl;
  programs.niri.windowrulesFragment =
    builtins.readFile ../modules/niri/fragments/windowrules.kdl;
  home.file."wallpapers/default.jpg".source =
    ../modules/niri/wallpaper/default.jpg;
  programs.niri.wallpaperPath =
    "${config.home.homeDirectory}/wallpapers/default.jpg";
  programs.niri.outputFragment =
    builtins.readFile ../modules/niri/fragments/output.kdl;
}
