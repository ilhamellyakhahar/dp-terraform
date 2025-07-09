data "terraform_remote_state" "bootstrap" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-research-terraform"
    storage_account_name = "research9tfstate"
    container_name       = "tfstate"
    key                  = "bootstrap.terraform.tfstate"
  }
}

module "networking" {
  source              = "../../modules/networking"
  project_name        = var.project_name
  location            = data.terraform_remote_state.bootstrap.outputs.location
  resource_group_name = data.terraform_remote_state.bootstrap.outputs.resource_group_name
  address_space       = var.address_space
  subnets             = var.subnets
  enable_nat_gateway  = var.enable_nat_gateway
}

module "vm" {
  source = "../../modules/vm"
  vms = [
    for vm in var.vms : {
      name                    = vm.name
      admin_username          = vm.admin_username
      admin_password          = vm.admin_password
      vm_size                 = vm.vm_size
      subnet_id               = module.networking.subnet_ids[vm.subnet_name]
      disk_name               = vm.disk_name
      disk_size_gb            = vm.disk_size_gb
      disk_sku                = vm.disk_sku
      caching                 = vm.caching
      lun                     = vm.lun
      os_publisher            = vm.os_publisher
      os_offer                = vm.os_offer
      os_sku                  = vm.os_sku
      os_version              = vm.os_version
      disk_encryption_set_id  = try(vm.disk_encryption_set_id, null)
      use_ephemeral_os_disk   = try(vm.use_ephemeral_os_disk, false)
      location                = data.terraform_remote_state.bootstrap.outputs.location
      resource_group_name     = data.terraform_remote_state.bootstrap.outputs.resource_group_name
      nsg_name                = try(vm.nsg_name, null)
      security_rules          = try(vm.security_rules, [])
    }
  ]
}