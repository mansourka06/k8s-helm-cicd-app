# k8s-helm-cicd-app

🚀 Deployment of an Application with K8s Helm – Multi-Environment Kubernetes

This repository showcases a full CI/CD pipeline using **GitHub Actions**, **Helm**, and **Minikube** to deploy a Python Flask application into **three isolated environments**:

- ✅ `dev`
- ✅ `qa`
- ✅ `prod`

---

## 📦 Project Structure

```
k8s-helm-cicd-app/
├── .github/workflows/k8s-helm-deploy.yml   # GitHub Actions pipeline
├── app/                                    # Python Flask app
├── Dockerfile                              # Dockerfile for the app
├── charts/myapp/                           # Helm chart for deployment
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       └── service.yaml
├── env/                                    # Environment-specific Helm values
│   ├── dev-values.yaml
│   ├── qa-values.yaml
│   └── prod-values.yaml
└── README.md
```

---

## 🐳 Application

A simple Flask app with a single route:

```python
@app.route('/')
def hello():
    return "Hello from Flask App running in Kubernetes!"
```

---

## ⚙️ Helm Chart Overview

The Helm chart includes:

- Deployment
- Service (NodePort)
- Environment-specific replica counts and image tags

All Kubernetes resources are **dynamically named using `{{ .Release.Name }}`** to support parallel environments.

---

## 🚀 GitHub Actions CI/CD Pipeline

The `.github/workflows/helm-deploy.yml` does the following:

1. ✅ Installs Docker
2. ✅ Installs Minikube
3. ✅ Installs Helm
4. ✅ Builds the Docker image inside Minikube
5. ✅ Deploys 3 Helm releases:
   - `myapp-dev`
   - `myapp-qa`
   - `myapp-prod`
6. ✅ Validates deployment with `kubectl get all`

### 🔁 Trigger

This pipeline runs on every push to the `main` branch, or when any YAML/chart/app/dockerfile changes.

---

## 🔧 Environment-Specific Config

Each environment (`dev`, `qa`, `prod`) has its own Helm values file:

### Example: `env/dev-values.yaml`

```yaml
replicaCount: 2
image:
  repository: myapp
  tag: dev
```

---

## 🧪 Run Locally with Minikube

### 1. Start Minikube

```bash
minikube start
```

### 2. Set Docker to use Minikube's Docker daemon

```bash
eval $(minikube docker-env)
```

### 3. Build Docker image

```bash
docker build -t myapp:dev .
```

### 4. Deploy with Helm

```bash
helm upgrade --install myapp-dev charts/myapp -f env/dev-values.yaml
```

### 5. Access the app

```bash
minikube service myapp-dev-service
```

---

## 🔐 Troubleshooting

- ❌ **Service already exists**  
  Ensure you are using `{{ .Release.Name }}` in resource names inside Helm templates to avoid name conflicts.

- ❌ **Minikube not found in GitHub Actions**  
  Ensure Minikube is correctly installed and the Docker driver is enabled.

- ❌ **Image not found**  
  Double-check that the image is built inside the Minikube Docker environment.

---

## ✅ Future Enhancements (Optional)

- Add Ingress + TLS support
- Integrate ArgoCD or Helmfile
- Use Secrets and ConfigMaps
- Push Docker image to ECR/GCR
- Add test cases for the Flask app

---

## 🙌 Author(s)

- [Mansour KA](https://github.com/mansourka06)

Made with passion ❤️ for learning DevOps, GitHub Actions, Helm, and Kubernetes.
