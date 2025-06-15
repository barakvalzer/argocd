# K8s Fullstack App with Helm + ArgoCD + GitHub Actions1

## Overview
This repo contains a frontend and backend written in Python (Flask), containerized with Docker, deployed via Helm on Kubernetes, and managed using ArgoCD with GitHub Actions for CI/CD.

## Project Structure
- `frontend/` - Flask frontend app
- `backend/` - Flask backend API
- `charts/fullstack/` - Helm chart for deploying both services
- `.github/workflows/` - GitHub Actions for CI/CD pipeline

## Prerequisites
- Docker
- Helm
- Kubernetes Cluster (Minikube, EKS, etc.)
- Argo CD installed in the cluster
- GitHub repo configured with secrets: `DOCKER_USERNAME`, `DOCKER_PASSWORD`

## Setup Instructions

### 1. Build and Push Docker Images
Build and push images to Docker Hub (GitHub Actions will also do this automatically on push to `main`):
```bash
docker build -t barakvalzer/backend:latest ./backend
docker push barakvalzer/backend:latest

docker build -t barakvalzer/frontend:latest ./frontend
docker push barakvalzer/frontend:latest
```

### 2. Install Helm Chart
Update the `values.yaml` with your Docker image names and then:
```bash
helm upgrade --install fullstack ./charts/fullstack
```

### 3. Argo CD Setup
Apply the ArgoCD Application manifest:
```bash
kubectl apply -f charts/fullstack/templates/argocd-app.yaml
```
Ensure ArgoCD is connected to your GitHub repo and has access to the `charts/fullstack` path.

### 4. Access the Application
- Frontend is exposed via a LoadBalancer (port 80)
- Backend is accessible internally at `http://backend:5000`
- Use `kubectl get svc` to retrieve the external IP

### 5. CI/CD Pipeline
On every push to `main` branch:
- GitHub Actions will build and push both Docker images
- Argo CD will auto-sync and deploy the updated containers to your cluster

## Optional Enhancements
- Configure Route53 + ALB via Terraform
- Add pod listing API via Flask and Kubernetes client

---
Replace placeholder values like DockerHub username and GitHub repo URLs with your actual settings before deployment.
