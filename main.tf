locals {
  script_vars = {
    INSTANCE_CONNECTION_NAME = data.google_sql_database_instance.default.connection_name
  }
}

resource "random_id" "default" {
  byte_length = 2
}

data "google_compute_zones" "available" {
  region  = var.region
  project = var.project
}

resource "random_shuffle" "default" {
  input = data.google_compute_zones.available.names
}

data "google_compute_subnetwork" "default" {
  name    = var.subnetwork
  region  = var.region
  project = var.host_project != "" ? var.host_project : var.project
}

data "google_sql_database_instance" "default" {
  name    = var.db_name
  region  = var.region
  project = var.project
}

// create service account with cloudsql.editor role
resource "google_service_account" "default" {
  account_id   = "cloudsqlproxy-${random_id.default.hex}"
  project      = var.project
  display_name = "Service Account for Cloud SQL Proxy"
}

resource "google_project_iam_member" "project" {
  role    = "roles/cloudsql.editor"
  member  = google_service_account.default.member
  project = var.project
}

// create compute instance that hosts the proxy
resource "google_compute_instance" "default" {
  name         = "cloudsqlproxy-${random_id.default.hex}"
  project      = var.project
  machine_type = "e2-small"
  zone         = random_shuffle.default.result[0]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.default.self_link
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh", local.script_vars)

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

// create iam binding to allow user to create iap tunnel
resource "google_iap_tunnel_instance_iam_binding" "enable_iap" {
  project  = var.project
  zone     = resource.random_shuffle.default.result[0]
  instance = resource.google_compute_instance.default.name
  role     = "roles/iap.tunnelResourceAccessor"
  members  = var.members
}

// optionally create fw
resource "google_compute_firewall" "default" {
  count   = var.create_firewall_rule ? 1 : 0
  project = var.host_project != "" ? var.host_project : var.project
  name    = "cloudsqlproxy-${random_id.default.hex}"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = toset(concat(["22"], var.additional_ports))
  }

  # https://cloud.google.com/iap/docs/using-tcp-forwarding#before_you_begin
  # This is the netblock needed to forward to the instances
  source_ranges = ["35.235.240.0/20"]
}

// enable api
resource "google_project_service" "default" {
  project = var.project
  service = "iap.googleapis.com"

  disable_on_destroy = false
}
