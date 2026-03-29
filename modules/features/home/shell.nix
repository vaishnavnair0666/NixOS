{...}: {
  flake.nixosModules.hm-shell = {user, ...}: {
    home-manager.users.${user}.programs.bash = {
      enable = true;
      bashrcExtra = builtins.readFile ./Bash.bash;
    };
  };
}
