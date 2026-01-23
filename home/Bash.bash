export EDITOR=nvim
export VISUAL=nvim
export Nix_SHELL=0
export DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock

__git_branch() {
	git symbolic-ref --short HEAD 2>/dev/null || return
}
__exit_status() {
	local s=$?
	[ $s -ne 0 ] && echo -e "\e[1;31m✗ $s\e[0m "
}
PS1='\[\e[38;5;171m\]\A\[\e[0m\]|\h@\u:$(__exit_status)[\[\e[38;5;76m\]$(__git_branch)\[\e[0m\]]\[\e[96m\]\w\n|${Nix_SHELL:-0}|\[\e[0m\]󰁔'
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
PROMPT_COMMAND='history -a'

# Case-insensitive tab completion
bind 'set completion-ignore-case on'

# History search with arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

set -o noclobber
shopt -s globstar nullglob

eval "$(direnv hook bash)"
