variable "vm_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "disk_name" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "disk_sku" {
  type = string
}

variable "caching" {
  type = string
}

variable "lun" {
  type = number
}