variable "vms" {
  description = "List of VM definitions"
  type = list(object({
    name                    = string
    admin_username          = string
    admin_password          = string
    vm_size                 = string
    subnet_id               = string
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
    location                = string
    resource_group_name     = string
  }))
}