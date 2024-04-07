resource "aws_codebuild_project" "codebuild_tb" {
  name          = "tamerbenhassan-build-project"
  build_timeout = 5
  service_role  = var.codebuild_role

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "Lambda"
    image                       = "aws/codebuild/amazonlinux-aarch64-lambda-standard:python3.11"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "CLOUDFRONT_DISTRIBUTION_ID"
      value = aws_cloudfront_distribution.s3_distribution.id
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "/aws/codebuild/tamerbenhassan-build-project"
    }
  }

  source {
    type = "CODEPIPELINE"
  }
}
