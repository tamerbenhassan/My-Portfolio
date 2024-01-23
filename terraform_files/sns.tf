resource "aws_sns_topic" "cv_download_topic" {
  name = "cv-download-notification"
}

resource "aws_sns_topic_subscription" "cv_download_subscription" {
  topic_arn = aws_sns_topic.cv_download_topic.arn
  protocol  = "email"
  endpoint  = "tamer.benhassan@outlook.com" # Change to your email
}
