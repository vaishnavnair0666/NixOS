{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config = { allowUnfree = true; };
  # ssh key (stored in repo, but should be encrypted)
  environment.etc."ssh/github".text =
    builtins.readFile ./modules/secrets/github.ssh.enc;
  environment.etc."ssh/github".mode = "0600";

  environment.etc."ssh/config".text = ''
    Host github.com
      IdentityFile /etc/ssh/github
      IdentitiesOnly yes
  '';

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/vaish/.dotfiles"; # sets NH_OS_FLAKE variable for you
  };

  imports = [
    ./hardware-configuration.nix
    ./modules/OpenGL.nix
    ./modules/apps.nix
    ./modules/audio.nix
    ./modules/base.nix
    ./modules/bluetooth.nix
    ./modules/container.nix
    ./modules/database.nix
    ./modules/desktop.nix
    ./modules/dev.nix
    ./modules/documentEditor.nix
    ./modules/fonts.nix
    ./modules/formatter.nix
    ./modules/host-options.nix
    ./modules/kernelBlacklist.nix
    ./modules/loginManager.nix
    ./modules/menu.nix
    ./modules/portal.nix
    ./modules/system.nix
    ./modules/systemTheme.nix
    ./modules/terminalTools.nix
    ./modules/users.nix

  ];
  environment.systemPackages = with pkgs; [ cacert curl ];
  environment.sessionVariables = {
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    SSL_CERT_DIR = "${pkgs.cacert}/etc/ssl/certs";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    GTK_USE_PORTAL = "1";
  };
  nix.settings.ssl-cert-file = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
}
