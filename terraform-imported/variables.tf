# CloudFront
variable "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_distribution_zone_id" {
  description = "The zone ID for CloudFront distributions, which is globally unique"
  type        = string
}

# Route 53
variable "hosted_zone_id" {
  description = "The Route 53 hosted zone ID"
  type        = string
}

# Route 53 CNAME Record 1
variable "cname_record_name_1" {
  description = "Route 53 CNAME Record Name for my_cname_record_1"
  type        = string
}

variable "cname_record_value1" {
  description = "Route 53 CNAME Record Value for my_cname_record_1"
  type        = string
}

# Route 53 CNAME Record 2
variable "cname_record_name_2" {
  description = "Route 53 CNAME Record Name for my_cname_record_1"
  type        = string
}

variable "cname_record_value2" {
  description = "Route 53 CNAME Record Value for my_cname_record_1"
  type        = string
}

# CodePipeline
variable "codepipeline_role_arn" {
  description = "CodePipeline Role ARN"
  type        = string
}

variable "s3_artifact" {
  description = "S3 Bucket where Artifacts are stored"
  type        = string
}
variable "codestar_connection_arn" {
  description = "CodeStar Connection ARN"
  type        = string
}
