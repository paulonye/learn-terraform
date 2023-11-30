variable "account_host" {
  description = "Databricks account base URL"
  default = "https://accounts.gcp.databricks.com"
}
variable "google_service_account" {
  description = "The username of your Databricks account administrator"
}
variable "account_id" {
  description = "The id of your Databricks account (as obtained by account console)"
}
variable "gcp_region" {
  description = "GCP region in which to provision resources"
}
variable "gcp_project" {
  description = "GCP project in which to provision resources"
}
variable "name" {
  description = "Name prefix to use"
}
