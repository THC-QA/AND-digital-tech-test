variable "ports_in" {
  type        = list(number)
  description = "Ingress ports for nginx instances"
  default     = [22, 443, 80]
}
variable "cidr_block" {}
variable "cidr_block_open" {
    description     =   "CIDR block open access"
    default         =   ["0.0.0.0/0"]
}
variable "outbound-port" {
    description     =   "Port open to allow outbound connection"
    default         =   "0"
}
variable "vpc_id" {}
variable "region" {}