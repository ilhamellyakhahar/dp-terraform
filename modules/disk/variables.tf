variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "size_gb" {
  default = 32
}
variable "sku" {
  default = "Standard_LRS"
}