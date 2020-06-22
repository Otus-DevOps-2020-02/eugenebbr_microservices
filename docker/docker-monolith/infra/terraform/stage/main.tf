terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.5.0"
  project = var.project
  region  = var.region
}

module "docker-instance" {
  source          = "../modules/docker-instance"
  zone            = var.zone
  env             = var.env
  public_key_path = var.public_key_path
  env_label       = var.env_label
}
