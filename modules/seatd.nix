{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ seatd ];
  systemd.services.seatd = {
    description = "seatd";
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.seatd}/bin/seatd";
    serviceConfig.Restart = "always";
  };
}
