<div align="center">

# 🚀 Multi-Environment GitOps + DevSecOps Platform

### Secure CI/CD • AWS Infrastructure as Code • Kubernetes • GitOps • Observability

**Python** · **Docker** · **GitHub Actions** · **Trivy** · **Amazon ECR** · **Terraform** · **Amazon EKS** · **Argo CD** · **Prometheus** · **Grafana**

[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=githubactions&logoColor=white)](https://github.com/rahul-chaudhari-collab/multi-env-gitops-devsecops/actions)
![Cloud](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)
![IaC](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform&logoColor=white)
![Container](https://img.shields.io/badge/Container-Docker-2496ED?logo=docker&logoColor=white)
![Security](https://img.shields.io/badge/Security-Trivy-0F9D58)

**An enterprise-style reference platform that connects secure software delivery, infrastructure automation, Kubernetes GitOps, and observability in one architecture.**

</div>

![Complete DevSecOps platform architecture](assets/01-overall-architecture.png)

## 📌 Project Overview

This project demonstrates how a Python Flask microservice fits into a modern DevSecOps delivery platform. The implemented GitHub Actions workflow tests application code, builds a Docker image, scans it with Trivy, authenticates to AWS using OpenID Connect (OIDC), and publishes the image to Amazon Elastic Container Registry (ECR).

The same repository contains reusable Terraform infrastructure modules, Kubernetes deployment manifests, and Argo CD application definitions for development, staging, and production. The architecture also illustrates the Prometheus/Grafana observability layer.

### Key capabilities

- **Automated CI/CD:** tests, container build, vulnerability scan, and ECR image publishing.
- **Secure cloud access:** GitHub OIDC-based AWS role assumption; no permanent AWS access key required in GitHub Actions.
- **Container security:** Trivy HIGH/CRITICAL vulnerability gate, non-root container execution, and health checks.
- **Infrastructure as code:** modular AWS VPC, networking, IAM, and EKS configuration.
- **Kubernetes-ready delivery:** Deployment, Service, readiness and liveness probes.
- **GitOps configuration:** Argo CD Application definitions for three environments.
- **Observability architecture:** metrics, dashboards, and alerting design using Prometheus and Grafana.

## 🔄 CI/CD Pipeline

![CI/CD pipeline architecture](assets/02-cicd-pipeline.png)

**Delivery sequence**

1. A developer commits and pushes code to GitHub.
2. GitHub Actions checks out the repository and runs the Python test suite.
3. Docker builds a container image for the Flask application.
4. Trivy scans the image; the configured HIGH/CRITICAL gate blocks unsafe releases.
5. GitHub Actions obtains temporary AWS credentials through OIDC.
6. The container image is tagged and published to Amazon ECR.
7. Kubernetes manifests and Argo CD definitions describe the downstream deployment flow.

**Verified CI results:** 3/3 Python tests passed, Docker health check passed, Trivy scan passed, GitHub Actions jobs succeeded, and an image was published to ECR.

➡️ **[Inspect GitHub Actions workflow runs](https://github.com/rahul-chaudhari-collab/multi-env-gitops-devsecops/actions)**

## ☁️ AWS Infrastructure with Terraform

![Terraform and AWS infrastructure architecture](assets/03-terraform-aws.png)

Terraform defines an AWS infrastructure topology consisting of:

- VPC with public and private subnets
- Internet and NAT gateway routing
- IAM roles and permissions
- Amazon EKS control plane and managed worker nodes
- Amazon ECR image registry
- GitHub Actions AWS OIDC integration

**Infrastructure workflow:** initialize Terraform → validate configuration → review plan → apply only after reviewing cloud cost and access controls.

The EKS infrastructure configuration has been validated, and its plan reviewed (**24 resources to add**). The ECR and GitHub OIDC integration are already configured.

## ☸️ Kubernetes & Argo CD GitOps

![Kubernetes and Argo CD GitOps architecture](assets/04-kubernetes-argocd.png)

The application delivery design uses Kubernetes as the workload runtime and Argo CD as the GitOps controller.

**Kubernetes definitions**

- Flask application Deployment with two replicas
- ClusterIP Service mapping port 80 to application port 5000
- HTTP `/health` readiness and liveness probes
- Container image hosted in Amazon ECR

**Environment definitions**

| Environment | GitOps application | Purpose |
| --- | --- | --- |
| Development | `kubernetes/argocd/dev-app.yaml` | Developer integration |
| Staging | `kubernetes/argocd/staging-app.yaml` | Pre-production verification |
| Production | `kubernetes/argocd/prod-app.yaml` | Production delivery configuration |

The three Argo CD Application manifests point to the shared Kubernetes base. Environment-specific overlays and automated promotion can be added as the platform evolves.

## 📊 Monitoring & Observability

![Monitoring and observability architecture](assets/05-monitoring.png)

The observability architecture connects application and cluster metrics to **Prometheus** and visualizes them through **Grafana**. It includes a design for alerts to operational notification channels.

**Representative metrics:** request rate, response latency, error rate, pod readiness, CPU/memory utilization, and cluster resource health.

## 🛡️ Security & Reliability

| Control | Approach |
| --- | --- |
| Supply-chain scanning | Trivy image vulnerability scan |
| AWS credentials | Short-lived OIDC role credentials |
| Runtime privileges | Non-root Docker user |
| Availability | Kubernetes replica and health probe configuration |
| Network isolation | Private subnet design for worker nodes |
| Infrastructure review | Terraform validate and plan before provisioning |
| Secrets | Avoid committing credentials or private keys |

## 🗂️ Repository Structure

```text
multi-env-gitops-devsecops/
├── .github/workflows/         # CI/CD workflow
├── app/                       # Flask application and tests
├── docker/                    # Container build definition
├── terraform/                 # AWS infrastructure modules and environments
├── kubernetes/
│   ├── base/                  # Deployment and Service
│   └── argocd/                # Dev, staging, prod Application manifests
├── assets/                    # Architecture and workflow illustrations
└── README.md                  # Project documentation
```

## 🧪 Application API

| Endpoint | Description |
| --- | --- |
| `/` | Application landing response |
| `/health` | Health endpoint for probes |
| `/info` | Application information |

The containerized service listens on **port 5000**. Kubernetes exposes it internally through a **ClusterIP Service** on port **80**.

## 🧭 End-to-End Engineering Workflow

```text
Code change
    ↓
GitHub push
    ↓
Python tests → Docker build → Trivy security gate
    ↓
GitHub OIDC → Amazon ECR
    ↓
Kubernetes workload definitions
    ↓
Argo CD GitOps environment definitions
    ↓
Prometheus / Grafana observability architecture
```

## 🎯 Interview Walkthrough

Explain the project in five parts: **application**, **secure CI/CD**, **AWS infrastructure**, **Kubernetes GitOps**, and **observability**. Open a successful GitHub Actions run to demonstrate the verified delivery pipeline. Show the Terraform modules and plan, then walk through the Kubernetes and Argo CD manifests to explain the intended environment delivery model. Discuss Trivy and OIDC as security controls.

> **Implementation note:** Automated tests, Docker build/health checks, Trivy scanning, GitHub Actions, ECR publishing, and Terraform validation have been verified. EKS runtime, Argo CD synchronization, and Prometheus/Grafana installation are documented as platform architecture and configuration; they are not presented here as verified live services.

## 👨‍💻 Author

**Rahul Chaudhari**  
GitHub: [rahul-chaudhari-collab](https://github.com/rahul-chaudhari-collab)

---

<div align="center"><strong>Build securely • Automate consistently • Deploy with confidence</strong></div>
