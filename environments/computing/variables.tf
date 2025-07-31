variable "subs_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "username" {
  description = "Username for the VM"
  type        = string
}

variable "password" {
  description = "Password for the VM user"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
  default     = "southeastasia"
}

variable "public_ip" {
  description = "Enable public IP for the VM"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Size of the disk in GB"
  type        = number
  default     = 32
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-ilhamellya"
}

variable "sec_rules" {
  description = "NSG rules"
  type = list(object({
    name         = string
    priority     = number
    direction    = string
    access       = string
    protocol     = string
    src_port     = string
    dest_port    = string
    src_address  = string
    dest_address = string
  }))

  default = [
    {
      name         = "Allow-SSH"
      priority     = 100
      direction    = "Inbound"
      access       = "Allow"
      protocol     = "Tcp"
      src_port     = "*"
      dest_port    = "22"
      src_address  = "4.194.148.36"
      dest_address = "*"
    }
  ]
}

variable "vms" {
  description = "List of VM definitions"
  type = list(object({
    vm_name       = string
    vm_user       = string
    vm_pass       = string
    vm_size       = string
    subnet        = string
    disk_name     = optional(string)
    disk_size     = optional(number)
    disk_sku      = string
    caching       = string
    lun           = optional(number)
    os_publisher  = string
    os_offer      = string
    os_sku        = string
    os_version    = string
    encryption    = optional(string)
    ephemeral     = optional(bool, false)
    location      = string
    rg_name       = string
    nsg_name      = optional(string)
    sec_rules     = optional(list(object({
      name        = string
      priority    = number
      direction   = string
      access      = string
      protocol    = string
      src_port    = string
      dest_port   = string
      src_address = string
      dest_address= string
    })), [])
    public_ip    = optional(bool, true)
    ssh_key      = optional(string)
  }))

  default = [
    {
      vm_name      = "vm-compute"
      vm_user      = "azureuser"
      vm_pass      = "P@ssw0rd1234!"
      vm_size      = "Standard_B2s"
      subnet       = "<placeholder>"
      disk_name    = "disk"
      disk_size    = 32
      disk_sku     = "Standard_LRS"
      caching      = "ReadWrite"
      lun          = 0
      os_publisher = "Canonical"
      os_offer     = "ubuntu-24_04-lts"
      os_sku       = "server"
      os_version   = "latest"
      location     = "southeastasia"
      rg_name      = "rg-ilhamellya"
      nsg_name     = "nsg-compute"
      sec_rules = [
        {
          name        = "Allow-SSH"
          priority    = 100
          direction   = "Inbound"
          access      = "Allow"
          protocol    = "Tcp"
          src_port    = "*"
          dest_port   = "22"
          src_address = "4.194.148.36"
          dest_address= "*"
        }
      ]
      public_ip = true
    }
  ]
}
