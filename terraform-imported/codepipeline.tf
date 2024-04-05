resource "aws_codepipeline" "codepipeline" {
  name     = "tb-portfolio-pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.s3_artifact
    type     = "S3"
  }

  stage {
    name = "Github Version 2"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = aws_codestarconnections_connection.provider.name
      version          = "2"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = "tamerbenhassan/My-Portfolio"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "AWS CodeBuild"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "2"

      configuration = {
        ProjectName = "tamerbenhassan-build-project"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "2"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }
}

resource "aws_codestarconnections_connection" "provider" {
  name          = "Github"
  provider_type = "GitHub"
}
