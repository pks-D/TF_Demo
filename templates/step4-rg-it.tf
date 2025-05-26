locals {
  environments = {
    pro = {
      name = "terraform-pks-pro"
      tags = {
        environment = "pro"
        created_by  = "terraform"
      }
      address_space = ["10.0.0.0/16"]
    }
    dev = {
      name = "terraform-pks-dev"
      tags = {
        environment = "dev"
        created_by  = "terraform"
      }
      address_space = ["10.0.0.0/24"]
    }
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = local.environments
  name     = each.value.name
  location = "west europe"
  tags     = each.value.tags
}

resource "azurerm_virtual_network" "vnet" {
  for_each            = local.environments
  name                = each.value.name
  address_space       = each.value.address_space
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  tags                = azurerm_resource_group.rg[each.key].tags
}
