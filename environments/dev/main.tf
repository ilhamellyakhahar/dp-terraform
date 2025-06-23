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
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = data.terraform_remote_state.bootstrap.outputs.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}