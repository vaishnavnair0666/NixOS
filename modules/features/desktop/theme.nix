{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.cursor = {pkgs, ...}: {
    environment.systemPackages = [pkgs.vanilla-dmz];

    environment.variables = {
      XCURSOR_THEME = "Vanilla-DMZ";
      XCURSOR_SIZE = "18";
    };
  };
}
