provider "aws" {
  #assume_role {
  #  role_arn     = "arn:aws:iam::${var.account_id}:role/EC2"
  #  session_name = "terraform-app-${terraform.workspace}"
  #}
  shared_credentials_file = "~/.aws/credentials/"
  region = var.region
}