output "vm_ids" {
  value = { for k, vm in azurerm_linux_virtual_machine.vm : k => vm.id }
}

output "vm_private_ips" {
  value = { for k, nic in azurerm_network_interface.nic : k => nic.private_ip_address }
}

output "vm_public_ips" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => contains(keys(azurerm_public_ip.public_ip), vm.vm_name) ? azurerm_public_ip.public_ip[vm.vm_name].ip_address : null
  }
}

output "disk_ids" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => try(azurerm_managed_disk.data_disk[vm.vm_name].id, null)
  }
}

output "disk_names" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => try(azurerm_managed_disk.data_disk[vm.vm_name].name, null)
  }
}

output "nsg_ids" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => try(azurerm_network_security_group.nsg[vm.vm_name].id, null)
  }
}

output "nsg_names" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => try(azurerm_network_security_group.nsg[vm.vm_name].name, null)
  }
}

output "nic_ids" {
  value = { for k, nic in azurerm_network_interface.nic : k => nic.id }
}

output "data_disk_attachment_ids" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => try(azurerm_virtual_machine_data_disk_attachment.attach_data_disk[vm.vm_name].id, null)
  }
}

output "vm_ssh_keys" {
  value = {
    for idx, vm in var.vms :
    vm.vm_name => try(vm.ssh_key, null)
  }
}
