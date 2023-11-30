variable "project" {
  description = "GCP project in which to provision resources"
}
variable "prefix" {
  description = "Name prefix to use"
}
variable "delegates" {
  description = "Allow either user:user.name@example.com, group:deployers@example.com or serviceAccount:sa1@project.iam.gserviceaccount.com to impersonate created service account"
  type        = list(string)
}
