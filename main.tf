terraform {
  backend "gcs" {
    bucket  = "mentoria-tfstate-staging"
    prefix  = "groundwork/state"
  }
}

provider "google" {
  project = "mentoria-iac-staging"
  region  = "us-central1"
}

resource "google_compute_network" "orquestradores" {
  name                    = "orquestradores"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "load-balancer" {
  name          = "load-balancer"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.orquestradores.id
}

resource "google_compute_subnetwork" "nomad" {
  name          = "nomad"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.orquestradores.id
}
