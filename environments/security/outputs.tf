output "nsg_id" {
  value = azurerm_network_security_group.nsg_vm.id
}

output "nsg_name" {
  value = azurerm_network_security_group.nsg_vm.name
}

output "nsg_subnet_association_id" {
  value = try(azurerm_subnet_network_security_group_association.subnet_assoc.id, null)
}

output "nsg_rules" {
  value = azurerm_network_security_group.nsg_vm.security_rule[*].name
}