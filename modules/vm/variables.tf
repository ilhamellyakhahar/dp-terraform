variable "vms" {
  description = "List of VM definitions"
  type = list(object({
    vm_name                 = string
    vm_user                 = string
    vm_pass                 = string
    vm_size                 = string
    subnet                  = string
    disk_name               = string
    disk_size               = number
    disk_sku                = string
    caching                 = string
    lun                     = number
    os_publisher            = string
    os_offer                = string
    os_sku                  = string
    os_version              = string
    encryption              = optional(string)
    ephemeral               = optional(bool, false)
    location                = string
    rg_name                 = string
    nsg_name                = optional(string)
    sec_rules               = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      src_port                   = string
      dest_port                  = string
      src_address                = string
      dest_address               = string
    })), [])
  }))
}