resource "aws_s3_bucket" "site" {
  bucket        = "${var.s3_bucket_name}"
  acl           = "private"
  force_destroy = true
  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_root",
      "Action": ["s3:ListBucket"],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name}",
      "Principal": {"AWS":"${var.iam_arn}"}
    },
    {
      "Sid": "bucket_policy_site_all",
      "Action": ["s3:GetObject"],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.s3_bucket_name}/*",
      "Principal": {"AWS":"${var.iam_arn}"}
    }
  ]
}
EOF
  website {
    index_document = "index.html"
#    error_document = "error.html"
  }
}
resource "aws_s3_bucket_object" "object" {
  bucket = "aws_s3_bucket.${var.s3_bucket_name}.id"
  key    = "index.html"
  source = "./index.html"
}