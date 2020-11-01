resource "aws_acm_certificate" "test_certificate" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"
  tags = {
    Environment = "test"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_cloudfront_distribution" "site" {
  enabled             = true
  default_root_object = "index.html"
  origin {
    domain_name = "${var.bucket_domain_name}"
    origin_id   = "${var.s3_bucket_name}"
    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.test_certificate.arn
    ssl_support_method = sni-only
    minimum_protocol_version = TLSv1
  }
  custom_error_response {
    error_code          = 403
    response_code       = 200
    response_page_path  = "/error.html"
  }
  custom_error_response {
    error_code          = 404
    response_code       = 200
    response_page_path  = "/error.html"
  }
  # Route53 requires Alias/CNAME to be setup
  aliases = ["${var.s3_bucket_name}"]
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.s3_bucket_name}"
    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = "${var.cache_default_ttl}"
    max_ttl                = "${var.cache_max_ttl}"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags = {
    Name        = "${var.s3_bucket_name}"
    Environment = "${var.s3_bucket_env}"
    Project     = "${var.project_key}"
  }
}
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access Identity for S3"
}