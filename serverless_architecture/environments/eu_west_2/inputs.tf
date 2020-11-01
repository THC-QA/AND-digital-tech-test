variable "project_key"          {
    default = "ANDdigitalTechTest" # create on AWS web interface
}
variable "region"               {
    default = "eu-west-2"
}
variable "s3_bucket_name"       {
#    default = "and-digital-tech-test.yourdomain.net"
}
variable "s3_bucket_env"           {
    default = "Development"
}
variable "domain"               {} # domain that you own eg "yourdomain.net"
variable "subdomain"            {} # eg dev.yourdomain.net etc
variable "hosted_zone"          {} # same as domain eg "yourdomain.net"
variable "cache_default_ttl"    {
  description = "Cloudfront's cache default time to live."
  default = 3600
}
variable "cache_max_ttl"        {
  description = "Cloudfront's cache maximun time to live."
  default = 86400
}