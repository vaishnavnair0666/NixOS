{ lib, inputs, ... }: {
  # DWL as a user service (we start dwl via systemd user unit)
  systemd.user.services.dwl = {
    description = "dwl Wayland session";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${inputs.dwlFlake.defaultPackage}/bin/dwl";
      Environment = lib.concatStringsSep "\n" [
        "XDG_SESSION_TYPE=wayland"
        "XDG_CURRENT_DESKTOP=dwl"
        "MOZ_ENABLE_WAYLAND=1"
        "GDK_BACKEND=wayland"
        "QT_QPA_PLATFORM=wayland" # optional for Qt apps
      ];
      Restart = "on-failure";
      RestartSec = "2s";
    };
  };
}
