output "nsg_id" {
  description = "ID dari Network Security Group"
  value       = azurerm_network_security_group.nsg_vm.id
}

output "nsg_name" {
  description = "Nama Network Security Group"
  value       = azurerm_network_security_group.nsg_vm.name
}

output "nsg_subnet_association_id" {
  description = "ID asosiasi NSG ke subnet (jika dibuat)"
  value       = try(azurerm_subnet_network_security_group_association.subnet_assoc.id, null)
}