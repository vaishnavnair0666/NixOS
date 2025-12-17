{ ... }:

{
  programs.bash.enable = true;
  programs.bash = {
    bashrcExtra = ''
      export EDITOR="nvim"
      export VISUAL="nvim"

      eval "$(direnv hook bash)"
      eval "$(atuin init bash)"
      # Remove up-arrow keybinding
      bind '"\e[A": history-search-backward' # Restores default up-arrow behavior
    '';
  };
}
