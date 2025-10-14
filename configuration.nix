{ ... }:

{
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
    ./modules/base.nix
    ./modules/system.nix
    ./modules/users.nix
    ./modules/desktop.nix
    ./modules/walker.nix
    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/fonts.nix
    ./modules/portal.nix
    ./modules/apps.nix
    ./modules/dev.nix
    ./modules/documentEditor.nix
    ./modules/formatter.nix
    ./modules/special/whichkey.nix
  ];
}

