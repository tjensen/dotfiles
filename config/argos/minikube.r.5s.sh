MINIKUBE_STATUS=$(minikube status -o json | jq -r .Host)
CONTEXT=$(kubectl config current-context)

if [ "$MINIKUBE_STATUS" = "Running" ]
then
    MINIKUBE_SYMBOL="🟢"
    MINIKUBE_COMMAND="Stop Minikube | bash='minikube stop' terminal=false refresh=true"
else
    MINIKUBE_SYMBOL="🔴"
    MINIKUBE_COMMAND="Start Minikube | bash='minikube start' terminal=false refresh=true"
fi

echo "$MINIKUBE_SYMBOL Context: ${CONTEXT:-N/A}"

echo "---"

echo "Minikube: $MINIKUBE_STATUS $MINIKUBE_SYMBOL"
echo "$MINIKUBE_COMMAND"

echo "---"

echo "Use context"
for CONTEXT in $(kubectl config get-contexts -o name)
do
    echo "--$CONTEXT | font=monospace bash='kubectl config use-context $CONTEXT' terminal=false refresh=true"
done
