{ pkgs, ... }: {
  services.greetd.enable = true;

  services.greetd.settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd dwl";
      user = "vaish";
    };
  };
}
