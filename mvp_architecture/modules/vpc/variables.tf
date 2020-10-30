variable "cidr_block" {
    description = "CIDR block for VPC"
    default = "36.108.0.0/16"
}
variable "pub_sub_block_1" {
    description = "CIDR block for first subnet"
    default = "36.108.1.0/24"
}
variable "pub_sub_block_2" {
    description = "CIDR block for second subnet"
    default = "36.108.2.0/24"
}
variable "region" {}