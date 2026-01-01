{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      bat
      bluetuith
      broot
    ];
}
