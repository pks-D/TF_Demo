# 1. Comentar dependecias 
resource "azurerm_resource_group" "simple_rg" {
  name = "terraform-pks-dev"
  location = "west europe"
  tags = {
    environment = "dev"
    created_by  = "terraform"
  }
}

resource "azurerm_virtual_network" "simple_vnet" {
  name                = "terraform-pks-dev"
  address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.simple_rg.location
    resource_group_name = azurerm_resource_group.simple_rg.name
    tags = azurerm_resource_group.simple_rg.tags
}