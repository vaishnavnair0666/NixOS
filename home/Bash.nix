{ ... }:

{
  programs.bash = {
    enable = true;

    bashrcExtra = builtins.readFile ./Bash.bash;

  };
}
