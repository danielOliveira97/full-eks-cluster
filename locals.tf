locals {
  vpc_cidr              = "10.0.0.0/16"
  azs                   = slice(data.aws_availability_zones.available.names, 0, 3)
  vpc_private_subnets   = ["10.0.0.0/22", "10.0.4.0/22", "10.0.8.0/22"]
  vpc_public_subnets    = ["10.0.12.0/22", "10.0.16.0/22", "10.0.20.0/22"]
  nodes_instances_sizes = ["t3.small"]

  auto_scaling_options = {
    min     = 2
    max     = 3
    desired = 2
  }

  auto_scale_cpu = {
    scale_up_threshold  = 80
    scale_up_period     = 60
    scale_up_evaluation = 2
    scale_up_cooldown   = 300
    scale_up_add        = 2

    scale_down_threshold  = 40
    scale_down_period     = 120
    scale_down_evaluation = 2
    scale_down_cooldown   = 300
    scale_down_remove     = -1
  }

  tags = {
    Cluster = var.cluster_name
  }
}
