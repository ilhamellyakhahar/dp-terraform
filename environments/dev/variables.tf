variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
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

variable "project_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = list(object({
    name          = string
    address_prefix = string
  }))
}

variable "enable_nat_gateway" {
  type = bool
}

variable "vms" {
  description = "List of VM definitions"
  type = list(object({
    name                    = string
    admin_username          = string
    admin_password          = string
    vm_size                 = string
    subnet_name             = string
    disk_name               = string
    disk_size_gb            = number
    disk_sku                = string
    caching                 = string
    lun                     = number
    os_publisher            = string
    os_offer                = string
    os_sku                  = string
    os_version              = string
    disk_encryption_set_id  = optional(string)
    use_ephemeral_os_disk   = optional(bool, false)
  }))
}