module "name" {
  source = "../name"

  region      = var.region
  environment = var.environment
  project     = var.project

  name = "v1-get-person"
}