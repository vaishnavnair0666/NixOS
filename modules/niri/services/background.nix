# Add into your home-manager or programs.niri-enabled module
{ config, pkgs, lib, ... }:

let
  systemdUser = {
    # wl-paste clipboard watcher (cliphist)
    "wl-paste-cliphist" = {
      Unit = {
        Description = "wl-paste clipboard watcher (cliphist)";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store";
        Restart = "on-failure";
        RestartSec = "2s";
        Type = "simple";
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
    };

    # swww daemon (wallpaper daemon)
    "swww-daemon" = {
      Unit = {
        Description = "swww wallpaper daemon";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
        RestartSec = "2s";
        Type = "simple";
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
in {
  # merge these into systemd.user.services
  systemd.user.services =
    lib.recursiveUpdate config.systemd.user.services systemdUser;
}

