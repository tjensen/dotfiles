[ -e "$HOME/.bashrc_secure" ] && source "$HOME/.bashrc_secure"

# Force 256-color capability -- this might break some stuff?
[ "$TERM" = "xterm" ] && TERM=xterm-256color
[ "$TERM" = "screen" ] && TERM=screen-256color

export FIGNORE=.pyc

######################################################################
function timer_start {
    timer=${timer:-$SECONDS}
}

function timer_stop {
    timer_show=$(($SECONDS - $timer))
    unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
    PROMPT_COMMAND="timer_stop"
else
    PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

shopt -s promptvars
######################################################################

# A nice prompt
[ -n "$PS1" ] && PS1="\[\e[0m\][\[\e[36;1m\]\A\[\e[0m\]/\[\e[36;1m\]\${timer_show}s\[\e[0m\]] [\[\e[32;1m\]\!\[\e[0m\]] \[\e[1m\]\u\[\e[0m\]@\[\e[1m\]\h\[\e[0m\]:\w\$ "
