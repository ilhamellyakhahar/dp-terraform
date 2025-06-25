variable "subscription_id" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_name" {}
variable "admin_username" {}
variable "admin_password" {
  sensitive = true
}
variable "disk_name" {}
variable "disk_size_gb" {
  default = 32
}
variable "disk_sku" {
  default = "Standard_LRS"
}
variable "caching" {
  default = "ReadWrite"
}

variable "lun" {
  default = 0
}