resource "azurerm_managed_disk" "disk" {
  name                 = var.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.sku
  create_option        = "Empty"
  disk_size_gb         = var.size_gb
}