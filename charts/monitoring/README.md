# Monitoring Stack with ArgoCD

This repo includes an Argo CD application definition to install Prometheus and Grafana
via the `kube-prometheus-stack` Helm chart.

## Installation

```bash
kubectl apply -f charts/monitoring/monitoring-app.yaml
```

Then access Grafana via:

```bash
kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80
```

Default credentials: `admin/admin`
