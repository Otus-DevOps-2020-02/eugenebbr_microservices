variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default     = "europe-west1"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable instance_disk_image {
  description = "Instance disk image"
  default     = "ubuntu-1604-xenial-v20200521"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
variable "env" {
  description = "Environment"
  default     = "stage"
}
variable "env_label" {
  description = "Instance environment label"
  default     = "stage"
}
