resource "azurerm_public_ip" "public_ip" {
  for_each            = { for vm in var.vms : vm.name => vm }
  name                = "${each.value.name}-public-ip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  for_each            = { for vm in var.vms : vm.name => vm }
  name                = "${each.value.name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = { for vm in var.vms : vm.name => vm }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password

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
    disk_encryption_set_id = try(each.value.disk_encryption_set_id, null)
    diff_disk_settings {
      option = each.value.use_ephemeral_os_disk ? "Local" : null
    }
  }

  disable_password_authentication = false
}

resource "azurerm_managed_disk" "data_disk" {
  for_each            = { for vm in var.vms : vm.name => vm }
  name                = each.value.disk_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  storage_account_type = each.value.disk_sku
  create_option       = "Empty"
  disk_size_gb        = each.value.disk_size_gb
  disk_encryption_set_id = try(each.value.disk_encryption_set_id, null)
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_data_disk" {
  for_each            = { for vm in var.vms : vm.name => vm }
  managed_disk_id     = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id  = azurerm_linux_virtual_machine.vm[each.key].id
  lun                 = each.value.lun
  caching             = each.value.caching
}