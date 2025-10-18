{ inputs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "vaish";
        command = ''
          dbus-run-session ${inputs.dwlFlake.defaultPackage}/bin/dwl
        '';
      };
    };
  };
}

