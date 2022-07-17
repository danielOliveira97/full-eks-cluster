variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-west-2"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "eks-cluster"
}