{
  pkgs,
  lib,
  self',
  ...
}: let
  noctaliaExe = lib.getExe self'.packages.myNoctalia;
in {
  binds = {
    "Mod+Shift+Slash".show-hotkey-overlay = null;

    "Mod+T".spawn = lib.getExe pkgs.foot;
    "Mod+Shift+T".spawn = lib.getExe pkgs.alacritty;

    "Mod+D".spawn-sh = "${noctaliaExe} ipc call launcher toggle";

    "Super+Alt+L".spawn = lib.getExe pkgs.swaylock;

    XF86AudioRaiseVolume = {
      _attrs = {allow-when-locked = true;};
      spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
    };

    XF86AudioLowerVolume = {
      _attrs = {allow-when-locked = true;};
      spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
    };

    XF86AudioMute = {
      _attrs = {allow-when-locked = true;};
      spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    };

    XF86AudioMicMute = {
      _attrs = {allow-when-locked = true;};
      spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    };

    XF86AudioPlay.spawn = [(lib.getExe pkgs.playerctl) "play-pause"];
    XF86AudioStop.spawn = [(lib.getExe pkgs.playerctl) "stop"];
    XF86AudioPrev.spawn = [(lib.getExe pkgs.playerctl) "previous"];
    XF86AudioNext.spawn = [(lib.getExe pkgs.playerctl) "next"];

    XF86MonBrightnessUp.spawn = [(lib.getExe pkgs.brightnessctl) "--class=backlight" "set" "+10%"];

    XF86MonBrightnessDown.spawn = [(lib.getExe pkgs.brightnessctl) "--class=backlight" "set" "10%-"];

    "Mod+O".toggle-overview = null;
    "Mod+Q".close-window = null;

    "Mod+W".toggle-column-tabbed-display = null;
    "Mod+BracketLeft".consume-or-expel-window-left = null;
    "Mod+BracketRight".consume-or-expel-window-right = null;

    "Mod+F".maximize-column = null;
    "Mod+Shift+F".fullscreen-window = null;
    "Mod+R".switch-preset-column-width = null;
    "Mod+Shift+R".switch-preset-window-height = null;

    "Mod+C".center-column = null;

    "Mod+V".toggle-window-floating = null;
    "Mod+Shift+V".switch-focus-between-floating-and-tiling = null;

    "Mod+Left".focus-column-left = null;
    "Mod+Right".focus-column-right = null;
    "Mod+Up".focus-window-up = null;
    "Mod+Down".focus-window-down = null;

    "Mod+H".focus-column-left = null;
    "Mod+J".focus-window-down = null;
    "Mod+K".focus-window-up = null;
    "Mod+L".focus-column-right = null;

    "Mod+Ctrl+Left".move-column-left = null;
    "Mod+Ctrl+Right".move-column-right = null;
    "Mod+Ctrl+Up".move-window-up = null;
    "Mod+Ctrl+Down".move-window-down = null;

    "Mod+Ctrl+H".move-column-left = null;
    "Mod+Ctrl+J".move-window-down = null;
    "Mod+Ctrl+K".move-window-up = null;
    "Mod+Ctrl+L".move-column-right = null;

    "Mod+Shift+H".set-column-width = "-5%";
    "Mod+Shift+L".set-column-width = "+5%";
    "Mod+Shift+J".set-window-height = "-5%";
    "Mod+Shift+K".set-window-height = "+5%";

    "Mod+Shift+Left".set-column-width = "-5%";
    "Mod+Shift+Right".set-column-width = "+5%";
    "Mod+Shift+Down".set-window-height = "-5%";
    "Mod+Shift+Up".set-window-height = "+5%";

    "Mod+Page_Up".focus-workspace-up = null;
    "Mod+Page_Down".focus-workspace-down = null;

    "Mod+U".focus-workspace-up = null;
    "Mod+I".focus-workspace-down = null;

    "Mod+Shift+U".move-workspace-up = null;
    "Mod+Shift+I".move-workspace-down = null;

    Print.screenshot = null;
    "Ctrl+Print".screenshot-screen = null;
    "Alt+Print".screenshot-window = null;

    "Mod+Shift+E".quit = null;
    "Ctrl+Alt+Delete".quit = null;

    "Mod+Shift+P".power-off-monitors = null;
  };
}
