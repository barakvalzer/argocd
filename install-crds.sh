#!/bin/bash
set -e

echo "Creating monitoring namespace..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "Installing CRDs for kube-prometheus-stack (v55.5.0)..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm pull prometheus-community/kube-prometheus-stack --untar --version 55.5.0
kubectl apply -f kube-prometheus-stack/crds/
echo "CRDs installed."
