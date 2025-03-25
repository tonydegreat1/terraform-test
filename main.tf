provider "google" {
  project     = "dynamic-music-383701"
  region      = "us-east-1"
  zone        = "us-east1-b"
  credentials = file("")

}

resource "google_compute_instance" "my_instance" {
  name         = "test-instance"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-12-bookworm-v20250311"
    }
  }

  network_interface {
    network    = google_compute_network.terraform-network.self_link
    subnetwork = google_compute_subnetwork.terraform-subnetwork.self_link
    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_compute_network" "terraform-network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false

}
# Create a subnet

resource "google_compute_subnetwork" "terraform-subnetwork" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-east1"
  network       = google_compute_network.terraform-network.id
}