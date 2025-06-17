# Monitoring Stack (Prometheus + Grafana)

This folder contains Helm value files and an Argo CD Application manifest to install Prometheus and Grafana into your cluster.

## Steps to Use

1. Ensure Argo CD is running.
2. Push these files to your GitHub repository.
3. Apply the Argo CD app:

```bash
kubectl apply -f charts/monitoring/argocd-app.yaml
```

4. Port-forward Grafana UI:

```bash
kubectl port-forward svc/grafana -n monitoring 3000:3000
```

Visit http://localhost:3000 (admin/admin).
