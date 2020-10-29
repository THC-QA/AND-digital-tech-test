output "cert-arn" {
  value       = aws_acm_certificate.test_certificate.arn
  description = "The ARN of the generated ACM certificate"
}