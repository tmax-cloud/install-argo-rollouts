#!/bin/bash

kubectl apply -f ./manifests/install.yaml -n argo-rollouts
kubectl apply -f ./manifests/install-dashboard.yaml -nargo-rollouts

curl -LO https://github.com/argoproj/argo-rollouts/releases/download/v1.1.1/kubectl-argo-rollouts-linux-amd64
chmod +x ./kubectl-argo-rollouts-linux-amd64
sudo mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts
echo 'alias argo=/usr/local/bin/kubectl-argo-rollouts' >>~/.bashrc
source ~/.bashrc
