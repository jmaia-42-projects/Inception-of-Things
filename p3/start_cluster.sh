CLUSTER_NAME="cluster"
ARGOCD_NAMESPACE="argocd"
DEV_NAMESPACE="dev"

k3d cluster create $CLUSTER_NAME -p 8080:80@loadbalancer

kubectl create namespace $ARGOCD_NAMESPACE

kubectl apply -n $ARGOCD_NAMESPACE -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=Ready pod --all -n $ARGOCD_NAMESPACE

kubectl create namespace $DEV_NAMESPACE

kubectl apply -f ./app.yaml -n $ARGOCD_NAMESPACE
kubectl wait --for=condition=Ready pod --all -n $DEV_NAMESPACE

ARGOCD_SERVER=argocd-server-$ARGOCD_NAMESPACE.127-0-0-1.nip.io
ARGOCD_PASSWORD=$(kubectl -n $ARGOCD_NAMESPACE get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "Argo CD server: $ARGOCD_SERVER"
echo "Argo CD password: $ARGOCD_PASSWORD"
