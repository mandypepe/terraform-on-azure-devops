# Resource-1: Create aplication gateway  Subnet
resource "azurerm_subnet" "agsubnet" {
  name                 = "agsubnet-${local.resource_name_prefix}"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = var.ag_subnet_address
}

# Resource-2: Create aplication gateway   Network Security Group (NSG)
resource "azurerm_network_security_group" "ag_subnet_nsg" {
  name                = "agnsg-${local.resource_name_prefix}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

}

# Resource-3: Associate aplication gateway   NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "ag_subnet_nsg" {
  depends_on = [azurerm_network_security_rule.ag_subnet_nsg_rule_inbound]
  subnet_id                 = azurerm_subnet.agsubnet.id
  network_security_group_id = azurerm_network_security_group.ag_subnet_nsg.id
}


# Resource-4: Create NSG Rules
## Locals Block for Security Rules
locals{
  ag_inbound_ports_map = {
    "100" : "80"
    "110" = "443"
    "130" = "65200-65535"
  }
}

## NSG inbound rules for azuure application gateway subnet

resource "azurerm_network_security_rule" "ag_subnet_nsg_rule_inbound" {
  for_each = local.ag_inbound_ports_map
  name                       = "${each.key}"
  resource_group_name        = data.azurerm_resource_group.rg.name

  priority                   = each.key
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = each.value
  source_address_prefix      = "*"
  network_security_group_name = azurerm_network_security_group.ag_subnet_nsg.name
  destination_address_prefix = "*"

}






