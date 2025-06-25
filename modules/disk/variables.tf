variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "size_gb" {
  default = 32
}
variable "sku" {
  default = "Standard_LRS"
}
variable "caching" {
  description = "Caching type for disk attachment"
  type        = string
  default     = "ReadWrite"
}
variable "lun" {
  description = "Logical Unit Number for disk attachment"
  type        = number
  default     = 0
}