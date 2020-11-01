# variable "account_id" {}
variable "environment" {
    default = "test"
}
variable "region" {
    default = "eu-west-2"
}
variable "instance-type-input" {
    default = "t3a.small"
}
variable "key-path" {}
variable "domain-name" {}