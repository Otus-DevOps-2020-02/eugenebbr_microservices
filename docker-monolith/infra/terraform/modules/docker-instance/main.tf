resource "google_compute_instance" "docker-instance" {
  count        = var.instance_count
  name         = "docker-instance-${count.index + 1}-${var.env}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["docker-instance"]
  labels = {
    environment = var.env_label
  }
  boot_disk {
    initialize_params { image = var.instance_disk_image }
  }
  network_interface {
    network = google_compute_network.env_subnet.name
    access_config {}
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default-${var.env}"
  network = google_compute_network.env_subnet.name
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-instance"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh-${var.env}"
  network = google_compute_network.env_subnet.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "env_subnet" {
  name = "${var.env}-network"
  auto_create_subnetworks = true
}
