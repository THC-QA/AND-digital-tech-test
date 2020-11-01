 module "cloudfront" {
    source              = "../../modules/cloudfront"
    region              = var.region
    domain              = var.domain
    bucket_domain_name  = module.s3.bucket_domain_name
    s3_bucket_name      = var.s3_bucket_name
    s3_bucket_env       = var.s3_bucket_env
    cache_default_ttl   = var.cache_default_ttl
    cache_max_ttl       = var.cache_max_ttl
    project_key         = var.project_key
}
module "s3" {
    source          = "../../modules/s3"
    region          = var.region
    s3_bucket_name  = var.s3_bucket_name
    iam_arn         = module.cloudfront.iam_arn
}
module "route53" {
    source                  = "../../modules/route53"
    region                  = var.region
    hosted_zone             = var.hosted_zone
    domain                  = var.domain
    subdomain               = var.subdomain
    cloudfront_domain_name  = module.cloudfront.cloudfront_domain_name
}