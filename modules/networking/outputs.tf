output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = { for k, s in azurerm_subnet.subnet : k => s.id }
}

output "subnet_names" {
  value = [for s in azurerm_subnet.subnet : s.name]
}

output "nat_gateway_id" {
  value = var.enable_nat_gateway ? azurerm_nat_gateway.nat[0].id : null
}