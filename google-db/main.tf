module "gcp" {
  source = "./gcp"
  prefix = var.name
  delegates = var.delegates
  project = var.gcp_project
}

module "databricks" {
  source = "./databricks"
  name = var.name
  google_service_account = module.gcp.service_account
  account_id = var.databricks_account_id
  gcp_region = var.gcp_region
  gcp_project = var.gcp_project
}