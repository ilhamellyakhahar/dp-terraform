data "terraform_remote_state" "bootstrap" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-research-terraform"
    storage_account_name = "research9tfstate"     
    container_name       = "tfstate"
    key                  = "bootstrap.terraform.tfstate"
  }
}

module "vm" {
  source              = "../../modules/vm"
  vm_name             = var.vm_name
  resource_group_name = data.terraform_remote_state.bootstrap.outputs.resource_group_name
  location            = data.terraform_remote_state.bootstrap.outputs.location    
  subnet_id           = data.terraform_remote_state.bootstrap.outputs.subnet_id   
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disk_name           = var.disk_name
  disk_size_gb        = var.disk_size_gb
  disk_sku            = var.disk_sku
  caching             = var.caching
  lun                 = var.lun
}