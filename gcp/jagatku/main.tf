# trivy:ignore:GCP-0079
resource "google_project" "jagatku" {
  # checkov:ignore:CKV2_GCP_5
  name                = var.project_name
  project_id          = var.project_id
  billing_account     = var.billing_account == "" ? null : var.billing_account
  folder_id           = var.folder_id == "" ? null : var.folder_id
  org_id              = var.org_id == "" ? null : var.org_id
  auto_create_network = false
}
