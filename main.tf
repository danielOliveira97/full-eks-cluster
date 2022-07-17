module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.1"

  name                 = format("%s-vpc", var.cluster_name)
  cidr                 = local.vpc_cidr
  azs                  = local.azs
  private_subnets      = local.vpc_private_subnets
  public_subnets       = local.vpc_public_subnets
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
  }
}

module "eks_master" {
  source          = "./modules/eks-master"
  cluster_name    = var.cluster_name
  cluster_version = "1.22"
  cluster_vpc_id  = module.vpc.vpc_id
  private_subnets = local.vpc_private_subnets
}

module "eks_nodes" {
  source                = "./modules/eks-nodes"
  cluster_name          = var.cluster_name
  nodes_instances_sizes = local.nodes_instances_sizes
  private_subnets       = local.vpc_private_subnets
  auto_scaling_options  = local.auto_scaling_options
  auto_scale_cpu        = local.auto_scale_cpu
}
