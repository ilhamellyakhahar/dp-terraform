terraform {
  backend "azurerm" {
    resource_group_name  = "rg-test"
    storage_account_name = "research9tfstate"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
