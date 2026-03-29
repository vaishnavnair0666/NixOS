{self, ...}: let
  user = "vaish";
in {
  flake.nixosModules.greetd = {pkgs, ...}: {
    services.greetd = {
      enable = true;

      settings.default_session = {
        command = "${self.packages.${pkgs.stdenv.hostPlatform.system}.niri}/bin/niri-session";
        user = user;
      };
    };
  };
}
