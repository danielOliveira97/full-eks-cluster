resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version  = "1.22"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = var.private_subnets
    security_group_ids = tolist([aws_security_group.cluster_master_sg.id])
  }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

}

resource "aws_eks_addon" "vpc_cni_addon" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"
}