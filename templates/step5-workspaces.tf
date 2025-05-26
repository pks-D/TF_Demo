variable "environment" {
  description = "The environment to deploy (e.g., pro, dev)"
  type        = string
  validation {
    condition     = contains(["pro", "dev"], var.environment)
    error_message = "El valor de environment debe ser 'pro' o 'dev'."
  }
}
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
  name     = local.environments[var.environment].name
  location = "west europe"
  tags     = local.environments[var.environment].tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.environments[var.environment].name
  address_space       = local.environments[var.environment].address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags
}