data "aws_iam_policy_document" "lambda" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name               = module.name.name
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}



data "aws_iam_policy_document" "lambda_logs" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "${aws_cloudwatch_log_group.logs.arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_logs" {
  name   = "AllowCloudWatchLogs"
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda_logs.json
}




data "aws_iam_policy_document" "lambda_xray" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords",
      "xray:GetSamplingRules",
      "xray:GetSamplingTargets",
      "xray:GetSamplingStatisticSummaries"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "lambda_xray" {
  name   = "AllowXRayTracing"
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda_xray.json
}



resource "aws_lambda_permission" "lambda_appsync" {
  statement_id  = "AllowExecutionFromAppSync"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "appsync.amazonaws.com"
  source_arn    = "${var.appsync_graphql_api_arn}/*"
}