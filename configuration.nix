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
    # ./modules/seatd.nix
    # ./modules/walker.nix
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
    ./modules/kernelBlacklist.nix
    ./modules/loginManager.nix
    ./modules/menu.nix
    ./modules/portal.nix
    # ./modules/special/terminaltools.nix
    ./modules/special/whichkey.nix
    ./modules/system.nix
    ./modules/systemTheme.nix
    ./modules/users.nix
    ./modules/windowManager.nix
  ];
}

