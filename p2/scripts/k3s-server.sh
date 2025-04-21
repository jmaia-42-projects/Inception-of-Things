#!/bin/bash
IP=$1

curl -sfL https://get.k3s.io | sh -s server --write-kubeconfig-mode 644 --tls-san $IP --node-ip $IP --flannel-iface=eth1

# Make sure kubectl is set up for the vagrant user
sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config

kubectl apply -f /configurations/Deployment.yaml
kubectl apply -f /configurations/Service.yaml
kubectl apply -f /configurations/Ingress.yaml