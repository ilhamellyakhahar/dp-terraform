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
  name                = var.nsg_name
  location            = data.terraform_remote_state.bootstrap.outputs.location
  resource_group_name = data.terraform_remote_state.bootstrap.outputs.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_assoc" {
  subnet_id                 = data.terraform_remote_state.bootstrap.outputs.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg_vm.id
}