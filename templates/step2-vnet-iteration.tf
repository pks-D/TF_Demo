locals {
  vnet_names = ["terraform-vnet1", "terraform-vnet2", "terraform-vnet3"]
  vnet_config = {
    "terraform-vnet1" = {
      address_space = ["10.0.0.0/24"]
    }
    "terraform-vnet2" = {
      address_space = ["10.0.0.0/24","10.0.0.1/24"]
    }
    "terraform-vnet3" = {
      address_space = ["10.0.0.0/24","10.0.0.1/24"]
    }
  }
}


resource "azurerm_resource_group" "simple_rg" {
  name     = "terraform-pks-dev"
  location = "west europe"
  tags = {
    environment = "dev"
    created_by  = "terraform"
  }
}
# Caso 1: Iterar sobre una lista de nombres de VNet
# resource "azurerm_virtual_network" "simple_vnet" {
#   for_each            = toset(local.vnet_names)
#   name                = each.value
#   address_space       = ["10.0.0.0/24"]
#   location            = azurerm_resource_group.simple_rg.location
#   resource_group_name = azurerm_resource_group.simple_rg.name
#   tags                = azurerm_resource_group.simple_rg.tags
# }

# Caso 2: Iterar sobre un mapa de configuraciones de VNet
# resource "azurerm_virtual_network" "simple_vnet" {
#   for_each            = local.vnet_config
#   name                = each.key
#   address_space       = each.value.address_space
#   location            = azurerm_resource_group.simple_rg.location
#   resource_group_name = azurerm_resource_group.simple_rg.name
#   tags                = azurerm_resource_group.simple_rg.tags
# }
