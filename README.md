# AWS EKS Bootstrap Infrastructure

A complete **EKS (Elastic Kubernetes Service) bootstrap infrastructure** that automatically provisions a production-ready Kubernetes cluster on AWS using Terraform.

## What This Project Does

**Networking**: VPC with public/private subnets, NAT Gateways, route tables, database subnets  
**EKS Cluster**: Control plane with logging, OIDC provider, configurable API endpoints  
**Security**: IAM roles for cluster and nodes, SSH key pair, IRSA setup  
**Compute**: Auto-scaling node groups (private/public) with AL2023 AMI  
**Add-ons**: Cluster autoscaler, ALB controller, external DNS, metrics server, EBS/EFS CSI drivers

## Infrastructure Structure

### **VPC & Networking**
- **VPC**: 10.0.0.0/16 with public/private/database subnets across 2 AZs
- **Public Subnets**: Internet Gateway + NAT Gateway for outbound access
- **Private Subnets**: Route through NAT Gateway, host EKS worker nodes
- **Database Subnets**: Isolated subnets for future database deployments

### **EKS Components**
- **Control Plane**: EKS cluster in public subnets with API logging
- **Node Groups**: Private (1-2 nodes) + Public (1-2 nodes) with auto-scaling
- **Instances**: t3.medium with AL2023 AMI, 20GB EBS volumes
- **Security**: IAM roles, OIDC provider, SSH access, IRSA setup

### **Production Add-ons**
- **Autoscaling**: Cluster autoscaler for dynamic node scaling
- **Load Balancing**: ALB controller for ingress traffic management
- **DNS**: External DNS for automatic Route53 record management
- **Storage**: EBS CSI (block storage) + EFS CSI (file storage) drivers
- **Monitoring**: Metrics server for Kubernetes resource metrics

## Project Structure

```
eks-bootstrap/
├── 01-providers.tf          # AWS Provider & Authentication
├── 02-version.tf            # Terraform Version Constraints
├── 03-general-variables.tf  # Global Variables (team, env, region)
├── 04-vpc-variables.tf      # VPC Configuration Variables
├── 05-vpc.tf               # VPC & Subnet Infrastructure
├── 06-vpc-outputs.tf       # VPC Outputs
├── 07-eks-variables.tf     # EKS Configuration Variables
├── 08-eks.tf               # EKS Cluster
├── 09-eks-outputs.tf       # EKS Outputs
├── 10-local-values.tf      # Centralized Naming & Tags
├── 11-iam-cluster-role.tf  # EKS Cluster IAM Role
├── 12-iam-node-role.tf     # EKS Node IAM Role
├── 13-eks-irsa.tf          # IRSA Configuration
├── 14-aws-key-pair.tf      # SSH Key Pair
├── 15-eks-node-group-private.tf  # Private Node Group
├── 16-eks-node-group-public.tf   # Public Node Group
├── 17-cluster-autoscaler.tf      # Cluster Autoscaler
├── 18-alb-controller.tf          # ALB Controller
├── 19-externaldns-controller.tf  # External DNS
├── 20-metric-server.tf           # Metrics Server
├── 21-ebs-csi.tf                 # EBS CSI Driver
└── 22-efs-csi.tf                 # EFS CSI Driver
```

## Quick Start

### **Prerequisites:**
- AWS CLI, Terraform, kubectl

### **Deploy:**
```bash
cd eks-bootstrap
export AWS_ACCESS_KEY_ID="your-key"
export AWS_SECRET_ACCESS_KEY="your-secret"
export AWS_REGION="us-east-1"

terraform init
terraform plan
terraform apply
```

### **Access Cluster:**
```bash
aws eks update-kubeconfig --region us-east-1 --name devops-dev-eksdemo-eks-cluster
kubectl get nodes
```

## Configuration

**Defaults**: Region: `us-east-1`, Environment: `dev`, Team: `devops`, Cluster: `eksdemo`  
**VPC**: `10.0.0.0/16`, Node Type: `t3.medium`, Auto-scaling: 1-2 nodes per group

**Customize**: Edit `03-general-variables.tf` and `07-eks-variables.tf`

## Use Cases

Development/Testing • Production Staging • Learning/Education • CI/CD Pipelines • Multi-team Development


## 🔧 Maintenance

```bash
terraform plan    # Review changes
terraform apply   # Apply updates
terraform destroy # Clean up
```

## Environments (dev and prod)

This repo supports separate state and variables for `dev` and `prod` via per-environment var files and backend configs.

### Directory layout
```
environments/
  dev/
    dev.tfvars
    backend.hcl
  prod/
    prod.tfvars
    backend.hcl
```

### Configure remote state
Create an S3 bucket and DynamoDB table (once):
```bash
aws s3 mb s3://CHANGE_ME-terraform-state --region us-east-1
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```
Edit `environments/*/backend.hcl` and set your bucket and region.

### Workflows

Dev:
```bash
cd eks-bootstrap
terraform init -backend-config=../environments/dev/backend.hcl -reconfigure
terraform plan  -var-file=../environments/dev/dev.tfvars
terraform apply -var-file=../environments/dev/dev.tfvars
```

Prod:
```bash
cd eks-bootstrap
terraform init -backend-config=../environments/prod/backend.hcl -reconfigure
terraform plan  -var-file=../environments/prod/prod.tfvars
terraform apply -var-file=../environments/prod/prod.tfvars
```

### kubeconfig examples
```bash
aws eks update-kubeconfig --region us-east-1 --name devops-dev-eksdemo-eks-cluster
aws eks update-kubeconfig --region us-east-1 --name devops-prod-eksdemo-eks-cluster --alias prod
```

### Tips / Best Practices
- Use separate AWS accounts or at least separate S3 state prefixes per environment.
- Keep `prod` node sizes and replica counts higher than `dev`.
- Tag resources via locals to include `Environment` and `Team` (already configured).
- Consider separate Route53 hosted zones or subdomains per environment.

