resource "aws_eks_access_entry" "admin_ec2" {
  cluster_name  = module.eks.cluster_name
  principal_arn = "arn:aws:iam::444166849721:role/GitOpsDevSecOpsEC2Role"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "admin_ec2" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.admin_ec2.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}
