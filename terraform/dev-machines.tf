resource "google_compute_instance" "default" {
  count        = 2
  name         = "dev-${count.index}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "rocky-linux-9-optimized-gcp-v20250114"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.name
    access_config {
      // Ephemeral public IP
    }
  }

  allow_stopping_for_update = true
}

resource "google_compute_project_metadata" "my_ssh_key" {
  metadata = {
    ssh-keys = <<EOF
      root:file(../ssh/google_compute_engine.pub)
      ava:file(../ssh/google_compute_engine.pub)
    EOF
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # TODO create a GCP VPN
  source_ranges = ["82.129.72.242/32"]
}

resource "google_compute_subnetwork" "default" {
  name          = "test-subnetwork"
  network       = google_compute_network.default.id
  ip_cidr_range = "10.0.0.0/8"
}

resource "google_compute_network" "default" {
  name = "test-network"
  auto_create_subnetworks = false
}
