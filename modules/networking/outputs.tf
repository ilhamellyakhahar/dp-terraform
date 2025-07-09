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
  value = var.enable_ngw && length(azurerm_nat_gateway.nat) > 0 ? azurerm_nat_gateway.nat[0].id : null
}

output "nat_public_ip_id" {
  value = var.enable_ngw && length(azurerm_public_ip.nat) > 0 ? azurerm_public_ip.nat[0].id : null
}