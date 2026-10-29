# Multi-Environment GitOps + DevSecOps Platform

**AWS • GitHub Actions • Python • Docker • Trivy • Amazon ECR • Terraform • Kubernetes • Argo CD**

> **Project status:** Application, automated tests, container build/security scan, GitHub Actions CI and Amazon ECR publication have been verified. Terraform infrastructure code and Kubernetes/Argo CD manifests are committed, but the EKS cluster, Argo CD synchronization and monitoring have **not** been deployed. Images below illustrate both implemented and planned components; they are architecture illustrations, not screenshots of running services.

![End-to-end DevSecOps platform architecture](assets/01-overall-architecture.png)

## 1. Project overview

This repository demonstrates an AWS-focused DevSecOps delivery workflow. Application changes trigger automated Python tests, Docker image building, Trivy vulnerability scanning, and publication to Amazon Elastic Container Registry (ECR). Terraform defines a proposed AWS VPC/EKS environment, and Kubernetes and Argo CD manifests describe the intended multi-environment GitOps deployment.

**Goals:** reproducible builds, early security checks, short-lived AWS credentials through GitHub OIDC, versioned infrastructure definitions, and a path to controlled environment promotion.

## 2. CI/CD pipeline — implemented and verified

![CI/CD pipeline](assets/02-cicd-pipeline.png)

1. A developer pushes code to GitHub.
2. GitHub Actions checks out the repository and runs Python tests with Pytest.
3. Docker builds the Flask application's container image.
4. Trivy scans the image and enforces the configured HIGH/CRITICAL security gate.
5. GitHub Actions authenticates to AWS through OpenID Connect (OIDC).
6. The image is pushed to Amazon ECR.

**Verified:** three Python tests passed; Docker health check passed; the Trivy gate passed; GitHub Actions jobs succeeded; an image was published to ECR.

[View CI/CD runs](https://github.com/rahul-chaudhari-collab/multi-env-gitops-devsecops/actions)

## 3. AWS infrastructure with Terraform — configuration ready, deployment pending

![Terraform AWS infrastructure](assets/03-terraform-aws.png)

Terraform configuration describes VPC networking, public/private subnets, NAT, IAM permissions, and an EKS cluster with managed worker nodes. The Terraform configuration has been validated and a plan was reviewed; **EKS resources have not been applied**. Existing AWS ECR and OIDC integration were configured separately.

**Deployment caution:** EKS, NAT gateways, EC2 nodes, load balancers, and related resources can incur ongoing charges. Review the plan, IAM permissions, network access, and cost estimates before any `terraform apply`.

## 4. Kubernetes and Argo CD — manifests authored, deployment pending

![Kubernetes GitOps deployment](assets/04-kubernetes-argocd.png)

The repository includes a Kubernetes Deployment and Service, with readiness/liveness checks, plus Argo CD Application manifests targeting development, staging, and production namespaces. These are **configuration artifacts**, not proof of running Kubernetes workloads. Environment-specific overlays, release promotion and actual Argo CD auto-sync have not been verified.

## 5. Monitoring and observability — future enhancement

![Monitoring architecture](assets/05-monitoring.png)

The intended monitoring architecture uses Prometheus for metrics and Grafana for visualization, with optional alerting and log integration. **Prometheus, Grafana, dashboards and alerts are not currently installed or validated.**

## 6. Technology stack

| Layer | Technology | Current state |
| --- | --- | --- |
| Application | Python, Flask, Gunicorn, Pytest | Implemented and tested |
| Containerization | Docker | Built and health-checked |
| Security | Trivy | CI scan gate verified |
| CI/CD | GitHub Actions | Verified |
| Registry | Amazon ECR | Image published |
| AWS authentication | GitHub OIDC, IAM | Configured |
| Infrastructure as Code | Terraform, VPC, EKS | Configuration validated; EKS not deployed |
| Container orchestration | Kubernetes | Manifests authored; not deployed |
| GitOps | Argo CD | Application manifests authored; not deployed |
| Observability | Prometheus, Grafana | Planned |

## 7. Repository layout

```text
.
├── .github/workflows/ci.yml       # CI/CD workflow
├── app/                           # Flask app and tests
├── docker/Dockerfile              # Container image definition
├── terraform/                     # AWS infrastructure configuration
├── kubernetes/
│   ├── base/deployment.yaml       # Deployment and Service
│   └── argocd/                    # Dev, staging, prod Application manifests
├── assets/                        # Architecture illustrations
└── README.md
```

## 8. Verification and project boundaries

**Verified:** Flask app tests, Docker build and health check, Trivy scan, GitHub Actions CI, ECR image push, Terraform validation and planning.

**Not yet verified:** EKS cluster deployment, running workloads, Argo CD synchronization, independent environment promotion, Prometheus/Grafana, production-grade operations.

The architecture images represent the **target system design**. Some illustrative icons and infrastructure elements may describe future options rather than exact provisioned resources; the source code and Terraform configuration are authoritative.

## 9. Next milestones

- Review costs and security before provisioning EKS.
- Deploy Kubernetes workloads and validate service health.
- Install Argo CD and test reconciliation and rollback.
- Separate environment configuration and image promotion.
- Add Prometheus/Grafana, alerting and real execution screenshots.

## 10. Interview walkthrough

**What is working?** A code-to-registry CI pipeline with automated testing, Docker packaging, Trivy security checks, AWS OIDC authentication, and ECR publication.

**What does the infrastructure code do?** It defines an AWS network and EKS target environment, validated by Terraform plan but not yet applied.

**What is the GitOps approach?** Argo CD Application manifests describe the intended deployment to dev, staging and prod namespaces; live synchronization remains future work.

---

**Author:** Rahul Chaudhari  
**GitHub:** https://github.com/rahul-chaudhari-collab  
**Repository:** https://github.com/rahul-chaudhari-collab/multi-env-gitops-devsecops
