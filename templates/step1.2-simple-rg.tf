resource "azurerm_resource_group" "simple_rg" {
  name = module.naming.resource_group.name
  location = "west europe"
  tags = {
    environment = "dev"
    created_by  = "terraform"
  }
}

resource "azurerm_virtual_network" "simple_vnet" {
  name                = module.naming.virtual_network.name
  address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.simple_rg.location
    resource_group_name = azurerm_resource_group.simple_rg.name
    tags = azurerm_resource_group.simple_rg.tags
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix = [ "terraform" ]
  prefix = [ "pks" ]
}