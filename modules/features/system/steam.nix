{...}: {
  flake.nixosModules.steam = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };

    environment.systemPackages = with pkgs; [mangohud vulkan-tools];
    programs.gamemode.enable = true;
  };
}
