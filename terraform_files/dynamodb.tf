resource "aws_dynamodb_table" "download_log" {
  name         = "CVDownloadsLog"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "DownloadId"
  range_key    = "DownloadDate"

  attribute {
    name = "DownloadId"
    type = "S"
  }

  attribute {
    name = "DownloadDate"
    type = "S"
  }
}
