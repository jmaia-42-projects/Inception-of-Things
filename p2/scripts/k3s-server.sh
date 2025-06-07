#!/bin/bash
IP=$1

curl -sfL https://get.k3s.io | sh -s server --flannel-iface=eth1 --tls-san $IP --node-ip $IP --write-kubeconfig-mode 644

# Make sure kubectl is set up for the vagrant user
sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config

kubectl apply -f /etc/kubernetes/Deployment.yaml
kubectl apply -f /etc/kubernetes/Service.yaml
kubectl apply -f /etc/kubernetes/Ingress.yaml
