provider "azurerm" {
  features {}

    subscription_id = var.subs_id
}

data "terraform_remote_state" "networking" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-ilhamellya"
    storage_account_name = "sailhamellya"
    container_name       = "tfstate"
    key                  = "networking.terraform.tfstate"
  }
}
