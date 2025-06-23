variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "admin_username" {}
variable "admin_password" {
  sensitive = true
}

variable "vm_size" {
  default = "Standard_B1s"
}