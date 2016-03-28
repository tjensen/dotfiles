alias ll='ls -l'
alias la='ls -la'

# Allow for system-specific aliases that shouldn't be shared everywhere
[ -e "$HOME/.bash_aliases_local" ] && source "$HOME/.bash_aliases_local"
