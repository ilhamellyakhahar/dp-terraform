locals {
  vnet_name = "${var.project_name}-vnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  address_space       = var.space
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "subnet" {
  for_each = { for s in var.subnets : s.name => s }
  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address]
}

resource "azurerm_public_ip" "nat" {
  count               = var.enable_ngw ? 1 : 0
  name                = "${local.vnet_name}-nat-ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat" {
  count               = var.enable_ngw ? 1 : 0
  name                = "${local.vnet_name}-nat"
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "Standard"
  public_ip_address_ids = var.enable_ngw ? [azurerm_public_ip.nat[0].id] : []
}

resource "azurerm_subnet_nat_gateway_association" "nat_assoc" {
  for_each = var.enable_ngw ? azurerm_subnet.subnet : {}
  subnet_id      = each.value.id
  nat_gateway_id = azurerm_nat_gateway.nat[0].id
}