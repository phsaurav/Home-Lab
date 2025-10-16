## 📁 Directory Structure

```txt
argocd/
├── base/                        # ArgoCD base configuration
│   ├── projects.yaml           # ArgoCD Projects (homelab)
│   └── kustomization.yaml
├── apps/                        # Application manifests
│   └── monitoring/             # Grafana + Prometheus stack
│       ├── namespace.yaml
│       ├── prometheus/         # Prometheus configs
│       ├── grafana/            # Grafana configs
│       └── kustomization.yaml
├── environments/                # Environment-specific ArgoCD apps
│   ├── dev/
│   │   └── applications/
│   │       ├── app-of-apps.yaml      # Root application
│   │       └── monitoring.yaml       # Monitoring app definition
│   └── prod/
│       └── applications/
│           ├── app-of-apps.yaml      # Root application
│           └── monitoring.yaml       # Monitoring app definition
└── readme.md
```

### Step 1: Apply ArgoCD Projects (One-time Setup)

```bash
kubectl apply -f argocd/base/projects.yaml
```

### Step 2: Deploy Root Application (App of Apps)

```bash
kubectl apply -f argocd/environments/dev/applications/app-of-apps.yaml
```


