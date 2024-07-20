data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../../../lambda-v1-get-person/bootstrap"
  output_path = "${path.root}/.terraform/files/lambda-v1-get-person.zip"
}


resource "aws_lambda_function" "lambda" {
  function_name    = module.name.name
  role             = aws_iam_role.lambda.arn
  handler          = "bootstrap"
  runtime          = "provided.al2023"
  architectures    = ["arm64"]
  memory_size      = 128
  timeout          = 10
  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  tracing_config {
    mode = "Active"
  }
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 30
}