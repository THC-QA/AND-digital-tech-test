variable "subnets" {
  description = "A list of subnets to be associated with EKS Cluster, (from VPC module)"
}
variable "secgroups" {
  description = "A list of security groups to be associated with EKS Cluster, (from secgroups module)"
}

variable "region" {}

variable "instance-type" {}
