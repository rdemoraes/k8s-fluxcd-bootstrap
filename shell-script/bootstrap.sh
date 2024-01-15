#!/bin/bash

# Install Flux CLI (if not already installed)
if ! command -v flux &> /dev/null; then
    echo "Installing flux CLI..."
    curl -s https://fluxcd.io/install.sh | sudo bash
fi

# Create Kubernetes namespace
kubectl create namespace $NAMESPACE

# Bootstrap FluxCD
flux bootstrap github \
  --owner=$GITHUB_USERNAME \
  --repository=$REPOSITORY_URL \
  --branch=main \
  --path=clusters/my-cluster \
  --personal \
  --token-auth=$GITHUB_TOKEN

# Wait for FluxCD to sync
echo "Waiting for FluxCD to synchronize..."
sleep 10

# Check FluxCD status
flux get all --namespace $NAMESPACE
