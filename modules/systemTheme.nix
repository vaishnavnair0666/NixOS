{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vanilla-dmz ];

  environment.variables = {
    XCURSOR_THEME = "Vanilla-DMZ";
    XCURSOR_SIZE = "18";
  };
}
