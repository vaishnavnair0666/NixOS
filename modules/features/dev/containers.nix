{...}: {
  flake.nixosModules.containers = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      podman
      podman-tui
      podman-compose
      dive
      skopeo
      buildah
      lazydocker
    ];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    systemd.user.sockets.podman.wantedBy = ["sockets.target"];
  };
}
