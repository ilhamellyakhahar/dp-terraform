terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ilhamellya"
    storage_account_name = "sailhamellya"
    container_name       = "tfstate"
    key                  = "computing.terraform.tfstate"
  }
}
