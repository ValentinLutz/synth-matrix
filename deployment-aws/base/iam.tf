data "aws_iam_policy_document" "appsync" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["appsync.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "appsync" {
  name               = module.api_name.name
  assume_role_policy = data.aws_iam_policy_document.appsync.json
}


data "aws_iam_policy_document" "appsync_lambda" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "appsync_lambda" {
  name   = "AllowLambdaInvoke"
  role   = aws_iam_role.appsync.id
  policy = data.aws_iam_policy_document.appsync_lambda.json
}