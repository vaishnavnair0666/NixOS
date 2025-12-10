{ config, pkgs, ... }:

let
  greeterUser = "greeter";
  loginUser = "vaish";
in {
  services.greetd.enable = true;
  programs.regreet.enable = true;

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
        ${pkgs.cage}/bin/cage -s -mlast -- ${config.programs.regreet.package}/bin/regreet
      '';
      user = greeterUser;
    };

    # initial_session runs once on greetd start — use this only if you want auto-login.
    # Uncomment the block below to enable automatic boot-into-niri (no greeter).
    # initial_session = {
    #   command = "${pkgs.niri}/bin/niri";
    #   user = loginUser;
    # };

    environments = {
      niri = {
        command = ''
          ${pkgs.niri}/bin/niri
        '';
        user = loginUser;
      };

    };
  };

  environment.etc."greetd/environments".text = ''
    niri
  '';
}
