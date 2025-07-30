output "vnet_name" {
  value = module.network.vnet_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "subnet_names" {
  value = module.network.subnet_names
}

output "nat_gateway_id" {
  value = module.network.nat_gateway_id
}

output "nat_public_ip_id" {
  value = module.network.nat_public_ip_id
}
