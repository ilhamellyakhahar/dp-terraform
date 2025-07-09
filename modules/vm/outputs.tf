output "vm_ids" {
  value = { for k, vm in azurerm_linux_virtual_machine.vm : k => vm.id }
}

output "vm_private_ips" {
  value = { for k, nic in azurerm_network_interface.nic : k => nic.private_ip_address }
}

output "vm_public_ips" {
  value = { for k, pip in azurerm_public_ip.public_ip : k => pip.ip_address }
}

output "disk_ids" {
  value = { for k, d in azurerm_managed_disk.data_disk : k => d.id }
}

output "disk_names" {
  value = { for k, d in azurerm_managed_disk.data_disk : k => d.name }
}