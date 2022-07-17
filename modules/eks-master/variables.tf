variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  description = "EKS kubernetes cluster version"
  default     = "1.22"
}

variable "cluster_vpc" {
  type        = string
  description = "Cluster VPC id"
}

variable "private_subnets" {
  type        = list(string)
  description = "Cluster VPC private subnets"
}
