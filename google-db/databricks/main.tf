provider "databricks" {
  alias                  = "accounts"
  host                   = var.account_host
  google_service_account = var.google_service_account
  account_id             = var.account_id
}

resource "databricks_mws_workspaces" "ws1" {
  provider       = databricks.accounts
  account_id     = var.account_id
  workspace_name = var.name
  location       = var.gcp_region
  cloud_resource_container {
    gcp {
      project_id = var.gcp_project
    }
  }
  gke_config {
    connectivity_type = "PRIVATE_NODE_PUBLIC_MASTER"
    master_ip_range   = "10.3.0.0/28"
  }

  token {}
}

output "databricks_workspace_id" {
  value = split("/",databricks_mws_workspaces.ws1.id)[1]

}

output "databricks_workspace_url" {
  value = databricks_mws_workspaces.ws1.workspace_url
}

output "token" {
  value     = databricks_mws_workspaces.ws1.token[0].token_value
  sensitive = true
}
