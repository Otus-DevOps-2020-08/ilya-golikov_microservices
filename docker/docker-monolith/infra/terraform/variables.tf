variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable subnet_id {
  description = "subnet"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable instances {
  description = "Number of instances"
  default     = 1
}
variable image_id {
  description = "Disk image"
}
variable service_account_key_file {
  description = "key.json"
}
