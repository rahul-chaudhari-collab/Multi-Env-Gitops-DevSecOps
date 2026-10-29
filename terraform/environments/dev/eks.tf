module "eks" {
  source = "../../modules/eks"

  project_name    = "gitops-devsecops"
  cluster_version = var.eks_cluster_version

  cluster_public_access_cidrs = ["98.93.38.27/32"]

  subnet_ids      = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  node_subnet_ids = module.vpc.private_subnet_ids

  node_instance_types = ["t3.medium"]
  node_desired_size   = 2
}

variable "eks_cluster_version" {
  description = "Supported Kubernetes version for AWS EKS"
  type        = string
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
