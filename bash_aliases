alias ll='ls -l'
alias la='ls -la'

alias grep='grep --color=auto'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gd='git diff'

alias wo='eval $(poetry env activate)'
alias wo2='workon $(basename $PWD)'
alias mkv='mkvirtualenv $(basename $PWD)'

alias docker-clean='docker ps -a | grep '\''weeks ago'\'' | awk '\''{print }'\'' | xargs docker rm'
alias docker-env='eval $(minikube docker-env)'
alias ecr-login='eval $(aws ecr get-login --no-include-email)'
alias podme='podman run --mount=type=bind,src=$HOME,dst=$HOME -it -w $PWD --privileged'

function show-cert {
    local OPTS="-text"

    OPTIND=1
    while getopts "dv" arg
    do
        case $arg in
            d) local OPTS="-dates";;
            v) local VERBOSE=1;;
            *)
                echo "Usage: show-cert [-d] [-v] hostname [connect]"
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    local SERVERNAME=$1
    local CONNECT="${2:-$1}"

    if [ -z "$1" ]
    then
        1>&2 echo "Hostname required"
    else
        if [ "$CONNECT" != *:* ]
        then
            local CONNECT="$CONNECT:443"
        fi
        local COMMAND="openssl s_client -showcerts -servername $SERVERNAME -connect $CONNECT </dev/null 2>/dev/null | openssl x509 -inform pem -noout $OPTS"
        if [ -n "$VERBOSE" ]; then echo "$ $COMMAND"; fi
        eval $COMMAND
    fi
}

function cert-validity {
    if [ -z "$1" ]
    then
        1>&2 echo "Hostname required"
    else
        openssl s_client -showcerts -servername $1 -connect $1:443 </dev/null 2>/dev/null | openssl x509 -inform pem -noout -dates
    fi
}

function myip {
    curl -4 https://ip.me
    curl -6 https://ip.me
}

# Allow for system-specific aliases that shouldn't be shared everywhere
[ -e "$HOME/.bash_aliases_local" ] && source "$HOME/.bash_aliases_local"
