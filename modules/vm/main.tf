resource "azurerm_public_ip" "public_ip" {
  for_each            = { for vm in var.vms : vm.vm_name => vm if try(vm.public_ip, true) }
  name                = "${each.value.vm_name}-public-ip"
  location            = each.value.location
  resource_group_name = each.value.rg_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  for_each            = { for vm in var.vms : vm.vm_name => vm }
  name                = "${each.value.vm_name}-nic"
  location            = each.value.location
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = try(azurerm_public_ip.public_ip[each.key].id, null)
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = { for vm in var.vms : vm.vm_name => vm }
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.vm_user
  admin_password      = each.value.vm_pass

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  source_image_reference {
    publisher = each.value.os_publisher
    offer     = each.value.os_offer
    sku       = each.value.os_sku
    version   = each.value.os_version
  }

  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.disk_sku
    disk_encryption_set_id = try(each.value.encryption, null)
    diff_disk_settings {
      option = each.value.ephemeral ? "Local" : null
    }
  }

  admin_ssh_key {
    username   = each.value.vm_user
    public_key = try(each.value.ssh_key, null)
  }

  disable_password_authentication = try(each.value.ssh_key, null) != null ? true : false
}

resource "azurerm_managed_disk" "data_disk" {
  for_each = { for vm in var.vms : vm.vm_name => vm if try(vm.disk_name, null) != null && try(vm.disk_size, null) != null }
  name                = each.value.disk_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  storage_account_type = each.value.disk_sku
  create_option       = "Empty"
  disk_size_gb        = each.value.disk_size
  disk_encryption_set_id = try(each.value.encryption, null)
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_data_disk" {
  for_each = { for vm in var.vms : vm.vm_name => vm if try(vm.disk_name, null) != null && try(vm.disk_size, null) != null }
  managed_disk_id     = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id  = azurerm_linux_virtual_machine.vm[each.key].id
  lun                 = each.value.lun
  caching             = each.value.caching
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = { for vm in var.vms : vm.vm_name => vm if try(vm.nsg_name, null) != null }
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "security_rule" {
    for_each = try(each.value.sec_rules, [])
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.src_port
      destination_port_range     = security_rule.value.dest_port
      source_address_prefix      = security_rule.value.src_address
      destination_address_prefix = security_rule.value.dest_address
    }
  }
}

resource "azurerm_network_interface_security_group_association" "nic_assoc" {
  for_each = { for vm in var.vms : vm.vm_name => vm if try(vm.nsg_name, null) != null }
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}