#!/bin/bash

set -o allexport

FLUX_BOOTSTRAP_PATH=$1
NAMESPACE="fluxcd"

# Load environment variable containing GitHub repository, username and token
source .env set
+o allexport

# Install Flux CLI (if not already installed)
if ! command -v flux &> /dev/null; then
    echo "Installing flux CLI..."
    curl -s https://fluxcd.io/install.sh | sudo bash
fi

# Create Kubernetes namespace
if kubectl get namespace "$NAMESPACE" &> /dev/null; then
    echo "Namespace $NAMESPACE already exists."
else
    kubectl create namespace "$NAMESPACE"
    echo "Namespace $NAMESPACE created."
fi

# Bootstrap FluxCD
flux bootstrap github \
  --owner=$GITHUB_USERNAME \
  --repository=$GITHUB_REPOSITORY \
  --branch=main \
  --path=$FLUX_BOOTSTRAP_PATH \
  --personal \
  --token-auth=true

# Wait for FluxCD to sync
echo "Waiting for FluxCD to synchronize..."
sleep 10

# Check FluxCD status
flux get all --namespace $NAMESPACE