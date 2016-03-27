# Force 256-color capability -- this might break some stuff?
[ "$TERM" = "xterm" ] && TERM=xterm-256color

# A nice prompt
[ -n "$PS1" ] && PS1="\[\e[0m\][\[\e[36;1m\]\A\[\e[0m\]] [\[\e[33;1m\]\l\[\e[0m\]/\[\e[32;1m\]\!\[\e[0m\]] \[\e[1m\]\u\[\e[0m\]@\[\e[1m\]\h\[\e[0m\]:\w\$ "
