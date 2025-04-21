#!/bin/bash

CLUSTER_NAME="p3"
ARGOCD_NAMESPACE="argocd"
DEV_NAMESPACE="dev"

# K3d cluster
echo "Creating K3d cluster..."
k3d cluster create $CLUSTER_NAME -p 8888:80

# Namespaces
echo "Creating namespaces..."
kubectl create namespace $ARGOCD_NAMESPACE
kubectl create namespace $DEV_NAMESPACE

# Install Argo CD
echo "Installing Argo CD..."
kubectl apply -n $ARGOCD_NAMESPACE -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl wait --for=condition=Ready pod --all -n $ARGOCD_NAMESPACE

echo "Forwarding ports between cluster and host..."
# forward ports between cluster and host
kubectl port-forward svc/argocd-server -n argocd 8080:443 &> /dev/null &


# Get the initial admin password
ARGOCD_SERVER=argocd-server-$ARGOCD_NAMESPACE.127-0-0-1.nip.io
ARGOCD_PASSWORD=$(kubectl -n $ARGOCD_NAMESPACE get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

kubectl apply -f ./confs/argocd-app.yaml -n $ARGOCD_NAMESPACE

kubectl wait --for=condition=Ready pod --all -n $DEV_NAMESPACE --timeout=-1s

echo "Argo CD server: $ARGOCD_SERVER"
echo "Argo CD password: $ARGOCD_PASSWORD"
