alias ll='ls -l'
alias la='ls -la'

alias grep='grep --color=auto'
alias ag='grep --exclude=*.pyc --exclude-dir=__pycache__ --exclude-dir=.git --recursive'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gd='git diff'

alias wo='workon $(basename $PWD)'

# Allow for system-specific aliases that shouldn't be shared everywhere
[ -e "$HOME/.bash_aliases_local" ] && source "$HOME/.bash_aliases_local"
