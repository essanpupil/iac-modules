resource "google_service_account" "this" {
  account_id   = var.account_id
  display_name = var.account_display_name
}

resource "google_project_iam_member" "this" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.this.email}"
}

resource "google_service_account_iam_member" "this" {
  service_account_id = google_service_account.this.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[YOUR_K8S_NAMESPACE/YOUR_K8S_SERVICE_ACCOUNT]"
}
