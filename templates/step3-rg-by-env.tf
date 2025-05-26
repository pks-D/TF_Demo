resource "azurerm_resource_group" "dev" {
  name = "terraform-pks-dev"
  location = "west europe"
  tags = {
    environment = "dev"
    created_by  = "terraform"
  }
}

resource "azurerm_virtual_network" "dev" {
  name                = "terraform-pks-dev"
  address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.dev.location
    resource_group_name = azurerm_resource_group.dev.name
    tags = azurerm_resource_group.dev.tags
}

resource "azurerm_resource_group" "pro" {
  name = "terraform-pks-pro"
  location = "west europe"
  tags = {
    environment = "pro"
    created_by  = "terraform"
  }
}

resource "azurerm_virtual_network" "pro" {
  name                = "terraform-pks-pro"
  address_space       = ["10.0.0.0/24"]
    location            = azurerm_resource_group.pro.location
    resource_group_name = azurerm_resource_group.pro.name
    tags = azurerm_resource_group.pro.tags
}