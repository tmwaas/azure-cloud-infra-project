# Azure AKS & Azure-Native Platform Infrastructure

This repository demonstrates an enterprise-grade Azure DevOps platform combining:

- Terraform-based core infrastructure
- Azure-native Bicep platform components
- Azure Kubernetes Service (AKS)
- Azure Service Bus (event-driven messaging)
- Managed Identity & secure design patterns
- CI/CD automation (Azure DevOps)
- Observability & SRE-aligned practices

This project reflects real-world Platform Engineering and DevOps responsibilities:
designing, implementing, securing, automating, and operating Azure-based infrastructure using Infrastructure as Code.

---

# What This Project Demonstrates

## Core Infrastructure (Terraform)
- Azure Resource Group provisioning
- Virtual Network & Subnet configuration
- Azure Kubernetes Service (AKS) deployment
- Azure Container Registry (ACR)
- Modular & reusable Terraform structure
- Idempotent infrastructure provisioning

## Azure-Native Platform Layer (Bicep)
- Log Analytics Workspace provisioning
- Secure Storage Account (TLS 1.2 enforced, public access disabled)
- Azure Service Bus Namespace
- User Assigned Managed Identity
- Infrastructure as Code via Bicep
- ARM-based idempotent deployments

## Platform Operations (AKS Layer)
- AWX (Ansible Automation Platform) deployed on AKS
- MinIO S3-compatible object storage
- Automated backup workflows
- Prometheus & Grafana monitoring stack

## Event-Driven Architecture Validation
- Service Bus queue (test-queue) created
- Message successfully sent
- Message successfully received

Demonstrates:
- Asynchronous communication pattern
- Decoupled system design
- Messaging backbone provisioning via IaC

---

# High-Level Architecture

```
User / Developer
        |
        v
Terraform (Core Infrastructure)
        |
        v
Azure Resources:
  - Resource Group
  - VNet
  - AKS
  - ACR
        |
        v
Bicep (Azure-Native Platform Layer)
  - Log Analytics
  - Secure Storage
  - Service Bus
  - Managed Identity
        |
        v
AKS Platform
  - AWX Automation
  - MinIO
  - Backup Jobs
  - Prometheus & Grafana
        |
        v
Event Messaging
  - Service Bus Queue (test-queue)
  - Send / Receive validation
```  

---

# Azure-Native Platform Deployment (Bicep)

Deployment executed using:

az deployment group create \
  --resource-group <existing-rg> \
  --template-file bicep/platform/main.bicep \
  --parameters bicep/platform/parameters.bicepparam

Governance Awareness:

In restricted sandbox environments (e.g., Pluralsight Hands-On Labs):

- RBAC role assignments may be blocked
- Diagnostic settings may be restricted
- Service Principal creation may be disallowed

Templates are production-ready and designed for enterprise Azure subscriptions.

---

# CI/CD Integration

Azure DevOps YAML pipelines included:

pipelines/
├── azure-devops-bicep.yml
└── azure-devops-terraform.yml

Pipeline capabilities:
- Bicep validation stage
- Deployment stage
- Service Connection integration (enterprise-ready)
- Branch & path-based triggers

---

# Repository Structure

```
azure-cloud-infra-project/
├── README.md
├── docs/
│   └── screenshots/
├── app/
│   ├── app.py
│   └── Dockerfile
│   └── requirements.txt
├── bicep/
│   ├── platform/
│   │   ├── main.bicep
│   │   └── parameters.bicepparam
├── ansible/
│   ├── inventories/
│   └── playbooks/
├── infra/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   └── .terraform.lock.hcl
├── platform/
│   ├── main.tf
│   └── providers.tf
├── kubernetes/
│   ├── automation/
│   │   ├── awx/
│   │   └── awx-operator/
│   ├── storage/
│   │   └── minio/
│   ├── backup_jobs/
│   └── observability/
├── modules/
│   ├── aks/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── gitops/
│   │   └── main.tf
│   ├── monitoring/
│   │   └── main.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
├── pipelines/
│   ├── azure-devops-bicep.yml
│   └── azure-devops-terraform.yml
```

---

# Demo Scenario: Automated Backup to Object Storage

This demo validates **end-to-end operational automation** using Kubernetes-native tooling and Ansible automation.

### Flow Overview

1. AWX executes Ansible playbook
2. Backup artifact generated
3. The artifact is uploaded to MinIO (S3-compatible storage)
4. Backup success is verified via AWX output and MinIO UI

### Demo Evidence

#### AWX Job Execution (Backup to MinIO)

The screenshot below shows a successful AWX job execution where an Ansible playbook:
- creates a demo backup artifact
- uploads it to MinIO object storage

![AWX Backup Job Success](docs/screenshots/awx-backup-success.png)

---

#### MinIO Object Storage (Backup Artifact)

The screenshot below confirms that the backup artifact has been successfully stored
inside the MinIO bucket.

![MinIO Backup Object](docs/screenshots/minio-backup-object.png)

---

## Tooling & Technologies

- Microsoft Azure
- Terraform & Bicep
- Azure Kubernetes Service (AKS)
- Ansible & AWX
- MinIO
- Prometheus & Grafana
- Kubernetes & Docker

---

# Engineering Focus Areas

- Infrastructure as Code (Terraform & Bicep)
- Azure Platform Engineering
- Secure Cloud Design
- Event-Driven System Patterns
- Observability & Reliability
- Governance & RBAC Awareness
- Enterprise CI/CD Workflows

---

# Author

Thomas Waas  
DevOps & Cloud Engineer
