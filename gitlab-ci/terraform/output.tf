output "external_ip" {
  value = yandex_compute_instance.gitlab[*].network_interface.0.nat_ip_address
}
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
  {
    instance_ip = yandex_compute_instance.gitlab[*].network_interface.0.nat_ip_address,
  }
  )
  filename = "../ansible/inventory"
}
