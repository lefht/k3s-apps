#!/bin/bash

# Kill any existing port-forward
kill $(lsof -t -i:8080) 2>/dev/null

# Wait a sec for it to die
sleep 1

# Start fresh port-forward in background
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0 &

# Get the password
echo ""
echo "ArgoCD UI: https://10.10.1.240:8080"
echo "Username:  admin"
echo -n "Password:  "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
echo ""
