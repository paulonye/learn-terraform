variable "databricks_account_host" {
  description = "Databricks account base URL"
  default = "https://accounts.gcp.databricks.com"
}
variable "gcp_project" {
  description = "GCP project in which to provision resources"
}

variable "gcp_region" {}

variable "databricks_account_id" {}

variable "name" {
  description = "Name prefix to use"
}
variable "delegates" {
  description = "Allow either user:user.name@example.com, group:deployers@example.com or serviceAccount:sa1@project.iam.gserviceaccount.com to impersonate created service account"
  type        = list(string)
}
