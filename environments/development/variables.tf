variable "subs_id" {
  type = string
}

variable "rg_name" {
  type    = string
  default = "dev-rg"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "project_name" {
  type    = string
  default = "dev-project"
}

variable "space" {
  type    = list(string)
  default = ["10.1.0.0/16"]
}

variable "subnets" {
  type = list(object({
    name    = string
    address = string
  }))
  default = [
    { name = "subnet1", address = "10.1.1.0/24" },
    { name = "subnet2", address = "10.1.2.0/24" }
  ]
}

variable "enable_ngw" {
  type    = bool
  default = true
}

variable "vms" {
  description = "List of VM definitions"
  type = list(object({
    vm_name      = string
    vm_user      = string
    vm_pass      = string
    vm_size      = string
    subnet       = string
    disk_name    = string
    disk_size    = number
    disk_sku     = string
    caching      = string
    lun          = number
    os_publisher = string
    os_offer     = string
    os_sku       = string
    os_version   = string
    encryption   = optional(string)
    ephemeral    = optional(bool, false)
    location     = string
    rg_name      = string
    nsg_name     = optional(string)
    sec_rules    = optional(list(object({
      name         = string
      priority     = number
      direction    = string
      access       = string
      protocol     = string
      src_port     = string
      dest_port    = string
      src_address  = string
      dest_address = string
    })), [])
    public_ip    = optional(bool, true)
    ssh_key      = optional(string)
  }))
  default = [
    {
      vm_name    = "dev-vm1"
      vm_user    = "azureuser"
      vm_pass    = "P@ssw0rd!"
      vm_size    = "Standard_B2s"
      subnet     = "subnet1"
      disk_name  = "dev-disk1"
      disk_size  = 30
      disk_sku   = "Standard_LRS"
      caching    = "ReadWrite"
      lun        = 0
      os_publisher = "Canonical"
      os_offer   = "UbuntuServer"
      os_sku     = "18.04-LTS"
      os_version = "latest"
      location   = "eastus2"
      rg_name    = "dev-rg"
      public_ip  = true
    }
  ]
}
