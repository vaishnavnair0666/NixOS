{ pkgs, ... }:
let loginUser = "vaish";
in {
  services.greetd.enable = true;

  services.greetd.settings = {
    default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = loginUser;
    };
  };
}
