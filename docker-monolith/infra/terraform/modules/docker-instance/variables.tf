variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  default     = "~/.ssh/appuser"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
variable instance_disk_image {
  description = "Instance disk image"
  default     = "ubuntu-1604-xenial-v20200521"
}
variable machine_type {
  description = "Machine type for instance"
  default     = "g1-small"
}
variable "env" {
  description = "Environment"
  default = "stage"
}
variable "env_network" {
  description = "Environment network"
  default = "default"
}
variable "env_label" {
  description = "Instance environment label"
  default = "stage"
}
variable "instance_count" {
  description = "Number of instances"
  default = 1
}
