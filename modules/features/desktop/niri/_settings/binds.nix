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

    "Super+Alt+S" = {
      _attrs = {allow-when-locked = true;};
      spawn-sh = "pkill orca || exec orca";
    };

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

    XF86AudioPlay.spawn-sh = "playerctl play-pause";
    XF86AudioStop.spawn-sh = "playerctl stop";
    XF86AudioPrev.spawn-sh = "playerctl previous";
    XF86AudioNext.spawn-sh = "playerctl next";

    XF86MonBrightnessUp.spawn = [(lib.getExe pkgs.brightnessctl) "--class=backlight" "set" "+10%"];

    XF86MonBrightnessDown.spawn = [(lib.getExe pkgs.brightnessctl) "--class=backlight" "set" "10%-"];

    "Mod+O".toggle-overview = null;
    "Mod+Q".close-window = null;

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

    "Mod+Page_Up".focus-workspace-up = null;
    "Mod+Page_Down".focus-workspace-down = null;

    "Mod+U".focus-workspace-down = null;
    "Mod+I".focus-workspace-up = null;

    "Mod+1".focus-workspace = 1;
    "Mod+2".focus-workspace = 2;
    "Mod+3".focus-workspace = 3;
    "Mod+4".focus-workspace = 4;
    "Mod+5".focus-workspace = 5;
    "Mod+6".focus-workspace = 6;
    "Mod+7".focus-workspace = 7;
    "Mod+8".focus-workspace = 8;
    "Mod+9".focus-workspace = 9;

    Print.screenshot = null;
    "Ctrl+Print".screenshot-screen = null;
    "Alt+Print".screenshot-window = null;

    "Mod+Shift+E".quit = null;
    "Ctrl+Alt+Delete".quit = null;

    "Mod+Shift+P".power-off-monitors = null;
  };
}
