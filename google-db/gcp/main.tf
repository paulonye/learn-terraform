provider "google" {
  project                  = var.project
}

resource "google_service_account" "sa2" {
  account_id   = "${var.prefix}-sa2"
  display_name = "Service Account for Databricks Provisioning"
}

data "google_iam_policy" "this" {
  binding {
    role    = "roles/iam.serviceAccountTokenCreator"
    members = var.delegates
  }
}

resource "google_service_account_iam_policy" "impersonatable" {
  service_account_id = google_service_account.sa2.name
  policy_data        = data.google_iam_policy.this.policy_data
}

resource "google_project_iam_custom_role" "databricks_role_default_vpc" {
  role_id = "${var.prefix}_databricks_role_default_vpc"
  title   = "Databricks role for default VPC"
  permissions = [
    "compute.networks.get",
    "compute.projects.get",
    "compute.subnetworks.get",
    "iam.roles.create",
    "iam.roles.delete",
    "iam.roles.get",
    "iam.roles.update",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.getIamPolicy",
    "iam.serviceAccounts.setIamPolicy",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",
    "serviceusage.services.enable",
    "serviceusage.services.get",
    "serviceusage.services.list"
  ]
}

resource "google_project_iam_member" "sa2_can_create_workspaces" {
  project = var.project
  role    = google_project_iam_custom_role.databricks_role_default_vpc.id
  member  = "serviceAccount:${google_service_account.sa2.email}"
}

resource "google_project_iam_member" "sa2_can_create_tokens" {
  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.sa2.email}"
}

resource "google_project_iam_member" "sa2_can_admin_buckets" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.sa2.email}"
}

output "service_account" {
  value       = google_service_account.sa2.email
  description = "Add this email as a user in the Databricks account console"
}
