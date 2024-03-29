# S3 Bucket
resource "aws_s3_bucket" "tamerbenhassan_com" {
  bucket = "tamerbenhassan.com"

}

# Versioning Enabled
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tamerbenhassan_com.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Static Website Hosting
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.tamerbenhassan_com.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Bucket Policy
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.tamerbenhassan_com.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::tamerbenhassan.com/*"
      },
    ]
  })
}

# Pubkic Access Block
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.tamerbenhassan_com.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
