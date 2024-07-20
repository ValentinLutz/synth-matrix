module "api_name" {
  source = "./name"

  region      = var.region
  environment = var.environment
  project     = var.project

  name = "synth-matrix"
}

module "lambda_v1_get_person" {
  source = "./lambda-v1-get-person"

  region      = var.region
  environment = var.environment
  project     = var.project

  appsync_graphql_api_arn = aws_appsync_graphql_api.appsync.arn
}