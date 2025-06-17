#!/bin/bash

# Create the monitoring namespace if it doesn't exist
kubectl get ns monitoring >/dev/null 2>&1 || kubectl create namespace monitoring

# Add Helm repos
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install Prometheus (no CRDs involved)
helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --set server.service.type=NodePort \
  --set server.service.nodePort=32001 \
  --set alertmanager.service.type=NodePort \
  --set alertmanager.service.nodePort=32002

# Install Grafana
helm install grafana grafana/grafana \
  --namespace monitoring \
  --set adminPassword='prom-operator' \
  --set service.type=NodePort \
  --set service.nodePort=32000

echo
echo "✅ Services deployed:"
echo "Grafana:        http://$(minikube ip):32000  (admin / prom-operator)"
echo "Prometheus:     http://$(minikube ip):32001"
echo "Alertmanager:   http://$(minikube ip):32002"
