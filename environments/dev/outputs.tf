output "vm_ids" {
  value = module.vm.vm_ids
}

output "vm_private_ips" {
  value = module.vm.vm_private_ips
}

output "vm_public_ips" {
  value = module.vm.vm_public_ips
}

output "disk_ids" {
  value = module.vm.disk_ids
}

output "disk_names" {
  value = module.vm.disk_names
}

output "nsg_ids" {
  value = module.vm.nsg_ids
}

output "nsg_names" {
  value = module.vm.nsg_names
}

output "vnet_name" {
  value = module.networking.vnet_name
}

output "vnet_id" {
  value = module.networking.vnet_id
}

output "subnet_ids" {
  value = module.networking.subnet_ids
}

output "subnet_names" {
  value = module.networking.subnet_names
}

output "nat_gateway_id" {
  value = module.networking.nat_gateway_id
}

output "nat_public_ip_id" {
  value = module.networking.nat_public_ip_id
}