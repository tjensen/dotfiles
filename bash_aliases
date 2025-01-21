alias ll='ls -l'
alias la='ls -la'

alias grep='grep --color=auto'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gd='git diff'

alias wo='workon $(basename $PWD)'
alias mkv='mkvirtualenv $(basename $PWD)'

alias docker-clean='docker ps -a | grep '\''weeks ago'\'' | awk '\''{print }'\'' | xargs docker rm'
alias docker-env='eval $(minikube docker-env)'
alias ecr-login='eval $(aws ecr get-login --no-include-email)'
alias podme='podman run --mount=type=bind,src=$HOME,dst=$HOME -it -w $PWD --privileged'

function show-cert {
    if [ -z "$1" ]
    then
        1>&2 echo "Hostname required"
    else
        openssl s_client -showcerts -servername $1 -connect $1:443 </dev/null 2>/dev/null | openssl x509 -inform pem -noout -text
    fi
}

# Allow for system-specific aliases that shouldn't be shared everywhere
[ -e "$HOME/.bash_aliases_local" ] && source "$HOME/.bash_aliases_local"
