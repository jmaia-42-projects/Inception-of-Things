k3d cluster create k3d_cluster

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=Ready pod --all -n argocd

kubectl create namespace dev

kubectl apply -f ./app.yaml -n argocd
kubectl wait --for=condition=Ready pod --all -n dev