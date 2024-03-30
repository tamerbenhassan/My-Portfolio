# ACM Certificates
resource "aws_acm_certificate" "my_certificate" {
  domain_name       = "tamerbenhassan.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
