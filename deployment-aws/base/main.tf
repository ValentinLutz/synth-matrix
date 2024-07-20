resource "aws_appsync_graphql_api" "appsync" {
  name                = module.api_name.name
  authentication_type = "API_KEY"
  schema              = file("${path.module}/../../api-definition/schema.graphql")
}

resource "aws_appsync_api_key" "appsync" {
  api_id  = aws_appsync_graphql_api.appsync.id
  expires = "2025-01-01T00:00:00Z"
}

resource "aws_appsync_datasource" "appsync_person" {
  name             = "person"
  api_id           = aws_appsync_graphql_api.appsync.id
  service_role_arn = aws_iam_role.appsync.arn
  type             = "AWS_LAMBDA"

  lambda_config {
    function_arn = module.lambda_v1_get_person.arn
  }
}

resource "aws_appsync_resolver" "appsync_person" {
  api_id      = aws_appsync_graphql_api.appsync.id
  type        = "Query"
  field       = "person"
  data_source = aws_appsync_datasource.appsync_person.name
}
