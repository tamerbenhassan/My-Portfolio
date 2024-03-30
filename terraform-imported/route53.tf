# Route 53 Public Hosted Zone
resource "aws_route53_zone" "rt53" {
  name = "tamerbenhassan.com"
}

# Route 53 Records
resource "aws_route53_record" "my_a_record" {
  zone_id = var.hosted_zone_id
  name    = "tamerbenhassan.com"
  type    = "A"
  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "my_a_record_2" {
  zone_id = var.hosted_zone_id
  name    = "www.tamerbenhassan.com"
  type    = "A"
  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "my_cname_record_1" {
  zone_id = var.hosted_zone_id
  name    = var.cname_record_name_1
  type    = "CNAME"
  ttl     = 60
  records = [
    var.cname_record_value1
  ]
}

resource "aws_route53_record" "my_cname_record_2" {
  zone_id = var.hosted_zone_id
  name    = var.cname_record_name_2
  type    = "CNAME"
  ttl     = 60
  records = [
    var.cname_record_value2
  ]
}



