{ pkgs, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;

    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.gamemode.enable = true;
  programs.games.mangohud = {
    enable = true;
    enable32Bit = true;
  };

}
