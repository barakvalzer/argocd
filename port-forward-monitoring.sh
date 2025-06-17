#!/bin/bash

NAMESPACE="monitoring"

echo "🔁 Killing previous port-forward processes..."
pkill -f "kubectl port-forward -n $NAMESPACE" 2>/dev/null

echo "🚀 Starting port-forwards..."

# Grafana -> localhost:3000
nohup kubectl port-forward -n $NAMESPACE svc/grafana 3000:80 > grafana.log 2>&1 &

# Prometheus -> localhost:9090
nohup kubectl port-forward -n $NAMESPACE svc/prometheus-server 9090:80 > prometheus.log 2>&1 &

# Alertmanager -> localhost:9093
nohup kubectl port-forward -n $NAMESPACE svc/prometheus-alertmanager 9093:80 > alertmanager.log 2>&1 &

sleep 2
echo "✅ Access your monitoring stack:"
echo "Grafana:       http://localhost:3000  (admin / prom-operator)"
echo "Prometheus:    http://localhost:9090"
echo "Alertmanager:  http://localhost:9093"
