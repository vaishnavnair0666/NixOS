{ ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "vaish";
        command = "systemctl --user start graphical-session.target";
      };
    };
  };
}

