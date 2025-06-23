terraform {
  backend "azurerm" {
    resource_group_name  = "rg-research-terraform"
    storage_account_name = "research9tfstate"
    container_name       = "tfstate"
    key                  = "security.terraform.tfstate"
  }
}