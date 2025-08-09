#!/bin/bash

# Exit on any error
set -e

RELEASE_NAME="argocd"
NAMESPACE="argocd"

echo "🔍 Checking if Helm release '$RELEASE_NAME' exists in namespace '$NAMESPACE'..."
if helm list -n "$NAMESPACE" | grep -q "$RELEASE_NAME"; then
    echo "🗑 Uninstalling Helm release: $RELEASE_NAME..."
    helm uninstall "$RELEASE_NAME" -n "$NAMESPACE"
else
    echo "⚠ Helm release '$RELEASE_NAME' not found in namespace '$NAMESPACE'. Skipping Helm uninstall."
fi

echo "🗑 Deleting namespace '$NAMESPACE'..."
kubectl delete namespace "$NAMESPACE" --ignore-not-found

echo "✅ ArgoCD removal complete!"

