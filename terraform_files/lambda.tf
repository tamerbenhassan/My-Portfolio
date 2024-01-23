resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "s3:GetObject",
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::resume-tamer-benhassan-english/*"
      },
      {
        Action = [
          "dynamodb:PutItem",
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.download_log.arn
      },
      {
        Action = [
          "sns:Publish",
        ],
        Effect   = "Allow",
        Resource = aws_sns_topic.cv_download_topic.arn
      },
    ],
  })
}

resource "aws_lambda_function" "cv_download_lambda" {
  function_name = "cv_download_notifier"

  filename         = "/Users/macbook/Desktop/tb-portfolio-repo/My-Portfolio"
  source_code_hash = filebase64sha256("/Users/macbook/Desktop/tb-portfolio-repo/My-Portfolio")
  handler          = "index.lambda_handler"
  runtime          = "python3.8"

  role = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      SNS_TOPIC_ARN  = aws_sns_topic.cv_download_topic.arn
      DYNAMODB_TABLE = aws_dynamodb_table.download_log.name
    }
  }
}
