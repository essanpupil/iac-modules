resource "google_service_account" "this" {
  account_id   = var.service_account_id
  display_name = var.service_account_description
  project      = var.project_id
}

module "bastion" {
  source           = "/Users/essan/Code/iac-modules/gcp/compute-instance"
  count            = var.create_bastion ? 1 : 0
  network_name     = var.network_name
  project_id       = var.project_id
  subnetwork_id    = var.subnetwork_id
  name             = "${var.name}-bastion"
  zone             = "${var.location}-${var.bastion_zone}"
  allow_ssh        = true
  ssh_source_range = var.ssh_source_range
}

resource "google_container_cluster" "this" {
  # checkov:skip=CKV_GCP_69
  # checkov:skip=CKV_GCP_65
  project                                  = var.project_id
  name                                     = var.name
  location                                 = var.location
  remove_default_node_pool                 = true
  initial_node_count                       = 1
  networking_mode                          = "VPC_NATIVE"
  network                                  = var.network_id
  subnetwork                               = var.subnetwork_id
  deletion_protection                      = false
  datapath_provider                        = var.datapath_provider
  enable_cilium_clusterwide_network_policy = var.enable_cilium_clusterwide_network_policy

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  resource_labels = {
    "managedby" = "terraform"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }

  enable_intranode_visibility = true

  ip_allocation_policy {}

  addons_config {
    network_policy_config {
      disabled = var.addons_network_policy_config
    }
  }

  network_policy {
    enabled  = var.network_policy_enabled
    provider = var.network_policy_provider
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = var.enable_private_endpoint
  }

  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic = true
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # authenticator_groups_config {
  #   security_group = "gke-security-groups@jagatku.com"
  # }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled      = var.gcp_public_cidrs_access_enabled
    private_endpoint_enforcement_enabled = true
    cidr_blocks {
      cidr_block   = var.public_authorized_cidr
      display_name = "DreamSpace"
    }
  }

  secret_manager_config {
    enabled = var.enabled_secret_manager_config
  }
}

resource "google_container_node_pool" "primary" {
  # checkov:skip=CKV_GCP_69
  project    = var.project_id
  name       = var.name
  location   = var.location
  cluster    = google_container_cluster.this.name
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type    = "e2-small"
    preemptible     = true
    service_account = google_service_account.this.email
    image_type      = "COS_CONTAINERD"

    metadata = {
      disable-legacy-endpoints = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }
}
