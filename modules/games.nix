{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;

    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  environment.systemPackages = with pkgs; [ mangohud ];
  programs.gamemode.enable = true;

}
