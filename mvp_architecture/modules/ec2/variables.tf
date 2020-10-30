variable "ami" {
  default = "ami-05c424d59413a2876"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "nginx_instance_key" {}
variable "vpc_security_group_ids" {}
variable "region" {}