resource "aws_sns_topic" "sns_notification_pipeline" {
  name = "tamerbenhassan-pipeline-notification"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_notification_pipeline.arn
  protocol  = "email"
  endpoint  = var.sns_subscription_endpoint
}


resource "aws_sns_topic_policy" "sns_policy" {
  arn = aws_sns_topic.sns_notification_pipeline.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Publish",
    ]


    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["codestar-notifications.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.sns_notification_pipeline.arn,
    ]
  }
}

# terraform import aws_sns_topic.sns_notification_pipeline arn_of_topic
# terraform import aws_sns_topic_subscription.sns_subscription arn_of_subscription
# terraform import aws_sns_topic_policy.sns_policy arn_of_topic
