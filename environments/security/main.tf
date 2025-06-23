data "terraform_remote_state" "bootstrap" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-research-terraform"
    storage_account_name = "research9tfstate"
    container_name       = "tfstate"
    key                  = "bootstrap.terraform.tfstate"
  }
}

resource "azurerm_network_security_group" "nsg_vm" {
  name                = "nsg-vm-tf"
  location            = var.location
  resource_group_name = data.terraform_remote_state.bootstrap.outputs.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_assoc" {
  subnet_id                 = data.terraform_remote_state.bootstrap.outputs.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg_vm.id
}