variable "project_key"          {
    default = "ANDdigitalTechTest" # create on AWS web interface
}
variable "aws_access_key"       {}
variable "aws_secret_key"       {}
variable "region"               {
    default = "eu_west_2"
}
variable "s3_bucket_name"       {
    default = "and-digital-tech-test.yourdomain.net"
}
variable "bucket_env"           {
    default = "Development"
}
variable "domain"               {} # domain that you own eg "yourdomain.net"
variable "subdomain"            {} # choice of name eg "and-digital-tech-test"
variable "hosted_zone"          {} # same as domain eg "yourdomain.net"
variable "cache_default_ttl"    {
  description = "Cloudfront's cache default time to live."
  default = 3600
}
variable "cache_max_ttl"        {
  description = "Cloudfront's cache maximun time to live."
  default = 86400
}