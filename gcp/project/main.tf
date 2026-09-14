# trivy:ignore:GCP-0079
resource "google_project" "this" {
  # checkov:ignore:CKV2_GCP_5
  name                = var.project_name
  project_id          = var.project_id
  billing_account     = var.billing_account == "" ? null : var.billing_account
  folder_id           = var.folder_id == "" ? null : var.folder_id
  org_id              = var.org_id == "" ? null : var.org_id
  auto_create_network = var.auto_create_network
}

resource "google_project_service" "this" {
  count              = length(var.enabled_services)
  project            = google_project.this.id
  service            = var.enabled_services[count.index]
  disable_on_destroy = false
}

