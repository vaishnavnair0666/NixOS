{ config, pkgs, ... }:

let
  greeterUser = "greeter";
  loginUser = "vaish";
in {
  services.greetd.enable = true;

  programs.regreet.enable = true;

  # system greeter user (non-login system account)
  users.users."${greeterUser}" = {
    isSystemUser = true;
    description = "Display greeter user for greetd";
    extraGroups = [ "video" ]; # needed for GPU access
    group = "greeter";
    home = "/var/lib/${greeterUser}";
    createHome = true;
    shell = pkgs.bash;
  };

  users.groups.greeter = { };

  environment.systemPackages = with pkgs; [ cage ];

  services.greetd.settings = {
    default_session = {
      command = ''
        ${pkgs.cage}/bin/cage ${config.programs.regreet.package}/bin/regreet
      '';
      user = greeterUser;
    };

    environments = {
      niri = {
        command = ''
          ${pkgs.niri}/bin/niri --config /home/${loginUser}/.config/niri/config.kdl
        '';
        user = loginUser;
      };

      # # optionally expose Hyprland or other sessions too:
      # hyprland = {
      #   command = ''
      #     ${pkgs.hyprland}/bin/Hyprland
      #   '';
      #   user = loginUser;
      # };
    };

  };

  environment.etc."greetd/environments".text = ''
    niri
  '';
}
