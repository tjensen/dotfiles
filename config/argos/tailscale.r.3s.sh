#!/bin/sh

# Adapted from https://github.com/mbugert/tailscale-polybar-rofi

ICON_ACTIVE=""
ICON_INACTIVE=""

status=$(curl --silent --fail --unix-socket /var/run/tailscale/tailscaled.sock http://local-tailscaled.sock/localapi/v0/status)

# bail out if curl had non-zero exit code
if [ $? != 0 ]; then
    exit 0
fi

# check if it's stopped (down)
if [ "$(echo ${status} | jq --raw-output .BackendState)" = "Stopped" ]; then
    echo "${ICON_INACTIVE} VPN down"
    echo "---"
    echo "Connect | bash='tailscale up --accept-routes' terminal=false refresh=true"
    exit 0
fi

# if an exit node is active, show its hostname
exit_node_hostname="$(echo ${status} | jq --raw-output '.Peer[] | select(.ExitNode) | .HostName')"
if [ -n "${exit_node_hostname}" ]; then
    echo "${ICON_ACTIVE} VPN ${exit_node_hostname}"
else
    echo "${ICON_ACTIVE} VPN up"
fi

echo "---"
echo "Disconnect | bash='tailscale down' terminal=false refresh=true"
echo "---"
echo "Exit node"

for node in $(echo ${status} | jq -r '.Peer[] | select(.ExitNodeOption) | .HostName')
do
    if [ "$node" != "$exit_node_hostname" ]; then
        echo "--$node | font=monospace bash='tailscale set --exit-node=$node' terminal=false refresh=true"
    fi
done

if [ -n "$exit_node_hostname" ]; then
    echo "--(no exit node) | bash='tailscale set --exit-node=\"\"' terminal=false refresh=true"
fi
