# Multi-Environment GitOps + DevSecOps Platform

A DevOps portfolio project demonstrating automated testing, container security, AWS infrastructure as code, container registry publishing, and GitOps-based Kubernetes deployment configuration.

## Project Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions CI Pipeline
    |
    +--> Python Unit Tests
    |
    +--> Docker Image Build
    |        |
    |        v
    |     Trivy Vulnerability Scan
    |
    +--> AWS OIDC Authentication
             |
             v
         Amazon ECR
             |
             v
      Amazon EKS (planned)
             |
             v
         Argo CD (planned)
             |
       +-----+-----+
       |     |     |
      Dev  Staging Prod
```

## Technology Stack

- Python, Flask, Gunicorn, Pytest
- Docker and Trivy
- GitHub Actions CI/CD
- AWS IAM OIDC and Amazon ECR
- Terraform, VPC and Amazon EKS
- Kubernetes and Argo CD

## CI/CD Pipeline

1. Developer pushes code to GitHub.
2. GitHub Actions runs Python tests.
3. Docker image is built.
4. Trivy scans for HIGH and CRITICAL vulnerabilities.
5. GitHub Actions authenticates to AWS using OIDC.
6. Container image is pushed to Amazon ECR.

## Implemented Features

- Flask application with health endpoint
- Automated tests and Docker image build
- Trivy vulnerability scanning
- GitHub Actions pipeline
- AWS ECR integration
- Terraform infrastructure configuration
- Kubernetes Deployment and Service manifests
- Dev, staging and production Argo CD configurations

## Project Status

Verified:
- Python tests passed
- Docker health check passed
- Trivy scan passed
- GitHub Actions CI passed
- AWS ECR image published
- Terraform configuration validated

Configured but not yet deployed:
- Amazon EKS
- Kubernetes workloads
- Argo CD GitOps applications

Future enhancements:
- Prometheus and Grafana
- SonarQube and Checkov
- Terraform S3 remote backend
- Automated image promotion

## Author

Rahul Chaudhari
GitHub: https://github.com/rahul-chaudhari-collab

## Architecture Diagram

~~mermaid
flowchart TD
    A[Developer] --> B[GitHub Repository]
    B --> C[GitHub Actions]
    C --> D[Python Tests]
    D --> E[Docker Build]
    E --> F[Trivy Security Scan]
    F --> G[AWS ECR]
    G -.-> H[Amazon EKS - Planned]
    I[Terraform] -.-> H
    J[Argo CD - Planned] -.-> H
    H -.-> K[Development]
    H -.-> L[Staging]
    H -.-> M[Production]
~~

