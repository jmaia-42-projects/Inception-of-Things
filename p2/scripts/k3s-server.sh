#!/bin/bash
IP=$1

curl -sfL https://get.k3s.io | sh -s server --write-kubeconfig-mode 644 --tls-san $IP --node-ip $IP --flannel-iface=eth1

kubectl apply -f /configurations/Deployment.yaml
kubectl apply -f /configurations/Service.yaml
kubectl apply -f /configurations/Ingress.yaml