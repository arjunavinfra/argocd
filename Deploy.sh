#!/bin/bash
which argocd 
if [ $? != 0 ]; then

wget https://github.com/argoproj/argo-cd/releases/download/v2.5.5/argocd-linux-amd64 -O /tmp/argocd
chmod +x /tmp/argocd 
sudo mv /tmp/argocd  /sbin/argocd 
else 
echo "argocd Cli is aliready installed"
fi 

kubectl apply -k ./Install

kubectl wait --namespace ingress-nginx   --for=condition=ready pod  -l component=argocd   --timeout=200s -n argocd

echo -e "\n"
echo -e "Admin Password:  `kubectl  get secret argocd-initial-admin-secret -ojson -n argocd  | jq .data.password -r | base64 -d`"
echo -e "\n"
