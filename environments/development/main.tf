# data "terraform_remote_state" "bootstrap" {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = "rg-research-terraform"
#     storage_account_name = "research9tfstate"
#     container_name       = "tfstate"
#     key                  = "bootstrap.terraform.tfstate"
#   }
# }

module "network" {
  source       = "../../modules/network"
  project_name = var.project_name
  location     = var.location
  rg_name      = var.rg_name
  space        = var.space
  subnets      = var.subnets
  enable_ngw   = var.enable_ngw
}

module "compute" {
  source = "../../modules/compute"
  vms = [
    for vm in var.vms : {
      vm_name      = vm.vm_name
      vm_user      = vm.vm_user
      vm_pass      = vm.vm_pass
      vm_size      = vm.vm_size
      subnet       = vm.subnet
      disk_name    = vm.disk_name
      disk_size    = vm.disk_size
      disk_sku     = vm.disk_sku
      caching      = vm.caching
      lun          = vm.lun
      os_publisher = vm.os_publisher
      os_offer     = vm.os_offer
      os_sku       = vm.os_sku
      os_version   = vm.os_version
      encryption   = try(vm.encryption, null)
      ephemeral    = try(vm.ephemeral, false)
      location     = vm.location
      rg_name      = vm.rg_name
      nsg_name     = try(vm.nsg_name, null)
      sec_rules    = try(vm.sec_rules, [])
      public_ip    = try(vm.public_ip, true)
      ssh_key      = try(vm.ssh_key, null)
    }
  ]
}
