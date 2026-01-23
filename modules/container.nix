{ pkgs, ... }:

{
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
    dockerCompat = true; # so `docker ps` works with podman
    defaultNetwork.settings.dns_enabled = true;
    dockerSocket.enable = true;
    autoPrune.enable = true;
  };
  systemd.user.sockets.podman = { wantedBy = [ "sockets.target" ]; };

}
