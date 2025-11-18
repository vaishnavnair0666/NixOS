{ ... }: {
  systemd.services.greetd = {
    serviceConfig = {
      Wants = [ "seatd.service" ];
      After = [ "seatd.service" ];
    };
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "vaish";
        command = ''
          dbus-run-session /run/current-system/sw/bin/dwl
        '';
      };
    };
  };
}

