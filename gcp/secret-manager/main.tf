resource "google_secret_manager_secret" "this" {
  project   = var.project_id
  secret_id = var.secret_name
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "this" {
  secret      = google_secret_manager_secret.this.id
  secret_data = var.secret_data
}
